module plotly

// This is the main module file for the plotly.v wrapper
// It provides the main functionality for creating and displaying plots

/*
The plotly.v module is a wrapper around the plotly.js JavaScript library.
It provides a set of functions and structures to create interactive plots
in the V programming language.

This module aims to be similar to the Python and R wrappers for plotly.js,
but with V-specific features and idioms.
*/
import os
import x.json2 as json

// Figure represents a plotly figure with data and layout
pub struct Figure {
pub mut:
	data   []map[string]json.Any
	layout map[string]json.Any
	config map[string]json.Any
}

// new_figure creates a new Figure instance with empty data and layout
pub fn new_figure() Figure {
	return Figure{
		data:   []map[string]json.Any{}
		layout: map[string]json.Any{}
		config: {
			'responsive':     json.Any(true)
			'displayModeBar': json.Any(true)
			'scrollZoom':     json.Any(true)
		}
	}
}

// add_trace adds a trace (data series) to the figure
pub fn (mut fig Figure) add_trace(trace map[string]json.Any) {
	fig.data << trace
}

// update_layout updates the layout properties of the figure
pub fn (mut fig Figure) update_layout(layout map[string]json.Any) {
	for key, value in layout {
		fig.layout[key] = value
	}
}

// update_config updates the configuration of the figure
pub fn (mut fig Figure) update_config(config map[string]json.Any) {
	for key, value in config {
		fig.config[key] = value
	}
}

// to_json converts the figure to a JSON string
pub fn (fig Figure) to_json() string {
	// Handle data array specially to avoid encoding issues
	mut data_json_parts := []string{}
	for trace in fig.data {
		data_json_parts << json.encode(trace)
	}
	data_json := '[${data_json_parts.join(',')}]'

	layout_json := json.encode(fig.layout)

	// We need to handle modeBarButtonsToAdd specially if it exists
	mut config_copy := fig.config.clone()

	if 'modeBarButtonsToAdd' in config_copy {
		// We're just removing it from the copy, no need to save the value
		config_copy.delete('modeBarButtonsToAdd')
	}

	config_json := json.encode(config_copy)

	return '{"data":${data_json},"layout":${layout_json},"config":${config_json}}'
}

// show displays the figure in a web browser
pub fn (fig Figure) show() {
	// Create a temporary HTML file with the plotly.js library and the figure

	// Handle the data array manually to ensure proper JSON
	mut data_json_parts := []string{}
	for trace in fig.data {
		data_json_parts << json.encode(trace)
	}
	data_json := '[${data_json_parts.join(',')}]'

	// Process the layout
	layout_json := json.encode(fig.layout)

	// Handle the config with special processing for modeBarButtonsToAdd
	mut config_copy := fig.config.clone()
	mut buttons_json := ''

	if 'modeBarButtonsToAdd' in config_copy {
		buttons := config_copy['modeBarButtonsToAdd'] or { json.Any('[]') }
		buttons_json = buttons.str()
		config_copy.delete('modeBarButtonsToAdd')
	}

	mut config_json := json.encode(config_copy)
	// If config ends with } and buttons exist, insert them
	if config_json.ends_with('}') && buttons_json.len > 0 {
		config_json = config_json.substr(0, config_json.len - 1) + ',"modeBarButtonsToAdd":' +
			buttons_json + '}'
	}

	html := '<!DOCTYPE html>
<html>
<head>
	<title>Plotly V</title>
	<script src="https://cdn.plot.ly/plotly-3.0.1.min.js"></script>
	<style>
		body, html { margin: 0; padding: 0; height: 100%; }
		#plot { width: 90%; height: 80vh; margin: 0 auto; }
		.container { padding: 20px; }
	</style>
</head>
<body>
	<div class="container">
		<div id="plot"></div>
	</div>
	<script>
		// Wait for the page to load before plotting
		window.onload = function() {
			const data = ${data_json};
			const layout = ${layout_json};
			const config = ${config_json};
			Plotly.newPlot("plot", data, layout, config);
		};
	</script>
</body>
</html>' // Write the HTML to a temporary file

	tmp_dir := os.temp_dir()
	tmp_file := os.join_path_single(tmp_dir, 'plotly_v.html')

	os.write_file(tmp_file, html) or {
		eprintln('Failed to write to temporary file: ${err}')
		return
	}

	// Open the HTML file in the default browser
	os.system('open ${tmp_file}')
}

// save saves the figure to an HTML file
pub fn (fig Figure) save(filename string) ! {
	if !filename.ends_with('.html') {
		return error('Filename must end with .html')
	}

	// Handle the data array manually to ensure proper JSON
	mut data_json_parts := []string{}
	for trace in fig.data {
		data_json_parts << json.encode(trace)
	}
	data_json := '[${data_json_parts.join(',')}]'

	// Process the layout
	layout_json := json.encode(fig.layout)

	// Handle the config with special processing for modeBarButtonsToAdd
	mut config_copy := fig.config.clone()
	mut buttons_json := ''

	if 'modeBarButtonsToAdd' in config_copy {
		buttons := config_copy['modeBarButtonsToAdd'] or { json.Any('[]') }
		buttons_json = buttons.str()
		config_copy.delete('modeBarButtonsToAdd')
	}

	mut config_json := json.encode(config_copy)
	// If config ends with } and buttons exist, insert them
	if config_json.ends_with('}') && buttons_json.len > 0 {
		config_json = config_json.substr(0, config_json.len - 1) + ',"modeBarButtonsToAdd":' +
			buttons_json + '}'
	}

	html := '<!DOCTYPE html>
<html>
<head>
	<title>Plotly V</title>
	<script src="https://cdn.plot.ly/plotly-3.0.1.min.js"></script>
	<style>
		body, html { margin: 0; padding: 0; height: 100%; }
		#plot { width: 90%; height: 80vh; margin: 0 auto; }
		.container { padding: 20px; }
	</style>
</head>
<body>
	<div class="container">
		<div id="plot"></div>
	</div>
	<script>
		// Wait for the page to load before plotting
		window.onload = function() {
			const data = ${data_json};
			const layout = ${layout_json};
			const config = ${config_json};
			Plotly.newPlot("plot", data, layout, config);
		};
	</script>
</body>
</html>'

	os.write_file(filename, html) or { return error('Failed to write to file: ${err}') }

	return
}

// set_modebar_config configures the modebar in the plotly figure
pub fn (mut fig Figure) set_modebar_config(display bool, orientation string) {
	fig.config['displayModeBar'] = json.Any(display)
	if orientation in ['h', 'v'] {
		// Use orientation directly as it's already a string
		fig.config['modeBarOrientation'] = json.Any(orientation)
	}
}

// set_scroll_zoom enables or disables scroll zoom
pub fn (mut fig Figure) set_scroll_zoom(enabled bool) {
	fig.config['scrollZoom'] = json.Any(enabled)
}

// set_responsive makes the plot responsive to window resize
pub fn (mut fig Figure) set_responsive(responsive bool) {
	fig.config['responsive'] = json.Any(responsive)
}

// add_custom_button adds a custom button to the modebar
// name: The name/label for the button
// click_func: JavaScript function as a string (without quotes)
pub fn (mut fig Figure) add_custom_button(name string, icon_name string, click_func string) {
	// Define SVG icons for common button types
	icon_defs := {
		'home':    '{
			"width": 1000,
			"height": 1000,
			"path": "M500,10L10,500h160v490h290V690h80v300h290V500h160L500,10z",
			"transform": "matrix(1 0 0 -1 0 1000)"
		}'
		'refresh': '{
			"width": 857.1,
			"height": 1000,
			"path": "M429 696q-51 0-97.5-20t-81-53.5-54.5-80-19-97.5q0-50 20-96.5t53.5-81T330 214t96.5-20q75 0 140 40.5T648 331h-90q-35-36-75.5-55.5T383 256q-68 0-126 42.5T174 427h56v57H73V327h57v55q35-86 114.5-139T429 190q68 0 129.5 26T673 289t73 114 26 129.5-26 129-73 113.5-114.5 73-129.5 26q-89 0-166-45.5T150 625l46-46q28 66 86 104.5T429 722q69 0 128-34t93-93 34-127q0-40-11.5-77t-33.5-67.5-52-53-67-33.5V117h56v196H340V117h56v120q55 6 100.5 33.5T571 335h-64q-27-35-68.5-57T340 256q-36 0-68 13.5T216 304t-34.5 56-12.5 68q0 36 13.5 68t35 56 53.5 37.5 67 13.5q34 0 63.5-12t52.5-35h90q-32 53-84.5 82T429 696z",
			"transform": "matrix(1 0 0 -1 0 850)"
		}'
		'camera':  '{
			"width": 1000,
			"height": 1000,
			"path": "M500,833.3C381.8,833.3,285.4,736.9,285.4,618.8C285.4,500.6,381.8,404.2,500,404.2C618.2,404.2,714.6,500.6,714.6,618.8C714.6,736.9,618.2,833.3,500,833.3M500,333.3C343,333.3,214.6,461.7,214.6,618.8C214.6,775.8,343,904.2,500,904.2C657,904.2,785.4,775.8,785.4,618.8C785.4,461.7,657,333.3,500,333.3M858.3,416.7L808.3,375L775,416.7L825,458.3L858.3,416.7Z M541.7,208.3L541.7,166.7L458.3,166.7L458.3,208.3L216.7,208.3L216.7,750L341.7,750C366.5,783.4,402.2,809.1,444.3,821.7L543.7,821.7C585.8,809.1,621.5,783.4,646.2,750L783.3,750L783.3,208.3L541.7,208.3Z"
		}'
		'reset':   '{
			"width": 928.6,
			"height": 1000,
			"path": "M857.1 500v107.1q0 8.9-6.7 15.6t-15.6 6.7H571.4v214.3q0 8.9-6.7 15.6T549.1 866H392.9q-8.9 0-15.6-6.7t-6.7-15.6V629.5H107.1q-8.9 0-15.6-6.7t-6.7-15.6V500q0-8.9 6.7-15.6t15.6-6.7h263.5V263.4q0-8.9 6.7-15.6t15.6-6.7h156.3q8.9 0 15.6 6.7t6.7 15.6v214.3h263.5q8.9 0 15.6 6.7t6.7 15.6z",
			"transform": "matrix(1 0 0 -1 0 850)"
		}'
		'zoom':    '{
			"width": 1000,
			"height": 1000,
			"path": "M182 78h220v600H182V78z m876 600V78H708v600h350z M442 708v76H0v200h442v76l242-176-242-176z m350 176v-76h442V608H792v76L550 860l242 24z",
			"transform": "matrix(0.8 0 0 -0.8 0 850)"
		}'
	}

	// Select the icon - use home as default if not found
	icon_json := if icon_name in icon_defs {
		icon_defs[icon_name]
	} else {
		icon_defs['home']
	}

	// Create the button JSON with the function as a direct JavaScript object
	// The key is using a proper SVG path object for the icon
	button_json := '{"name":"${name}","icon":${icon_json},"click":${click_func}}'

	// Initialize modeBarButtonsToAdd if it doesn't exist
	if 'modeBarButtonsToAdd' !in fig.config {
		fig.config['modeBarButtonsToAdd'] = json.Any('[]')
	}

	// Get current buttons array
	mut buttons_str := fig.config['modeBarButtonsToAdd'] or { json.Any('[]') }

	// Remove the brackets to get just the contents
	mut content := buttons_str.str().trim_space()

	if content == '[]' {
		// Empty array, just add our button
		fig.config['modeBarButtonsToAdd'] = json.Any('[${button_json}]')
	} else {
		// Remove the outer brackets and add our button
		content = content.trim('[').trim(']').trim_space()
		if content.len > 0 {
			// There are existing items, append with a comma
			fig.config['modeBarButtonsToAdd'] = json.Any('[${content},${button_json}]')
		} else {
			// No existing items
			fig.config['modeBarButtonsToAdd'] = json.Any('[${button_json}]')
		}
	}
}

// add_reset_button is a convenience function to add a reset button
pub fn (mut fig Figure) add_reset_button() {
	// Add a reset button with a predefined icon and function
	reset_func := 'function() { console.log("Reset clicked"); Plotly.purge("plot"); Plotly.newPlot("plot", data, layout, config); }'
	fig.add_custom_button('Reset', 'refresh', reset_func)
}

// add_screenshot_button is a convenience function to add a screenshot button
pub fn (mut fig Figure) add_screenshot_button(filename string) {
	// Default filename if not provided
	fname := if filename == '' { 'plot_screenshot' } else { filename }

	// Add a screenshot button with a camera icon
	screenshot_func := 'function() { console.log("Screenshot clicked"); Plotly.downloadImage("plot", {format: "png", filename: "${fname}"}); }'
	fig.add_custom_button('Screenshot', 'camera', screenshot_func)
}

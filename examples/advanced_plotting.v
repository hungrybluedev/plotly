module main

import plotly
import x.json2 as json
import math

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Generate data for two lines with error bars
	mut x := []f64{}
	mut y1 := []f64{}
	mut y2 := []f64{}
	mut error1 := []f64{}
	mut error2 := []f64{}

	for i in 0 .. 50 {
		x_val := 0.1 * f64(i)
		x << x_val

		// First line: sin(x) with random error
		y_sin := math.sin(x_val)
		y1 << y_sin
		error1 << 0.1 * math.abs(y_sin) // 10% error

		// Second line: cos(x) with random error
		y_cos := math.cos(x_val)
		y2 << y_cos
		error2 << 0.15 * math.abs(y_cos) // 15% error
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y1_json := plotly.f64_array_to_json(y1)
	y2_json := plotly.f64_array_to_json(y2)
	error1_json := plotly.f64_array_to_json(error1)
	error2_json := plotly.f64_array_to_json(error2)

	// Create trace configuration for the first line
	mut trace1_config := plotly.new_trace_config(plotly.TraceType.scatter)
	trace1_config.set_name('Sine')
	trace1_config.set_mode('lines+markers')
	trace1_config.set_marker_color('#1f77b4') // Blue
	trace1_config.set_line_color('#1f77b4')
	trace1_config.set_line_width(2)
	trace1_config.set_error_y(error1_json, true)

	// Create the first trace
	mut trace1 := trace1_config.to_map()
	trace1['x'] = json.Any(x_json)
	trace1['y'] = json.Any(y1_json)

	// Create trace configuration for the second line
	mut trace2_config := plotly.new_trace_config(plotly.TraceType.scatter)
	trace2_config.set_name('Cosine')
	trace2_config.set_mode('lines+markers')
	trace2_config.set_marker_color('#ff7f0e') // Orange
	trace2_config.set_marker_symbol('square')
	trace2_config.set_line_color('#ff7f0e')
	trace2_config.set_line_width(2)
	trace2_config.set_line_dash('dash')
	trace2_config.set_error_y(error2_json, true)

	// Create the second trace
	mut trace2 := trace2_config.to_map()
	trace2['x'] = json.Any(x_json)
	trace2['y'] = json.Any(y2_json)

	// Add the traces to the figure
	fig.add_trace(trace1)
	fig.add_trace(trace2)

	// Create and configure the layout
	mut layout := plotly.new_layout()
	layout.set_title('Advanced Plotting Example')
	layout.set_axis_title('x', 'X Axis')
	layout.set_axis_title('y', 'Y Axis')
	layout.set_size(900, 600)
	layout.set_margin(80, 80, 100, 80, 10)
	layout.set_font('Arial, sans-serif', 12, '#333333')
	layout.set_background_color('#ffffff', '#f8f8f8')
	layout.set_hovermode('closest')

	// Update the figure layout
	fig.update_layout(layout.to_map())

	// Display the figure
	fig.show()
}

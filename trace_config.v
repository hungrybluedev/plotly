module plotly

import x.json2 as json

// TraceType enum represents the available plot types
pub enum TraceType {
	scatter
	bar
	histogram
	box
	heatmap
	contour
	pie
	line
	area
	violin
	waterfall
	scatter3d
	surface
}

// TraceConfig struct for configuring trace options
pub struct TraceConfig {
pub mut:
	type_        TraceType
	name         string
	visible      string = 'true'
	show_legend  bool   = true
	opacity      f64    = 1.0
	mode         string
	marker       map[string]json.Any
	line         map[string]json.Any
	error_x      map[string]json.Any
	error_y      map[string]json.Any
	fill         string
	fillcolor    string
	hoverinfo    string
	hoverlabel   map[string]json.Any
	text         []json.Any
	textposition string
}

// new_trace_config creates a new TraceConfig with default values
pub fn new_trace_config(type_ TraceType) TraceConfig {
	return TraceConfig{
		type_:      type_
		marker:     map[string]json.Any{}
		line:       map[string]json.Any{}
		error_x:    map[string]json.Any{}
		error_y:    map[string]json.Any{}
		hoverlabel: map[string]json.Any{}
		text:       []json.Any{}
	}
}

// to_map converts the TraceConfig to a map for JSON encoding
pub fn (tc TraceConfig) to_map() map[string]json.Any {
	mut config_map := map[string]json.Any{}

	// Set the trace type
	config_map['type'] = json.Any(tc.type_.str())

	// Set other fields if they have values
	if tc.name != '' {
		config_map['name'] = json.Any(tc.name)
	}

	config_map['visible'] = json.Any(tc.visible)
	config_map['showlegend'] = json.Any(tc.show_legend)

	if tc.opacity != 1.0 {
		config_map['opacity'] = json.Any(tc.opacity)
	}

	if tc.mode != '' {
		config_map['mode'] = json.Any(tc.mode)
	}

	if tc.marker.len > 0 {
		config_map['marker'] = json.Any(tc.marker)
	}

	if tc.line.len > 0 {
		config_map['line'] = json.Any(tc.line)
	}

	if tc.error_x.len > 0 {
		config_map['error_x'] = json.Any(tc.error_x)
	}

	if tc.error_y.len > 0 {
		config_map['error_y'] = json.Any(tc.error_y)
	}

	if tc.fill != '' {
		config_map['fill'] = json.Any(tc.fill)
	}

	if tc.fillcolor != '' {
		config_map['fillcolor'] = json.Any(tc.fillcolor)
	}

	if tc.hoverinfo != '' {
		config_map['hoverinfo'] = json.Any(tc.hoverinfo)
	}

	if tc.hoverlabel.len > 0 {
		config_map['hoverlabel'] = json.Any(tc.hoverlabel)
	}

	if tc.text.len > 0 {
		config_map['text'] = json.Any(tc.text)
	}

	if tc.textposition != '' {
		config_map['textposition'] = json.Any(tc.textposition)
	}

	return config_map
}

// set_name sets the name for the trace
pub fn (mut tc TraceConfig) set_name(name string) {
	tc.name = name
}

// set_visible sets whether the trace is visible
pub fn (mut tc TraceConfig) set_visible(visible bool) {
	if visible {
		tc.visible = 'true'
	} else {
		tc.visible = 'false'
	}
}

// set_opacity sets the opacity for the trace
pub fn (mut tc TraceConfig) set_opacity(opacity f64) {
	tc.opacity = opacity
}

// set_mode sets the drawing mode for scatter traces (markers, lines, text)
pub fn (mut tc TraceConfig) set_mode(mode string) {
	tc.mode = mode
}

// set_marker_color sets the color for markers
pub fn (mut tc TraceConfig) set_marker_color(color string) {
	tc.marker['color'] = json.Any(color)
}

// set_marker_size sets the size for markers
pub fn (mut tc TraceConfig) set_marker_size(size int) {
	tc.marker['size'] = json.Any(size)
}

// set_marker_symbol sets the symbol for markers
pub fn (mut tc TraceConfig) set_marker_symbol(symbol string) {
	tc.marker['symbol'] = json.Any(symbol)
}

// set_line_color sets the color for lines
pub fn (mut tc TraceConfig) set_line_color(color string) {
	tc.line['color'] = json.Any(color)
}

// set_line_width sets the width for lines
pub fn (mut tc TraceConfig) set_line_width(width int) {
	tc.line['width'] = json.Any(width)
}

// set_line_dash sets the dash style for lines (solid, dot, dash, longdash, dashdot, longdashdot)
pub fn (mut tc TraceConfig) set_line_dash(dash string) {
	tc.line['dash'] = json.Any(dash)
}

// set_error_x sets the x error bars
pub fn (mut tc TraceConfig) set_error_x(array []json.Any, visible bool) {
	tc.error_x['array'] = json.Any(array)
	tc.error_x['visible'] = json.Any(visible)
}

// set_error_y sets the y error bars
pub fn (mut tc TraceConfig) set_error_y(array []json.Any, visible bool) {
	tc.error_y['array'] = json.Any(array)
	tc.error_y['visible'] = json.Any(visible)
}

// set_fill sets the fill area (none, tozeroy, tozerox, tonexty, tonextx, etc.)
pub fn (mut tc TraceConfig) set_fill(fill string) {
	tc.fill = fill
}

// set_fillcolor sets the color for the fill area
pub fn (mut tc TraceConfig) set_fillcolor(color string) {
	tc.fillcolor = color
}

// set_hoverinfo sets what information appears on hover
pub fn (mut tc TraceConfig) set_hoverinfo(info string) {
	tc.hoverinfo = info
}

// set_hoverlabel_bgcolor sets the background color for hover labels
pub fn (mut tc TraceConfig) set_hoverlabel_bgcolor(color string) {
	tc.hoverlabel['bgcolor'] = json.Any(color)
}

// set_hoverlabel_font sets the font for hover labels
pub fn (mut tc TraceConfig) set_hoverlabel_font(family string, size int, color string) {
	tc.hoverlabel['font'] = json.Any({
		'family': json.Any(family)
		'size':   json.Any(size)
		'color':  json.Any(color)
	})
}

// set_text sets the text for the trace
pub fn (mut tc TraceConfig) set_text(text []string) {
	tc.text = []json.Any{}
	for t in text {
		tc.text << json.Any(t)
	}
}

// set_textposition sets the position of text (inside, outside, auto, etc.)
pub fn (mut tc TraceConfig) set_textposition(position string) {
	tc.textposition = position
}

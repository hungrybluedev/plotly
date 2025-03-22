module plotly

import x.json2 as json

// Layout struct for defining plot layouts
pub struct Layout {
pub mut:
	title         string
	showlegend    bool
	xaxis         map[string]json.Any
	yaxis         map[string]json.Any
	width         int
	height        int
	font          map[string]json.Any
	margin        map[string]json.Any
	paper_bgcolor string
	plot_bgcolor  string
	hovermode     string
	barmode       string
	boxmode       string
}

// new_layout creates a new Layout with default values
pub fn new_layout() Layout {
	return Layout{
		title:         ''
		showlegend:    true
		xaxis:         map[string]json.Any{}
		yaxis:         map[string]json.Any{}
		width:         800
		height:        600
		font:          map[string]json.Any{}
		margin:        map[string]json.Any{}
		paper_bgcolor: '#ffffff'
		plot_bgcolor:  '#ffffff'
		hovermode:     'closest'
		barmode:       'group'
		boxmode:       'group'
	}
}

// to_map converts the Layout struct to a map for JSON encoding
pub fn (l Layout) to_map() map[string]json.Any {
	mut layout_map := map[string]json.Any{}

	// Set fields if they have values
	if l.title != '' {
		layout_map['title'] = json.Any(l.title)
	}

	layout_map['showlegend'] = json.Any(l.showlegend)

	if l.xaxis.len > 0 {
		layout_map['xaxis'] = json.Any(l.xaxis)
	}

	if l.yaxis.len > 0 {
		layout_map['yaxis'] = json.Any(l.yaxis)
	}

	if l.width > 0 {
		layout_map['width'] = json.Any(l.width)
	}

	if l.height > 0 {
		layout_map['height'] = json.Any(l.height)
	}

	if l.font.len > 0 {
		layout_map['font'] = json.Any(l.font)
	}

	if l.margin.len > 0 {
		layout_map['margin'] = json.Any(l.margin)
	}

	if l.paper_bgcolor != '#ffffff' {
		layout_map['paper_bgcolor'] = json.Any(l.paper_bgcolor)
	}

	if l.plot_bgcolor != '#ffffff' {
		layout_map['plot_bgcolor'] = json.Any(l.plot_bgcolor)
	}

	if l.hovermode != 'closest' {
		layout_map['hovermode'] = json.Any(l.hovermode)
	}

	if l.barmode != 'group' {
		layout_map['barmode'] = json.Any(l.barmode)
	}

	if l.boxmode != 'group' {
		layout_map['boxmode'] = json.Any(l.boxmode)
	}

	return layout_map
}

// set_title sets the title for the layout
pub fn (mut l Layout) set_title(title string) {
	l.title = title
}

// set_axis_title sets the title for an axis (x or y)
pub fn (mut l Layout) set_axis_title(axis string, title string) {
	if axis == 'x' {
		if 'title' !in l.xaxis {
			l.xaxis['title'] = json.Any(title)
		} else {
			mut title_map := (l.xaxis['title'] or {
				map[string]json.Any{}
			}) as map[string]json.Any
			title_map['text'] = json.Any(title)
			l.xaxis['title'] = json.Any(title_map)
		}
	} else if axis == 'y' {
		if 'title' !in l.yaxis {
			l.yaxis['title'] = json.Any(title)
		} else {
			mut title_map := (l.yaxis['title'] or {
				map[string]json.Any{}
			}) as map[string]json.Any
			title_map['text'] = json.Any(title)
			l.yaxis['title'] = json.Any(title_map)
		}
	}
}

// set_size sets the width and height of the figure
pub fn (mut l Layout) set_size(width int, height int) {
	l.width = width
	l.height = height
}

// set_margin sets the margins for the figure
pub fn (mut l Layout) set_margin(left int, right int, top int, bottom int, pad int) {
	l.margin = {
		'l':   json.Any(left)
		'r':   json.Any(right)
		't':   json.Any(top)
		'b':   json.Any(bottom)
		'pad': json.Any(pad)
	}
}

// set_axis_range sets the range for an axis (x or y)
pub fn (mut l Layout) set_axis_range(axis string, min f64, max f64) {
	if axis == 'x' {
		l.xaxis['range'] = json.Any([json.Any(min), json.Any(max)])
	} else if axis == 'y' {
		l.yaxis['range'] = json.Any([json.Any(min), json.Any(max)])
	}
}

// set_font sets the font properties for the figure
pub fn (mut l Layout) set_font(family string, size int, color string) {
	l.font = {
		'family': json.Any(family)
		'size':   json.Any(size)
		'color':  json.Any(color)
	}
}

// set_background_color sets the background colors for the figure
pub fn (mut l Layout) set_background_color(paper string, plot string) {
	l.paper_bgcolor = paper
	l.plot_bgcolor = plot
}

// set_barmode sets the mode for bar charts (group, stack, overlay, relative)
pub fn (mut l Layout) set_barmode(mode string) {
	l.barmode = mode
}

// set_boxmode sets the mode for box plots (group, overlay)
pub fn (mut l Layout) set_boxmode(mode string) {
	l.boxmode = mode
}

// set_hovermode sets the hover mode (closest, x, y, false)
pub fn (mut l Layout) set_hovermode(mode string) {
	l.hovermode = mode
}

module plotly

import x.json2 as json

// scatter creates a scatter plot trace
pub fn scatter(x []json.Any, y []json.Any, name string, text []json.Any) map[string]json.Any {
	return {
		'type':   json.Any('scatter')
		'x':      json.Any(x)
		'y':      json.Any(y)
		'name':   json.Any(name)
		'mode':   json.Any('markers')
		'text':   json.Any(text)
		'marker': json.Any({
			'size': json.Any(10)
		})
	}
}

// line creates a line plot trace
pub fn line(x []json.Any, y []json.Any, name string, text []json.Any) map[string]json.Any {
	return {
		'type': json.Any('scatter')
		'x':    json.Any(x)
		'y':    json.Any(y)
		'name': json.Any(name)
		'mode': json.Any('lines')
		'text': json.Any(text)
		'line': json.Any({
			'width': json.Any(2)
		})
	}
}

// bar creates a bar plot trace
pub fn bar(x []json.Any, y []json.Any, name string, text []json.Any) map[string]json.Any {
	return {
		'type': json.Any('bar')
		'x':    json.Any(x)
		'y':    json.Any(y)
		'name': json.Any(name)
		'text': json.Any(text)
	}
}

// histogram creates a histogram trace
pub fn histogram(x []json.Any, name string, text []json.Any) map[string]json.Any {
	return {
		'type': json.Any('histogram')
		'x':    json.Any(x)
		'name': json.Any(name)
		'text': json.Any(text)
	}
}

// box creates a box plot trace
pub fn box(y []json.Any, name string, text []json.Any) map[string]json.Any {
	return {
		'type': json.Any('box')
		'y':    json.Any(y)
		'name': json.Any(name)
		'text': json.Any(text)
	}
}

// heatmap creates a heatmap trace
pub fn heatmap(z [][]json.Any, x []json.Any, y []json.Any, text []json.Any) map[string]json.Any {
	// Convert z data to JSON string manually to avoid casting issues
	mut z_rows := []string{}
	for row in z {
		mut row_values := []string{}
		for val in row {
			row_values << val.str()
		}
		z_rows << '[' + row_values.join(',') + ']'
	}
	z_json_str := '[' + z_rows.join(',') + ']'

	// Create a map with the proper data
	mut result := map[string]json.Any{}
	result['type'] = json.Any('heatmap')
	result['x'] = json.Any(x)
	result['y'] = json.Any(y)
	result['z'] = json.Any(z_json_str)
	result['colorscale'] = json.Any('Viridis')
	result['text'] = json.Any(text)

	return result
}

// contour creates a contour plot trace
pub fn contour(z [][]json.Any, x []json.Any, y []json.Any, text []json.Any) map[string]json.Any {
	// Convert z data to JSON string manually to avoid casting issues
	mut z_rows := []string{}
	for row in z {
		mut row_values := []string{}
		for val in row {
			row_values << val.str()
		}
		z_rows << '[' + row_values.join(',') + ']'
	}
	z_json_str := '[' + z_rows.join(',') + ']'

	// Create a map with the proper data
	mut result := map[string]json.Any{}
	result['type'] = json.Any('contour')
	result['x'] = json.Any(x)
	result['y'] = json.Any(y)
	result['z'] = json.Any(z_json_str)
	result['text'] = json.Any(text)

	return result
}

// pie creates a pie chart trace
pub fn pie(labels []json.Any, values []json.Any, text []json.Any) map[string]json.Any {
	return {
		'type':   json.Any('pie')
		'labels': json.Any(labels)
		'values': json.Any(values)
		'text':   json.Any(text)
	}
}

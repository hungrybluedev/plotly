module main

import plotly
import x.json2 as json
import math

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Generate x and y data for sine and cosine waves
	mut x := []f64{}
	mut y_sin := []f64{}
	mut y_cos := []f64{}

	for i in 0 .. 100 {
		x_val := 0.1 * f64(i)
		x << x_val
		y_sin << math.sin(x_val)
		y_cos << math.cos(x_val)
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y_sin_json := plotly.f64_array_to_json(y_sin)
	y_cos_json := plotly.f64_array_to_json(y_cos)

	// Create line traces for sine and cosine
	sin_trace := plotly.line(x_json, y_sin_json, 'Sine')
	cos_trace := plotly.line(x_json, y_cos_json, 'Cosine')

	// Add the traces to the figure
	fig.add_trace(sin_trace)
	fig.add_trace(cos_trace)

	// Update the layout with a title and legend
	fig.update_layout({
		'title':  json.Any('Sine and Cosine Example')
		'xaxis':  json.Any({
			'title': json.Any('X')
		})
		'yaxis':  json.Any({
			'title': json.Any('Value')
		})
		'legend': json.Any({
			'title': json.Any('Functions')
		})
	})

	// Display the figure
	fig.show()
}

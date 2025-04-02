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
	mut text_sin := []string{}
	mut text_cos := []string{}

	for i in 0 .. 100 {
		x_val := 0.1 * f64(i)
		x << x_val
		y_sin_val := math.sin(x_val)
		y_cos_val := math.cos(x_val)
		y_sin << y_sin_val
		y_cos << y_cos_val
		text_sin << 'sin(${x_val:.2f}) = ${y_sin_val:.2f}'
		text_cos << 'cos(${x_val:.2f}) = ${y_cos_val:.2f}'
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y_sin_json := plotly.f64_array_to_json(y_sin)
	y_cos_json := plotly.f64_array_to_json(y_cos)
	text_sin_json := plotly.string_array_to_json(text_sin)
	text_cos_json := plotly.string_array_to_json(text_cos)

	// Create line traces for sine and cosine
	sin_trace := plotly.line(x_json, y_sin_json, 'Sine', text_sin_json)
	cos_trace := plotly.line(x_json, y_cos_json, 'Cosine', text_cos_json)

	// Add the traces to the figure
	fig.add_trace(sin_trace)
	fig.add_trace(cos_trace)

	// Update the layout with a title and legend
	fig.update_layout({
		'title':  json.Any({
			'text': json.Any('Sine and Cosine Example')
		})
		'xaxis':  json.Any({
			'title': json.Any({
				'text': json.Any('X')
			})
		})
		'yaxis':  json.Any({
			'title': json.Any({
				'text': json.Any('Value')
			})
		})
		'legend': json.Any({
			'title': json.Any({
				'text': json.Any('Functions')
			})
		})
	})

	// Display the figure
	fig.show()
}

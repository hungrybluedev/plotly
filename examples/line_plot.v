module main

import plotly
import x.json2 as json
import math

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Generate x and y data for a sine wave
	mut x := []f64{}
	mut y := []f64{}
	mut text := []string{}

	for i in 0 .. 100 {
		x_val := 0.1 * f64(i)
		x << x_val
		y_val := math.sin(x_val)
		y << y_val
		text << 'sin(${x_val:.2f})=${y_val:.2f}'
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y_json := plotly.f64_array_to_json(y)
	text_json := plotly.string_array_to_json(text)

	// Create a line trace
	trace := plotly.line(x_json, y_json, 'Sine Wave', text_json)

	// Add the trace to the figure
	fig.add_trace(trace)

	// Update the layout with a title
	fig.update_layout({
		'title': json.Any({
			'text': json.Any('Sine Wave Example')
		})
		'xaxis': json.Any({
			'title': json.Any({
				'text': json.Any('X')
			})
		})
		'yaxis': json.Any({
			'title': json.Any({
				'text': json.Any('sin(x)')
			})
		})
	})

	// Display the figure
	fig.show()
}

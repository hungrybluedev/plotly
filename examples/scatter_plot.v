module main

import plotly
import x.json2 as json

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Create x and y data
	x := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	y := [5, 3, 8, 4, 7, 6, 9, 2, 10, 5]
	mut text := []string{len: x.len, init: 'Point ${index + 1}'}

	// Convert data to json.Any arrays
	x_json := plotly.int_array_to_json(x)
	y_json := plotly.int_array_to_json(y)
	text_json := plotly.string_array_to_json(text)

	// Create a scatter trace
	trace := plotly.scatter(x_json, y_json, 'Example Scatter', text_json)

	// Add the trace to the figure
	fig.add_trace(trace)

	// Update the layout with a title
	fig.update_layout({
		'title': json.Any({
			'text': json.Any('Scatter Plot Example')
		})
		'xaxis': json.Any({
			'title': json.Any({
				'text': json.Any('X Axis')
			})
		})
		'yaxis': json.Any({
			'title': json.Any({
				'text': json.Any('Y Axis')
			})
		})
	})

	// Display the figure
	fig.show()
}

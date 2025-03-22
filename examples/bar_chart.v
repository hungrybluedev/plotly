module main

import plotly
import x.json2 as json

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Create x and y data
	x := ['A', 'B', 'C', 'D', 'E']
	y := [10, 15, 8, 12, 7]

	// Convert data to json.Any arrays
	x_json := plotly.string_array_to_json(x)
	y_json := plotly.int_array_to_json(y)

	// Create a bar trace
	trace := plotly.bar(x_json, y_json, 'Example Bar')

	// Add the trace to the figure
	fig.add_trace(trace)

	// Update the layout with a title
	fig.update_layout({
		'title': json.Any('Bar Chart Example')
		'xaxis': json.Any({
			'title': json.Any('Categories')
		})
		'yaxis': json.Any({
			'title': json.Any('Values')
		})
	})

	// Display the figure
	fig.show()
}

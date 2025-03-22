module main

import plotly
import x.json2 as json
import math

fn main() {
	// Create a new figure
	mut fig := plotly.new_figure()

	// Generate x, y, and z data for a 2D grid
	mut x := []f64{}
	mut y := []f64{}
	mut z := [][]f64{}

	// Create x and y values
	for i in 0 .. 20 {
		x << f64(i) * 0.5
	}

	for i in 0 .. 20 {
		y << f64(i) * 0.5
	}

	// Create z values (2D array)
	for i in 0 .. 20 {
		mut z_row := []f64{}
		for j in 0 .. 20 {
			z_row << math.sin(x[i]) * math.cos(y[j])
		}
		z << z_row
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y_json := plotly.f64_array_to_json(y)
	z_json := plotly.f64_2d_array_to_json(z)

	// Create a heatmap trace
	trace := plotly.heatmap(z_json, x_json, y_json)

	// Add the trace to the figure
	fig.add_trace(trace)

	// Update the layout with a title
	fig.update_layout({
		'title': json.Any('Heatmap Example')
		'xaxis': json.Any({
			'title': json.Any('X')
		})
		'yaxis': json.Any({
			'title': json.Any('Y')
		})
	})

	// Display the figure
	fig.show()
}

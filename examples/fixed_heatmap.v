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

	// Create x and y values (0 to 10 in 0.5 steps)
	for i in 0 .. 21 {
		x << f64(i) * 0.5
	}

	for i in 0 .. 21 {
		y << f64(i) * 0.5
	}

	// Create z values as 2D array - using a mathematical function for the pattern
	for j in 0 .. y.len {
		mut z_row := []f64{}
		for i in 0 .. x.len {
			// Create an interesting pattern: sin(x) * cos(y)
			z_row << math.sin(x[i]) * math.cos(y[j])
		}
		z << z_row
	}

	// Convert data to json.Any arrays
	x_json := plotly.f64_array_to_json(x)
	y_json := plotly.f64_array_to_json(y)
	z_json := plotly.f64_2d_array_to_json(z)

	// Create heatmap trace with colorscale
	mut trace := map[string]json.Any{}
	trace['type'] = json.Any('heatmap')
	trace['x'] = json.Any(x_json)
	trace['y'] = json.Any(y_json)
	trace['z'] = json.Any(z_json)
	trace['colorscale'] = json.Any('Viridis')

	// Add the trace to the figure
	fig.add_trace(trace)

	// Add custom buttons
	fig.add_reset_button()
	fig.add_screenshot_button('heatmap_screenshot')

	// Update the layout with a title and colorbar settings
	fig.update_layout({
		'title': json.Any('Improved Heatmap Example')
		'xaxis': json.Any({
			'title': json.Any('X Axis')
		})
		'yaxis': json.Any({
			'title': json.Any('Y Axis')
		})
	})

	// Display the figure
	fig.save('improved_heatmap.html') or {
		eprintln('Failed to save plot: ${err}')
		return
	}

	println('Heatmap saved to improved_heatmap.html')
}

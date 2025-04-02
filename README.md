# plotly.v - Plotly for the V Programming Language

plotly.v is a V language wrapper for the powerful plotly.js visualization library. It provides a simple and intuitive way to create interactive plots and visualizations in V.

## Features

- Create various plot types: scatter plots, line charts, bar charts
- Support for more coming soon
- Customize plots with titles, axis labels, and other layout options
- Display interactive plots in a web browser
- Easily convert V data types to plotly-compatible JSON

## Installation

Installation via GitHub:

```bash
v install --git github.com/hungrybluedev/plotly
```

Symlinking for local development:

```bash
ln -s /path/to/this/repo/plotly ~/.vmodules/plotly
```

## Quick Start

```v
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

```

## Examples

See the `examples` directory for more examples:

- `scatter_plot.v` - Basic scatter plot example
- `bar_chart.v` - Bar chart example
- `line_plot.v` - Line plot with sine wave
- `multiple_traces.v` - Multiple traces (sine and cosine)
- `advanced_plotting.v` - Advanced plotting example with lines and markers

## API Reference

### Figure

The `Figure` struct represents a plotly figure with data and layout.

```v
struct Figure {
pub mut:
    data  []map[string]json.Any
    layout map[string]json.Any
}
```

Methods:

- `new_figure() Figure` - Create a new empty figure
- `add_trace(trace map[string]json.Any)` - Add a trace to the figure
- `update_layout(layout map[string]json.Any)` - Update the layout properties
- `to_json() string` - Convert the figure to a JSON string
- `show()` - Display the figure in a web browser

### Trace Creation Functions

- `scatter(x []json.Any, y []json.Any, name string) map[string]json.Any` - Create a scatter plot trace
- `line(x []json.Any, y []json.Any, name string) map[string]json.Any` - Create a line plot trace
- `bar(x []json.Any, y []json.Any, name string) map[string]json.Any` - Create a bar chart trace
- `box(y []json.Any, name string) map[string]json.Any` - Create a box plot trace

### Utility Functions

- `int_array_to_json(arr []int) []json.Any` - Convert an array of integers to JSON
- `f64_array_to_json(arr []f64) []json.Any` - Convert an array of f64 to JSON
- `string_array_to_json(arr []string) []json.Any` - Convert an array of strings to JSON
- `f64_2d_array_to_json(arr [][]f64) [][]json.Any` - Convert a 2D array of f64 to JSON

## License

MIT License

## Acknowledgements

- Plotly.js - The JavaScript library powering the visualizations
- V Programming Language - The language this wrapper is built for

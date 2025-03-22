module plotly

import x.json2 as json

// Helper functions for converting different data types to json.Any

// int_array_to_json converts an array of integers to an array of json.Any
pub fn int_array_to_json(data []int) []json.Any {
	mut result := []json.Any{}
	for val in data {
		result << json.Any(val)
	}
	return result
}

// f64_array_to_json converts an array of f64 to an array of json.Any
pub fn f64_array_to_json(data []f64) []json.Any {
	mut result := []json.Any{}
	for val in data {
		result << json.Any(val)
	}
	return result
}

// string_array_to_json converts an array of strings to an array of json.Any
pub fn string_array_to_json(data []string) []json.Any {
	mut result := []json.Any{}
	for val in data {
		result << json.Any(val)
	}
	return result
}

// f64_2d_array_to_json converts a 2D array of f64 to a 2D array of json.Any
pub fn f64_2d_array_to_json(data [][]f64) [][]json.Any {
	mut result := [][]json.Any{}
	for row in data {
		mut json_row := []json.Any{}
		for val in row {
			json_row << json.Any(val)
		}
		result << json_row
	}
	return result
}

// int_2d_array_to_json converts a 2D array of ints to a 2D array of json.Any
pub fn int_2d_array_to_json(data [][]int) [][]json.Any {
	mut result := [][]json.Any{}
	for row in data {
		mut json_row := []json.Any{}
		for val in row {
			json_row << json.Any(val)
		}
		result << json_row
	}
	return result
}

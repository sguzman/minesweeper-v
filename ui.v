module main

import gx

struct UI {
mut:
	header_size   int
	tile_size     int
	board_size    int
	border_size   int
	padding_size  int
	font_size     int
	window_width  int
	window_height int
	x_padding     int
	y_padding     int
	theme         &Theme = default_theme
}

struct Theme {
	bg_color    gx.Color
	board_color gx.Color
	tile_color  gx.Color
	font        string
}

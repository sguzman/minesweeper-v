module main

import os
import gx

// Default theme
const default_theme = &Theme{
	bg_color: gx.rgb(32, 42, 54)
	board_color: gx.rgb(10, 14, 16)
	tile_color: gx.rgb(255, 255, 255)
	font: os.resource_abs_path('./assets/fonts/TitilliumWeb-Black.ttf')
}

const window_title = 'V Minesweeper'
const default_window_width = 544
const default_window_height = 560

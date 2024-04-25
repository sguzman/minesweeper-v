module main

import gg
import math

enum GameState {
	flag
	space
}

struct App {
mut:
	gg         &gg.Context
	ui         UI
	game_state GameState = .space
	board      &Board
	touch      TouchInfo
}

fn new_app() &App {
	mut app := &App{
		board: &Board{}
		gg: &gg.Context{}
	}

	app.gg = gg.new_context(
		width: default_window_width
		height: default_window_height
		sample_count: 1
		create_window: true
		window_title: window_title
		frame_fn: frame
		event_fn: on_event
		init_fn: init
		user_data: app
		bg_color: app.ui.theme.bg_color
		font_path: app.ui.theme.font
	)

	return app
}

fn init(mut app App) {
	app.new_game()
	app.resize()
}

fn frame(mut app App) {
	app.gg.begin()
	app.draw()
	app.gg.end()
}

fn (mut app App) new_game() {
	app.board = new_board()

	app.game_state = .space
}

fn (mut app App) draw() {
	app.draw_tiles()
}

fn (mut app App) draw_tiles() {
	bsize := app.ui.board_size + app.ui.border_size
	xstart := app.ui.x_padding + app.ui.border_size
	ystart := app.ui.y_padding + app.ui.border_size

	tile_size := app.ui.tile_size
	border_size := tile_size / 5

	// Draw Board
	app.gg.draw_rounded_rect_filled(xstart - tile_size / 2, ystart - tile_size / 2, bsize,
		bsize, bsize / 24, app.ui.theme.board_color)

	// Draw Tiles
	for y, row in app.board.cells {
		for x, _ in row {
			// Rendered values
			tile_x_start := xstart + tile_size / 10 + x * tile_size
			tile_y_start := ystart + tile_size / 10 + y * tile_size
			t_size := tile_size - border_size

			app.gg.draw_rounded_rect_filled(tile_x_start, tile_y_start, t_size, t_size,
				tile_size / 8, app.ui.theme.tile_color)
		}
	}
}

fn (app App) snap_cell_points() [][][2]Pos {
	mut vb_cells := [][][2]Pos{}

	for y, row in app.board.cells {
		for x, _ in row {
			start_x := app.ui.x_padding + app.ui.border_size + x * 11 * app.ui.tile_size / 10
			start_y := app.ui.y_padding + app.ui.border_size + y * 11 * app.ui.tile_size / 10

			vb_cells[y][x][0] = Pos{
				x: start_x
				y: start_y
			}

			vb_cells[y][x][1] = Pos{
				x: start_x + app.ui.tile_size
				y: start_y + app.ui.tile_size
			}
		}
	}

	return vb_cells
}

fn (mut app App) resize() {
	window_size := gg.window_size()
	w := window_size.width
	h := window_size.height
	min_edge := f32(math.min(w, h))

	app.ui.window_width = w
	app.ui.window_height = h
	app.ui.padding_size = int(min_edge / 36)
	app.ui.border_size = app.ui.padding_size * 2
	app.ui.font_size = app.ui.padding_size * 2 / 3

	app.ui.header_size = int(min_edge - app.ui.padding_size * 32)
	app.ui.board_size = int(min_edge - app.ui.padding_size * 2 * 4)
	app.ui.tile_size = app.ui.board_size / app.board.cells.len

	if w > h {
		app.ui.y_padding = app.ui.header_size
		app.ui.x_padding = (app.ui.window_width - app.ui.board_size - app.ui.border_size * 2) / 2
	} else {
		app.ui.y_padding = (app.ui.window_height + app.ui.header_size - app.ui.board_size - app.ui.border_size * 2) / 2
		app.ui.x_padding = (app.ui.window_width - app.ui.board_size - app.ui.border_size * 2) / 2
	}
}

module main

const cell_len = 12 // Row and Column length of the board

struct Board {
mut:
	cells [cell_len][cell_len]bool
}

// Create a new board without generating map
fn new_board() &Board {
	mut board := &Board{}

	return board
}

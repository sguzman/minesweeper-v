module main

import gg
import time

struct TouchInfo {
mut:
	start Touch
	end   Touch
}

struct Touch {
mut:
	pos  Pos
	time time.Time
}

struct Pos {
mut:
	x f64
	y f64
}

fn on_event(e &gg.Event, mut app App) {
}

extends Node

var multiplayer_on: = false
var i_am_server: = false

var b_counter: = 0
func get_bullet_name() -> String:
	b_counter += 1
	return str(b_counter)

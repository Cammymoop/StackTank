extends Control

var touch_on: = false

func _on_gui_input(event: InputEvent):
	if event is InputEventScreenTouch and event.is_pressed():
		touch_on = true
		visible = true

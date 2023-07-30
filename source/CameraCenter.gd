extends Node3D

var accumulated_mouse_move: = 0.0

var mouse_sensitivity = 0.5
const PIXEL_SPIN: float = 200
const SPIN_RADIANS = PI/2

func _process(_delta):
	var spin: = 0.0
	
	if accumulated_mouse_move:
		spin = -(accumulated_mouse_move / PIXEL_SPIN) * mouse_sensitivity
		accumulated_mouse_move = 0.0
	
	if spin != 0:
		rotate_object_local(Vector3.UP, spin * SPIN_RADIANS)


func _input(event):
	if not event is InputEventMouseMotion:
		return
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	var me = event as InputEventMouseMotion
	accumulated_mouse_move += me.relative.x
	#print(me.relative.x)

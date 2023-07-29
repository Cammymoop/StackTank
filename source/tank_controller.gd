extends RigidBody3D

@export var speed: = 0.5
@export var drive_turn: = 0.2
@export var stationary_turn: = 0.7

@export var fodder: = false

const SPEED_MULT = 60

var steering: = 0.0
var driving: = 1.0

var grounded: = true

func _ready():
	if fodder:
		steering = 0.0
		driving = 0.0

func _physics_process(delta):
	if not grounded:
		return
	
	var max_speed: = SPEED_MULT * speed
	var requested_speed: = max_speed * driving
	if driving < 0.3:
		requested_speed = 0
	
	var facing: = -transform.basis.z
	
	# todo reversing
	var facing_velocity = min(max_speed, linear_velocity.project(facing).length())
	
	var new_speed = lerp(facing_velocity, requested_speed, delta/6.0)
	
	# Zero out velocity in facing direction then add new intended speed in facing direction
	linear_velocity = linear_velocity - (facing * facing_velocity) + (facing * new_speed)
	
	var turn_strength = drive_turn if requested_speed > 0 else stationary_turn
	angular_velocity.y = steering * PI * turn_strength

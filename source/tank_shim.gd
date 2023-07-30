extends Node3D

@export var player_controlled: = false

@export var speed: = 0.5
@export var drive_turn: = 1.4
@export var stationary_turn: = 1.4

@export var acceleration_factor: = 6.0

@export var fodder: = false

func _ready():
	var t = get_node("Tank")
	t.speed = speed
	t.drive_turn = drive_turn
	t.stationary_turn = stationary_turn
	t.acceleration_factor = acceleration_factor
	t.fodder = fodder
	t.player_controlled = player_controlled
	
	t.setup()

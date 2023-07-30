extends Node3D

@export var speed: = 20.0

var ignore = null

func _process(delta):
	translate_object_local(Vector3.FORWARD * speed * delta)


func _on_area_3d_body_entered(body: Node):
	if body == ignore:
		return
	var s = load("res://scenes/objects/sparker.tscn").instantiate()
	get_parent().add_child(s)
	s.global_position = global_position
	
	if body.has_method("hit"):
		body.hit()
	queue_free()

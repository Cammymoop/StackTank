extends Node3D

@export var speed: = 20.0

var ignore: NodePath = "."

var has_auth: = false

func _process(delta):
	translate_object_local(Vector3.FORWARD * speed * delta)


func _on_area_3d_body_entered(body: Node):
	if body == get_node(ignore):
		return
	var s = load("res://scenes/objects/sparker.tscn").instantiate()
	get_parent().add_child(s)
	s.global_position = global_position
	
	if not has_auth:
		visible = false
		set_process(false)
		$Area3D.set_deferred("monitoring", false)
		return
	
	if body.has_method("owner_rpc"):
		#body.hit()
		body.owner_rpc("hit")
	queue_free()

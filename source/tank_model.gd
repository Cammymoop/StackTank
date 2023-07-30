extends Node3D

@onready var turret: Node3D = $Turret
@onready var shoot_from: Node3D = $Turret/ShootFrom

func get_shot_start_xform() -> Transform3D:
	if not shoot_from:
		return global_transform
	return shoot_from.global_transform

func aim_turret_at(global_pos: Vector3, amt: float = 1.0) -> void:
	var local_pos: = turret.global_transform.inverse() * global_pos
	
	# take the local pos into the turret's rotation plane
	local_pos.y = 0
	# make vector2 with the right orientation for measuring angle
	var delta_theta = Vector2(-local_pos.z, -local_pos.x).angle()
	
	var new_basis = turret.transform.basis.rotated(Vector3.UP, delta_theta)
	turret.transform.basis = turret.transform.basis.slerp(new_basis, amt).orthonormalized()

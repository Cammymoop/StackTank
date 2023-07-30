extends Camera3D

@onready var ray: RayCast3D = $RayCast3D

func is_tank_visible(tank: RigidBody3D) -> bool:
	var rel = tank.global_position - ray.global_position
	ray.target_position = ray.global_transform.inverse() * tank.global_position
	
	ray.force_raycast_update()
	if ray.is_colliding():
		if tank.get_rid() == ray.get_collider_rid():
			#print(tank.get_rid(), ' ', ray.get_collider_rid())
			return true
	
	return false

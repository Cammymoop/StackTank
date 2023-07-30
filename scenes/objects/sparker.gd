extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$GPUParticles3D.emitting = true
	$GPUParticles3D2.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()

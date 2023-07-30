extends Control

func _ready():
	print("hi")
	if OS.has_feature("Server"):
		print("server mode")
		get_tree().change_scene_to_file("res://scenes/real_game.tscn")

func _on_play_button_pressed():
	Global.multiplayer_on = false
	get_tree().change_scene_to_file("res://scenes/real_game.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_multiplayer_button_pressed():
	Global.multiplayer_on = true
	get_tree().change_scene_to_file("res://scenes/real_game.tscn")

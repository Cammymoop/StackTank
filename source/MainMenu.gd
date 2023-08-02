extends Control

func _ready():
	print("hi")
	if OS.has_feature("Server"):
		start_server()
	
	print(ProjectSettings.get_setting("global/AllowServer"))
	if ProjectSettings.get_setting("global/AllowServer"):
		find_child("RunServerButton").visible = true

func start_server() -> void:
	Global.i_am_server = true
	Global.multiplayer_on = true
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


func _on_run_server_button_pressed():
	start_server()

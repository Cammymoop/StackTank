extends Node3D

var tank_scn = preload("res://scenes/objects/tank.tscn")

var in_mp: = false
var connected: = false
var my_peer_id = null
var mult: SceneMultiplayer = null

var known_peers = {}

func _ready():
	mult = get_tree().get_multiplayer() as SceneMultiplayer
	if not mult:
		print("wrong mult?")
		return
	
	if OS.has_feature("Server"):
		#print("server game scene")
		var peer: = ENetMultiplayerPeer.new()
		peer.create_server(8080)
		get_tree().get_multiplayer().multiplayer_peer = peer
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		if Global.multiplayer_on:
			var peer: = ENetMultiplayerPeer.new()
			peer.create_client("127.0.0.1", 8080)
			mult.multiplayer_peer = peer
			
			my_peer_id = mult.get_unique_id()
			in_mp = true
			
			mult.connect("connected_to_server", self_spawn, CONNECT_ONE_SHOT)
			mult.connect("connection_failed", no_connect)
			mult.connect("peer_connected", new_peer)
			#mult.network_peer_connected.connect(_player_connected)
		
		if not in_mp:
			self_spawn()

func no_connect() -> void:
	print("couldnt connect to server")

func self_spawn() -> void:
	print("I'm in!")
	connected = true
	var spawn = randi() % $Spawns.get_child_count()
	if not in_mp:
		spawn = 0
	var at = $Spawns.get_child(spawn)
	
	var tank: RigidBody3D = tank_scn.instantiate()
	tank.transform = Transform3D(at.global_transform)
	tank.player_controlled = true
	if in_mp:
		tank.set_multiplayer_authority(my_peer_id)
	add_child(tank)
	
	if not in_mp:
		var tank2: RigidBody3D = tank_scn.instantiate()
		tank2.transform = Transform3D($Spawns.get_child(1).global_transform)
		add_child(tank2)

func new_peer(id) -> void:
	if my_peer_id == id:
		print("its just me")
		return
	elif id == 1:
		print("that's the server")
		return
	add_player_tank(id)

func add_player_tank(peer_id):
	if not in_mp:
		print("not in multiplayer")
		return
		
	var spawn = randi() % $Spawns.get_child_count()
	var at = $Spawns.get_child(spawn)
	
	var tank: RigidBody3D = tank_scn.instantiate()
	tank.transform = Transform3D(at.global_transform)
	tank.set_multiplayer_authority(peer_id)
	add_child(tank)

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			if in_mp and connected:
				mult.multiplayer_peer.close()
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if Input.is_action_just_pressed("click"):
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if in_mp and connected:
			mult.multiplayer_peer.close()

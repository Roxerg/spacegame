extends Node2D

signal hit 

var screen_size


export var speed = 200;
export var pos = Vector2(0,0);
var velocity = Vector2();

var can_board = false


var nearby_ship : Node = null;
var current_ship : Node = null;
var current_pedestrian : Node = null;

func _start():
	position = pos
	
	
	

func _ready():
	screen_size = get_viewport_rect().size
	#set_camera()
	for node in get_parent().get_children():
		if node.get("is_ship"):
			current_ship = node
			get_parent().get_node("PlayerCamera").to_follow = current_ship.physics
	
	rotation = PI
	rotation_degrees = 0



func _process(delta):
	
	
	velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("up"):
		send_move("up", delta)
	if Input.is_action_pressed("down"):
		send_move("down", delta)
	if Input.is_action_pressed("left"):
		send_move("left", delta)
	if Input.is_action_pressed("right"):
		send_move("right", delta)
	if Input.is_action_just_pressed("use"):
		print("USE!")
		print(current_pedestrian)
		print(nearby_ship)
		print(can_board)
		if not current_ship == null:
			print("Ship Left!")
			var pedestrian = current_ship.player_leave()
			pedestrian.is_player = true
			
			current_ship = null
			current_pedestrian = pedestrian
			get_parent().get_node("PlayerCamera").to_follow = pedestrian.physics
			position = pedestrian.position
			
		elif not current_pedestrian == null \
			 and not nearby_ship == null \
			 and can_board: 
			
			current_ship = nearby_ship
			get_parent().get_node("PlayerCamera").to_follow = nearby_ship.physics
			get_parent().remove_child(current_pedestrian)
			current_pedestrian = null
			# camera switch
			#$Pedestrian.get_child(0).get_node("Camera2D").current = false
			#nearby_ship.physics.get_node("Camera2D").current = true
			
			
			
			# https://godotengine.org/qa/16647/copy-and-saving-nodes
			
			
	var collider = get_collider()
	if not collider == null:
		position = collider.position
		

func set_camera():
	get_collider().camera.current = true
	
func get_collider():

	if not current_ship == null:
		return current_ship.get_child(0).get_child(0)
	elif not current_pedestrian == null:
		return current_pedestrian.get_child(0)	
	else:
		return null
	
func send_move(command, delta):
	
	if not current_ship == null:
		current_ship.handle_movement(command, delta)
	elif not current_pedestrian == null:
		current_pedestrian.handle_movement(command, delta)
	else:
		print("Vessel nonexistent!")

	

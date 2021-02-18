extends Node2D




export var pos = Vector2(0,0);
var ship_type : Node;
var physics : Node;
var velocity = Vector2();
const is_ship = true
const is_pedestrian = false


var health : int;
var speed : int;
var torque : int;




# Called when the node enters the scene tree for the first time.
func _ready():
	ship_type = get_child(0)
	physics = ship_type.get_child(0)
	
	health = ship_type.health
	speed = ship_type.speed
	torque = ship_type.torque


func handle_movement(action, delta):
	velocity = Vector2()  # The player's movement vector.
	
	if action == "up":
		handle_up(delta)
	else:
		handle_no_up(delta)
		
	if action == "down":
		handle_down(delta)
	if action == "left":
		handle_left(delta)
	if action == "right":
		handle_right(delta)
		
	#velocity = velocity.normalized() * speed
	
	#var final_speed = velocity * delta * 40 
	#physics.move(final_speed)
		
func handle_no_up(delta):
	pass
	
func handle_up(delta):
	physics.thrust = Vector2(1, 0).rotated(physics.rotation+PI) * speed * delta 
	physics.up = true
	
	#velocity = 
func handle_down(delta):
	physics.thrust = Vector2(1, 0).rotated(physics.rotation) * speed * delta
	physics.down = true
	
func handle_left(delta):
	physics.rotato += torque + torque*delta*0.1 
	physics.left = true
func handle_right(delta):
	physics.rotato += torque + torque*delta*0.1
	physics.right = true
	

func handle_mouse_rotato():
	var r = physics.get_mouse_angle()
	var diff = 180-abs(rad2deg(r))
	#print("diff {a} r {b}".format({"a" : diff, "b" : r}))
	if diff > 5:
		if r > 0:
			handle_left(diff)
		elif r < 0:
			handle_right(diff)
	else:
		print("SADADA")
		physics.angular_velocity = physics.angular_velocity/1.5
		
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	
	
func player_leave():
	
	var phys_pos = physics.global_position
	var rotato = physics.rotation
	
	var pedestrian = load("Pedestrian/Pedestrian.tscn")
	var pedestrian_instance = pedestrian.instance()
	
	print(pedestrian_instance)
	
	get_parent().add_child(pedestrian_instance)
	
	
	pedestrian_instance.is_player = true
	pedestrian_instance.position = physics.position + Vector2(1,0).rotated(rotato+PI/2)*100
	
	return pedestrian_instance

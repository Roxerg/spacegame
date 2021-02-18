extends Node2D


export var pos = Vector2(0,0);
var physics : Node;
var velocity = Vector2();
const is_pedestrian = true
const is_ship = false

var playernode;
var is_player = false

var health : int;
var speed : int;

func handle_mouse_rotato():
	if physics:
		physics.handle_mouse_rotato()
	
	
func enter_player(playerNode):
	add_child(playerNode)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	physics = get_child(0)
	
	health = physics.health
	speed = physics.speed
	
	
	
	


func handle_movement(action, delta):
	velocity = Vector2()  # The player's movement vector.
	
	if action == "up":
		handle_up(delta)
	elif action == "down":
		handle_down(delta)
	elif action == "left":
		handle_left(delta)
	elif action == "right":
		handle_right(delta)
		
	velocity = velocity.normalized() * speed
	
	var final_speed = velocity * delta * 40 
	physics.move(final_speed)
		
func handle_up(delta):
	velocity.y -= 1
func handle_down(delta):
	 velocity.y += 1
func handle_left(delta):
	velocity.x -= 1
func handle_right(delta):
	velocity.x += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

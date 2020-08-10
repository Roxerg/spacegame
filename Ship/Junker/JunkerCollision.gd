extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var camera : Camera2D

var back_thruster  :AnimatedSprite
var left_thruster  :AnimatedSprite
var right_thruster :AnimatedSprite
var front_thruster :AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	#camera = $Camera2D
	back_thruster =  $Thrusters/BackThruster
	left_thruster =  $Thrusters/LeftThruster
	right_thruster = $Thrusters/RighThruster
	front_thruster = $Thrusters/FrontThruster
	
	pass # Replace with function body.


func move(amount):
	pass #move_and_slide(amount)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var left = false
var right = false
var up = false
var down = false 

var thrust = 0
var rotato = 0


func _integrate_forces(state):
	if up:
		applied_force = thrust 
		back_thruster.visible = true 
	else:
		applied_force = Vector2()
		back_thruster.visible = false
		
		
	if down: 
		applied_force = thrust/2
		front_thruster.visible = true
	else:
		front_thruster.visible = false
		
		
		
	var rotation_dir = 0
	if right:
		rotation_dir += 1
		left_thruster.visible = true
	else:
		left_thruster.visible = false
		
	if left:
		rotation_dir -= 1
		right_thruster.visible = true
	else:
		right_thruster.visible = false
		
	applied_torque = rotation_dir * rotato
	
	if not up and not down:
		if not linear_velocity.is_equal_approx(Vector2(0,0)):
			var velocity_len = linear_velocity.length()
			var dir = Vector2(1, 0).rotated(rotation)
			if (linear_velocity+dir).length() < velocity_len:
				applied_force = dir*velocity_len*10
				front_thruster.visible=true
			elif (linear_velocity+dir.rotated(PI)).length() < velocity_len:
				applied_force = dir.rotated(PI)*velocity_len*10
				back_thruster.visible=true
			pass
	
	if not left and not right:
		if not linear_velocity.is_equal_approx(Vector2(0,0)):
			var velocity_len = linear_velocity.length()
			var dir = Vector2(1, 0).rotated(rotation+PI/2)
			if (linear_velocity+dir).length() < velocity_len:
				applied_force = dir*velocity_len*10
				right_thruster.visible=true
			elif (linear_velocity+dir.rotated(PI)).length() < velocity_len:
				applied_force = dir.rotated(PI)*velocity_len*10
				left_thruster.visible=true
			
		if not abs(angular_velocity) < 0.0005:
			var _rotation_dir = 0
			if angular_velocity < 0:
				_rotation_dir += 1
				left_thruster.visible = true
			elif angular_velocity > 0:
				_rotation_dir -= 1
				right_thruster.visible = true
			print(angular_velocity)
			applied_torque = _rotation_dir * 1000
			pass
		
		
	
	up = false
	down = false
	left = false
	right = false
	thrust = 0
	rotato = 0




func _on_InteractionZone_body_entered(body):
	if body.get_parent().get("is_player"):
		print("ship nearby")
		var ship = get_parent().get_parent()
		var player = get_parent().get_parent().get_parent().get_node("Player")
		player.can_board = true
		player.nearby_ship = ship


func _on_InteractionZone_body_exited(body):
	if body.get_parent().get("is_player"):
		print("ship left")
		#player.nearby_ship = null
		var player = get_parent().get_parent().get_parent().get_node("Player")
		player.can_board = false
		pass
		

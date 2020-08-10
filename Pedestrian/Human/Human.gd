extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouseposition

var health = 100
var speed = 200

var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#camera = $Camera2D
	pass # Replace with function body.
	
	
func move(amount):
	move_and_slide(amount)
	
func _process(delta):
	mouseposition = get_local_mouse_position()
	rotation += mouseposition.angle() * 0.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

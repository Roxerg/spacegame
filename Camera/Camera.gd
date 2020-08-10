extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var to_follow : Node;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if not to_follow == null:
		if not to_follow.global_position == global_position:
			var dir = (to_follow.global_position - global_position).normalized()
			var speed = to_follow.global_position.distance_to(global_position) * 10
			global_position += speed*dir*delta
		#global_position = to_follow.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

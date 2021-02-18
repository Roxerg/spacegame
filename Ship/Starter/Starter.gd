extends Node2D



var speed = 10000
var torque = 8000
var health = 400

var ship_class = "Starter"
var description = "You started in this ship"



func _ready():
	get_parent().ship_type = self	


	
func test():
	print("WOOO")

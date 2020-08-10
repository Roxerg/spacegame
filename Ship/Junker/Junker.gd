extends Node2D



var speed = 10000
var torque = 8000
var health = 400

var ship_class = "Junker"
var description = "A beat-down delivery ship with. Due to use in sketchy regions, modified with some self-defense capabilities"



func _ready():
	get_parent().ship_type = self	


func test():
	print("WOOO")

extends Sprite


export var type = 0 # clothing
var rng = RandomNumberGenerator.new()

func _ready():
	set_texture(type)


func set_texture(type):
	rng.randomize()
	var idx = 0
	if type == 0:
		idx = "clothing/" + str(rng.randi()%8)
	if type == 1:
		idx = "royal/" + str(rng.randi()%7)
	texture = load("res://Trash/hangings/" + idx + ".png")
	

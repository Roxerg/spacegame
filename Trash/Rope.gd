extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var increment = 33
export var no_of_dots = 12
export var no_of_clothes = 5
export var swingspeed = 2
var wavelength;
var offset;
var A = 22;
var clothes = []
var rng = RandomNumberGenerator.new()


func repick_clothes():
	
	rng.randomize()
	
	var type = rng.randi()%2
	
	clothes = []
	for i in range(0, no_of_clothes):
		clothes.append(rng.randi()%no_of_dots)
		
	no_of_clothes = rng.randi()%no_of_dots+2
	for seg in get_children():
		seg.get_child(0).set_texture(type)
		seg.get_child(0).visible = false
		
	var segs = get_children()
	for i in range(0,no_of_dots):
		if i in clothes:
			segs[i].get_child(0).visible = true


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var b = get_parent().get_node("Baboi")
	b.hide()
	
	
	rng.randomize()
	
	wavelength = increment*no_of_dots
	offset = wavelength / 2
	
	for i in range(0, no_of_clothes):
		clothes.append(rng.randi()%no_of_dots)

	var x = -offset
	for i in range(0,no_of_dots):
		var segment = load("res://Trash/Segment.tscn")
		var seg = segment.instance()
		seg.position = Vector2(x, 1)
		if i in clothes:
			print("visible: " + str(i))
			seg.get_child(0).visible = true
		add_child(seg)
		x += increment
	
		
	var i = 0
	for seg in get_children():
		i += 1
		print(str(i) + " position: " + str(seg.position))
		#seg.position.y = sin(deg2rad(angle))*150
		
		

func _draw():
	
	
	var segs_no = get_child_count()
	var segs = get_children()
	for i in range(0, segs_no-1):
		var from = segs[i].position
		var to   = segs[i+1].position
		draw_line(from, to, Color(0, 0, 0), 2)


var t = 0
var t_incr = 0.2
func _process(delta):
	
	
	var boi = true
	for seg in get_children():
		if abs(t) > 1000:
			t_incr *= -1
		var maffs = sin((PI*(seg.position.x+offset))/(wavelength))*cos(deg2rad(2*PI*swingspeed*t))
		seg.position.y = maffs*A
		seg.set_scale(Vector2(1, -0.8*maffs))
		update()
		
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	t += t_incr


func _on_Timer2_timeout():
	repick_clothes()

extends Spatial

var mesh

var direction = Vector2(0,1)
var pos = Vector2()
var target = Vector2()
var current = Vector2()

var t = 0.0
var jump = false
var bounced = true

const jump_duration = 0.2

onready var shadow = get_node("Shadow")
onready var ani = get_node("AnimationPlayer")

func _ready():
	shadow.look(get_rotation().y)
	mesh = get_node("KinematicBody/CollisionShape/MeshInstance")

func _physics_process(delta):
	if (jump):
		if(t == 0):
			pos = Vector2(get_translation().x,get_translation().z)
			target = pos + direction
		t += delta/jump_duration
		current = pos.linear_interpolate(target, t)
		set_translation(Vector3(current.x, get_translation().y, current.y))
	if(t>=1):
		t = 0.0
		jump = false

func set_jump():
	jump = true
	
func set_bounced():
	pass

func turn(dir):
	if (dir == "right"):
		direction = Vector2(0,1)
	elif (dir =="left"):
		direction = Vector2(0,-1)
	elif (dir =="up"):
		direction = Vector2(1,0)
	elif (dir =="down"):
		direction = Vector2(-1,0)
	
	look_at(get_translation()-Vector3(direction.x, 0, direction.y), Vector3(0,1,0))
	shadow.look(get_rotation().y)
	
	bounce()

func bounce_started():
	shadow.bounce()

func bounce():
	if ani.is_playing():
		ani.clear_queue()
		ani.queue("Bounce")
	ani.play("Bounce")
	


func released():
	ani.clear_queue()
#	var col = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1))
#	mesh.get_surface_material(0).set_emission(col)

var score = 0 
func stepped():
	score += 1
	get_parent().get_node("HUD/Score1").text = String(score)
#var col = Color(0,1,0)
#var del = 0.05
#var count = 0
#var case = 0

#func _process(delta):
#	if(case == 0):
#		col.r += del
#	elif(case == 1):
#		col.g += del
#	else:
#		col.b += del
#	count += 1
#	if(count == 20):
#		count = 0
#		del = -del
#		case += 1
#		case %= 3
#	mesh.get_surface_material(0).set_emission(col)
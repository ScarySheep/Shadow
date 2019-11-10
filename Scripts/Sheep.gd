extends Spatial

var mesh

var direction = Vector2(0,1)
var pos = Vector2()
var target = Vector2()
var current = Vector2()

var t = 0.0
var jump = false

const jump_duration = 0.2

onready var ani = get_node("AnimationPlayer")

func _ready():
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
		set_rotation_degrees(Vector3(0,0,0))
	elif (dir =="left"):
		set_rotation_degrees(Vector3(0,180,0))
	elif (dir =="up"):
		set_rotation_degrees(Vector3(0,90,0))
	elif (dir =="down"):
		set_rotation_degrees(Vector3(0,270,0))
	
	direction = Vector2(transform.basis.z.x, transform.basis.z.z)
	bounce()

func bounce():
	if ani.is_playing():
		ani.clear_queue()
		ani.queue("Bounce")
	ani.play("Bounce")

func released():
	ani.clear_queue()
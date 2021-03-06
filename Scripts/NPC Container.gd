extends Spatial

onready var sheep = get_node("Sheep")
onready var sheep_shape = get_node("Sheep/KinematicBody/CollisionShape")
onready var shadow = get_node("Viewport/Shadow")
onready var shadow_area = get_node("Shadow Area")
onready var shadow_area_shape = get_node("Shadow Area/CollisionShape")
onready var timer = get_node("Timer")

var pos = Vector2()
var offset = Vector2(850,450)

var sun_scale_z = 0.0

var timer_started = false

var sheep_num = 1;

var sheep_starting_pos = Vector3(0,0,0)

func _ready():
	set_translation(Vector3(0,0,0))

func set_sheep_pos(pos):
	sheep.set_translation(pos)
	sheep_starting_pos = pos
	
func _process(delta):
	var rect_h = 170*abs(sun_scale_z)*sheep_shape.get_scale().y+100*sheep_shape.get_scale().z
	var offset_y = -sun_scale_z*135
	pos = Vector2(-sheep.get_translation().z+sheep_shape.get_translation().y*sun_scale_z, sheep.get_translation().x)*100+offset
	
	shadow.set_scale(Vector2(sheep_shape.get_scale().z,1))
	shadow.set_position(pos)
	shadow.set_region_rect(Rect2(0,0,100,rect_h))
	shadow.set_offset(Vector2(0, offset_y))
	
	shadow_area.set_translation(Vector3(sheep.get_translation().x,0.01,sheep.get_translation().z-sheep_shape.get_translation().y*sun_scale_z))
	shadow_area_shape.get_shape().set_extents(Vector3(0.5*sheep_shape.get_scale().z,rect_h/100/2,0.01))
	shadow_area_shape.set_translation(Vector3(0,0,offset_y/100))
	
	if (abs(sheep.get_translation().x) >= 5 || abs(sheep.get_translation().z) >= 9):
		var sheep_y = sheep.get_translation().y
		sheep.set_translation(Vector3(sheep.get_translation().x, sheep_y - 9.8*delta, sheep.get_translation().z))
		
		if(sheep.get_translation().z>=9):
			sheep_y = -sheep_y
		shadow.set_position(shadow.get_position()+Vector2(-sheep_y*100,0))
		shadow_area.set_translation(shadow_area.get_translation() + Vector3(0,0,sheep_y))
		
		if !timer_started:
			timer.start()
			timer_started = true
				
func rotate_sun(rad):
	sun_scale_z = tan(rad+PI/2)


func _on_Area_body_entered(body):
	queue_free()


func _on_Timer_timeout():
	timer_started = false
	sheep.set_translation(sheep_starting_pos)

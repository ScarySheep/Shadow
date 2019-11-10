extends Spatial

onready var sprite = get_node("Transform/Sprite")
onready var z_pos_ex = get_node("Transform/Sprite/ZPosExtreme")
onready var z_neg_ex = get_node("Transform/Sprite/ZNegExtreme")
onready var x_pos_ex = get_node("Transform/Sprite/XPosExtreme")
onready var x_neg_ex = get_node("Transform/Sprite/XNegExtreme")
#var translation_z
var sun_scale_z
var pos_x
var pos_z
var pos_height
var scale_x
var scale_z

const z_width = 8.5


func _ready():
	pass
	
func _process(delta):
#	var rect_h = 100+170*abs(sun_scale_z)
#	var offset_y = -sun_scale_z*135
#
#	set_translation(Vector3(pos_x,0.01,pos_z-pos_height*sun_scale_z))
#	set_scale(Vector3(scale_x,1,1))
#	rect_h = (rect_h-100)*scale_z+100*scale_x
#
#	z_pos_ex.set_translation(Vector3(0,(offset_y+rect_h/2)/100,0))
#	z_neg_ex.set_translation(Vector3(0,(offset_y-rect_h/2)/100,0))
#	var z_pos_ex_z = z_pos_ex.get_global_transform().origin.z
#	var z_z_neg_ex = z_neg_ex.get_global_transform().origin.z
#
#	if(z_pos_ex_z >= z_width):
#		rect_h -= (z_pos_ex_z - z_width)*100
#		offset_y -= (z_pos_ex_z - z_width)*100/2
#	if(z_z_neg_ex <= -z_width):
#		rect_h -= (-z_width - z_z_neg_ex)*100
#		offset_y += (-z_width - z_z_neg_ex)*100/2
#	if((z_pos_ex_z >= z_width && z_z_neg_ex >= z_width)||(z_pos_ex_z <= -z_width && z_z_neg_ex <= -z_width)):
#		rect_h = 0
#
#	sprite.set_offset(Vector2(0, offset_y))
	#sprite.set_region_rect(Rect2(0,0,100,rect_h))
	pass


	
func set_shadow_pos(x,z,height):
	pos_x = x
	pos_z = z
	pos_height = height
	
func set_shadow_scale(x,z):
	#fix z to z * something tangent one day?
	scale_x = x
	scale_z = z

var score = 0
func _on_Area_body_entered(body):
	print("hi")
	score += 1
	HUD.get_node("Score1").text = String(score)


func rotate_sun(rad):
	sun_scale_z = tan(rad+PI/2)
	#translation_z = sin((rad+PI/2)*2)


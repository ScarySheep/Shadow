extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var sheep = get_parent()

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(sheep)
	#set_translation(Vector3(sheep.get_translation().x, get_translation().y, sheep.get_translation().z))

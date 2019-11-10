tool
extends Spatial

export (int) var width
export (int) var length

var cube_light = preload("res://Scenes/Cube.tscn")
var cube_dark = preload("res://Scenes/Cube2.tscn")
var pos = Vector3(0,-0.5,0)


func _ready():
	for i in range(width):
		for j in range(length):
			for k in range(10):
				pos.y = -0.5-k
				if(randi()%(k+1) == k || randi()%(k+1) == k || randi()%(k+1) == k):
					if (i+j)%2==0:
						pos.x = i-width/2
						pos.z = j-length/2
						var cube = cube_light.instance()
						cube.set_translation(pos)
						add_child(cube)
					else:
						pos.x = i-width/2
						pos.z = j-length/2
						var cube = cube_dark.instance()
						cube.set_translation(pos)
						add_child(cube)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

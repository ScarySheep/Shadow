extends Spatial

onready var sun = get_node("Background/Sun")

var player

var npc_con

var sheep = preload("res://Scenes/Sheep Container.tscn")
var enemy = preload("res://Scenes/Enemy Container.tscn")
var npc = preload("res://Scenes/NPC Container.tscn")

var player_pos = Vector2()

func _ready():
	HUD.score = 0
	
	player = sheep.instance()
	add_child(player)
	player.set_sheep_pos(Vector3(0,0,0))
#	npc_con = npc.instance()
#	add_child(npc_con)
#	npc_con.set_sheep_pos(Vector3(0,0,-3))
	
	sun_rot_x = sun.get_rotation().x
	player.rotate_sun(sun_rot_x)
	
var pressed = false

var sun_rot_x
var sun_delta = -0.05
func _process(delta):
	#updating player position for enemy
	player_pos = player.sheep.get_translation()
	
	#controling player movement
	pressed = false
	if(player.animation.get_current_animation() != "Tree"):
		if Input.is_action_pressed("ui_right2"):
			player.sheep.turn("right")
			pressed = true
			#player2_move()
		elif Input.is_action_pressed("ui_left2"):
			player.sheep.turn("left")
			pressed = true
			#player2_move()
		elif Input.is_action_pressed("ui_up2"):
			player.sheep.turn("up")
			pressed = true
			#player2_move()
		elif Input.is_action_pressed("ui_down2"):
			player.sheep.turn("down")
			pressed = true
			#player2_move()
		elif Input.is_action_pressed("ui_accept2"):
			if(!player.animation.is_playing()):
				player.skill.get_node("AnimationPlayer").play("Start")
				player.animation.play("Tree")
				for e in get_tree().get_nodes_in_group("enemies"):
					if(abs((e.sheep.get_translation()-player_pos).x) <= 2 && abs((e.sheep.get_translation()-player_pos).z) <= 2):
						e.queue_free()

		if !pressed:
			player.sheep.released()
		

	
	#updating sun angle for all entity
	sun_rot_x = sun.get_rotation().x
	if(sun_rot_x >= -PI/4 || sun_rot_x <= -PI/4*3):
		sun_delta = -sun_delta
	sun_rot_x += sun_delta*delta
	sun.set_rotation(Vector3(sun_rot_x, 0, 0))
	player.rotate_sun(sun_rot_x)
	get_tree().call_group("enemies", "rotate_sun", sun_rot_x)

#	if(pressed1):
#		sun_rot_x += sun_delta
#		sun.set_rotation(Vector3(sun_rot_x, 0, 0))
#		player1_con.rotate_sun(sun_rot_x)
#		player2_con.rotate_sun(sun_rot_x)
#		if(npc_con != null):
#			npc_con.rotate_sun(sun_rot_x)

func _on_SpawnTimer_timeout():
	var enemy_con = enemy.instance()
	enemy_con.add_to_group("enemies")
	add_child(enemy_con)
	var pos = Vector3(randi()%9-4,0,randi()%15-7)
	while (pos-player_pos).length() <= 3:
		pos = Vector3(randi()%9-4,0,randi()%15-7)
	enemy_con.set_sheep_pos(pos)

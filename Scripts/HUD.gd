extends Control

var score = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	get_node("Score").text = String(score)
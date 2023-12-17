extends Node2D

@onready var Player = $Player


func _ready():
	pass
	
	
func _process(delta):
	if (Player.position.y < 60) and (Player.position.x > 1800):
		$change_level.start(3)
	
func _on_change_level_timeout():
	GLOBAL.to("res://nodes/2level.tscn")



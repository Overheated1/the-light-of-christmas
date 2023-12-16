extends Node2D

@onready var Player = $Player
@onready var dialog = $dialog


func _ready():
	dialog.visible = true
	$dialog/AnimationPlayer.play("text_animation")
	
	
func _process(delta):
	if (Player.position.y > 58) and (Player.position.x > 1800):
		dialog.visible = true
		$dialog/Label.text = "Oh ganaste, pq los enemigos no atacaban ejejjeje"
		$change_level.start(3)


func _on_button_pressed():
	print("hi")
	dialog.visible = false
	


func _on_change_level_timeout():
	GLOBAL.to("res://nodes/2level.tscn")

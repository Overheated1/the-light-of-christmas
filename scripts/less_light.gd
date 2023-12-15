extends Timer


func _on_timeout():
	if $Fire.texture_scale > 0.2:
		$Fire.texture_scale -= 0.2
	else:
		GLOBAL.to("res://nodes/mainScene.tscn")
	
	

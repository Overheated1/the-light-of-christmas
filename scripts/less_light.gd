extends Timer
@onready var Fire = get_node("../Fire")

func on_timeout():
	if Fire.texture_scale > 0.4:
		Fire.texture_scale -= 0.2
	else:
		GLOBAL.to("res://nodes/mainScene.tscn")
	
	

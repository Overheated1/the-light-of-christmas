extends CanvasLayer

enum NPCS {Player,Hunter,Furrier}

var cabin : bool = false
var fire : bool = false
var int_p : bool = false

const images : Dictionary = {
	'PLayer':preload("res://assets/player.png"),
	'Hunter':preload("res://assets/hunter.svg"),
	'Furrier':preload("res://assets/furrier.svg")
}

const texts_player : Array = [
	"Player: Where am I?",
	"Player: I don't remember anything",
	"Player: What is this, a note?",
	"Player: 'Those who don't see the path are destined to wander aimlessly in this world'",
	"Player: I'd better get out of here",
	"Player: Wait! Don't shot, I just woke up in a cabin to the southwest"
]

const texts_hunter : Array = [
	"Hunter: Who is there?",
	"Hunter: Oh, that abandoned cabin, I didn't know there was anyone living there, well, if I were you,
	I would leave this forest as quick as possible, but if you have time I need some
	firewood and food. I'd do it myself but as you can see I am wounded",
	"Hunter:"
	
]
var chats : int = 0
var npc : int = 0

func put_text(text : String,NPC : int,IMAGE : Texture) -> void:
	show()
	get_tree().paused = true
	$Text.text = text
	$Image.texture = IMAGE
	$AnimationPlayer.play("text_animation")
	

func _on_button_pressed():
	match npc:
		NPCS.Player:
			#cabin
			if chats < 5:
				put_text(texts_player[chats],NPCS.Player,images["PLayer"])
				chats += 1
			#elif chats > 2 and chats < 6:
				#put_text(texts_player[chats],NPCS.Player,images["PLayer"])
				#chats += 1
			else:
				chats -= 5
				hide()
				get_tree().paused = false
				visible = false
		NPCS.Hunter:
			if chats < 2:
				if not int_p:
					put_text(texts_player[5],NPCS.Player,images["PLayer"])
					int_p = true
					return
				put_text(texts_hunter[chats],NPCS.Hunter,images["Hunter"])
				chats += 1
			else:
				chats -= 2
				hide()
				get_tree().paused = false
				visible = false
			
			
			
				

func _on_cabain_body_entered(body):
	if cabin == false:
		print(chats)
		put_text(texts_player[chats],NPCS.Player,images["PLayer"])
		chats+=1
		cabin = true



func _on_f_event_body_entered(body):
	if fire == false:
		put_text(texts_hunter[chats],NPCS.Hunter,images["Hunter"])
		chats+=1
		npc = 1
		fire = true

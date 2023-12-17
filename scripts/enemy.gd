extends CharacterBody2D

enum {IDLE,RUN,ATTACK,DEAD}
var state
var current_animation
var new_animation
const speed = 98
var attackRate : float = 1.0
var attackDist : float = 100
@export var player : CharacterBody2D = get("res://nodes/player.tscn") 
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var timer : Node = player.get_child(2)
var health : int = 100

func transition_to(new_state):
	state = new_state
	match state:
		"IDLE":
			new_animation = "IDLE"
		"RUN":
			new_animation = "RUN"
		"ATTACK":
			new_animation = "ATTACK"
		"DEAD":
			new_animation = "DEAD"
		_:
			pass
		
# Called when the node enters the scene tree for the first time.
func _ready():
	transition_to("IDLE")
	$Timer2.wait_time = attackRate
	$Timer2.start()

func _physics_process(_delta : float) -> void:
	if position.distance_to(player.position) <= 200:
		if not %persecution.playing:
			%persecution.play()
	if current_animation != new_animation:
		current_animation = new_animation
		$Sprite2D/AnimationPlayer.play(current_animation)
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	$Sprite2D.flip_h = velocity.x > 0
	move_and_slide()
	

func make_path() -> void:
	nav_agent.target_position = player.global_position
	
	
	
func _on_timer_timeout():
	if position.distance_to(player.position) >= 40:
		make_path()



func _on_timer_2_timeout():
	if position.distance_to(player.position) <= attackDist:
		timer.on_timeout()

func take_damage():
	queue_free()

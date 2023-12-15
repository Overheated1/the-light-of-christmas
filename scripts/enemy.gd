extends CharacterBody2D

enum {IDLE,RUN,ATTACK,DEAD}
var state
var current_animation
var new_animation
const speed = 75
@export var player : Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

  
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

func _physics_process(_delta : float) -> void:
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
	make_path()


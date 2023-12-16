extends CharacterBody2D


# Declare member variables here. Examples:
var speed = 100
var screen_size
var keyboard = true
var target = position
enum {IDLE,RUN,ATTACK,DEAD}
var state
var current_animation
var new_animation
@onready var camera : Camera2D = $Camera2D

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
	screen_size =  get_viewport_rect().size
	transition_to("IDLE")

func move_keyboard():
	var direction = Input.get_vector("A","D","W","S")
	velocity = direction * speed
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		
func move_mouse():
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if current_animation != new_animation:
		current_animation = new_animation
		$Sprite2D/AnimationPlayer.play(current_animation)
		#missing change the states

	if keyboard:
		move_keyboard()
	else:
		move_mouse()
	position += velocity * delta 
	position.x =  clamp(position.x,0,screen_size.x)
	position.y =  clamp(position.y,0,screen_size.y)
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0



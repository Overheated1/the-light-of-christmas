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
	print(state)
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
			#new_animation = "IDLE"
		
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
	
	if velocity.length() > 0:
		pass
		#$AnimatedSprite.play()
	else:
		pass
		#$AnimatedSprite.stop()	
	position += velocity * delta 
	position.x =  clamp(position.x,0,screen_size.x)
	position.y =  clamp(position.y,0,screen_size.y)
	#if velocity.x != 0:
		#$AnimatedSprite.animation = "Caminar"
		#$AnimatedSprite.flip_h = velocity.x > 0
	#if velocity.y != 0:
		#$AnimatedSprite.animation = "Subir"
		#$AnimatedSprite.flip_h = false


func _on_timer_timeout():
	if $Fire.texture_scale > 0.2:
		$Fire.texture_scale -= 0.2
	else:
		GLOBAL.to("res://nodes/mainScene.tscn")
	
	
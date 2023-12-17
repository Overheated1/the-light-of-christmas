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
var can_attack
@onready var camera : Camera2D = $Camera2D
var fuel = 100
@onready var enemies : Array = get_node("/root/1Level/Enemies").get_children()
#@onready var enemy : CharacterBody2D = 
 
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
	$Fire/Area2D/CollisionShape2D.disabled = true
	$ProgressBar.value = 100

func move_keyboard():
	var direction = Input.get_vector("A","D","W","S")
	velocity = direction * speed
	move_and_slide()
	
func _input(event):
	print("a")
	if Input.is_action_pressed("E"):
		if fuel > 0:
			$Fire/Area2D/CollisionShape2D.disabled = false
			$Fire.energy = 2
			$Fire.color = "orange"
			fuel -= 10
			$ProgressBar.value = fuel
	if Input.is_action_just_released("E"):
		$Fire/Area2D/CollisionShape2D.disabled = true
		$Fire.energy = 1
		$Fire.color = "#fbb989"
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
		$Sprite2D/AnimatedSprite2D.play(current_animation)
	
	if keyboard:
		move_keyboard()
	else:
		move_mouse()
	position += velocity * delta 
	position.x =  clamp(position.x,0,screen_size.x)
	position.y =  clamp(position.y,0,screen_size.y)
	if velocity.x != 0:
		transition_to("RUN")
		$Sprite2D/AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		new_animation = "IDLE"




func _on_area_2d_body_entered(body):
	if body in enemies:
		body.take_damage()


func _on_area_2d_body_exited(body):
	if body in enemies:
		body.take_damage()


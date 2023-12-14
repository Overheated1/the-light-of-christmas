#in process
extends Node
#
#class_name StateMachine
#
#@onready var node_to_control = self.owner
#@export_node_path('Node') var initial_state
#@onready var state = get_node(initial_state)
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#call_deferred("_enter_state")
#
#func _enter_state():
	#state.node = node_to_control
	#state.state_machine = self
	#state.enter()
	#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta :float) -> void:
	#if state.has_method("process"):
		#state.process(delta)
	#
#func change_to(new_state):
	#state = get_node(new_state)
	#_enter_state()
	#
#func _physics_process(delta):
	#if state.has_method("physics_process"):
		#state.physics_process(delta)
		#
#func _input(event):
	#if state.has_method("input"):
		#state.input(event)
		#
#func _unhandled_input(event):
	#if state.has_method("unhandled_input"):
		#state.unhandled_input(event)
		#
#func _unhandled_key_input(event):
	#if state.has_method("unhandled_key_input"):
		#state.unhandled_key_input(event)
		#
#
	#
	#

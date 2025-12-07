class_name PlayerState
extends State

@onready var player: Player = get_tree().get_first_node_in_group("Player")
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity",-9.8)


#Animations
var idle_anim: String = "Idle"
var walk_anim: String = "Walk"
var jump_anim: String = "Jumo"
var jab_anim: String = "Jab"


#STATES
@export_group("States")
@export var idle_state: PlayerState
@export var walk_state: PlayerState
@export var jump_state: PlayerState
@export var fall_state: PlayerState
@export var jab_state: PlayerState


#inputs
var movement_key: String = "Movement"
var left_key: String = "Left"
var right_key: String = "Right"
var up_key: String = "Up"
var down_key: String = "Down"
var jump_key: String = "Jump"
var jab_key: String = "attack"


func _ready():
	if idle_state == null or walk_state == null or jump_state == null:
		var state_machine = get_parent()
		if state_machine:
			for child in state_machine.get_children():
				if child is PlayerIdleState and idle_state == null:
					idle_state = child
				elif child is PlayerWalkState and walk_state == null:
					walk_state = child
					
				elif child is PlayerJumpState and jump_state == null:
					jump_state = child


#base 
func process_physics(delta: float) -> State:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	return null

class_name EnemyState
extends State

var enemy: Enemy = null
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity",-9.8)

# Animations
var idle_anim: String = "Idle"
var walk_anim: String = "Walk"
var jump_anim: String = "Jump"
var jab_anim: String = "Jab"
var straight_anim: String = "Straight"
var upper_anim: String = "Upper"
var pain_anim: String = "pain"

# STATES
@export_group("States")
@export var idle_state: EnemyState
@export var walk_state: EnemyState
@export var jump_state: EnemyState
@export var fall_state: EnemyState
@export var jab_state: EnemyState
@export var straight_state: EnemyState
@export var upper_state: EnemyState
@export var pain_state: EnemyState

# AI parameters
var attack_range: float = 60.0
var chase_range: float = 300.0
var attack_cooldown: float = 1.0
var last_attack_time: float = 0.0

func _ready():
	var state_machine = get_parent()
	if state_machine and state_machine.get_parent() is Enemy:
		enemy = state_machine.get_parent()
	
	if idle_state == null or walk_state == null:
		if state_machine:
			for child in state_machine.get_children():
				if child is EnemyIdleState and idle_state == null:
					idle_state = child
				elif child is EnemyWalkState and walk_state == null:
					walk_state = child
				elif child is EnemyJumpState and jump_state == null:
					jump_state = child
				elif child is EnemyJabState and jab_state == null:
					jab_state = child
				elif child is EnemyStraightState and straight_state == null:
					straight_state = child
				elif child is EnemyUpperState and upper_state == null:
					upper_state = child

# Base physics
func process_physics(delta: float) -> State:
	if enemy:
		enemy.velocity.y += gravity * delta
		enemy.move_and_slide()
	return null

func get_distance_to_target() -> float:
	if enemy.target:
		return enemy.global_position.distance_to(enemy.target.global_position)
	return INF

func get_direction_to_target() -> float:
	if enemy.target:
		return sign(enemy.target.global_position.x - enemy.global_position.x)
	return 0.0

func can_attack() -> bool:
	var time_since_last_attack = Time.get_ticks_msec() / 1000.0 - last_attack_time
	return time_since_last_attack >= attack_cooldown

func set_attack_time() -> void:
	last_attack_time = Time.get_ticks_msec() / 1000.0

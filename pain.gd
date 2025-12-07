class_name PlayerPainState
extends PlayerState

"""
Whole script doesnt work, fuck it get bodied.
"""
@onready var hurt_box: PlayerHurtBox = $"../Box/Hurtbox"

var pain: bool
var knockback_applied: bool
@export var knockback_force: float = 550.0
var knockback_timer: float = 0.0
@export var knockback_duration: float =0.3

func enter() -> void:
	pain = false
	knockback_applied = false
	knockback_timer = 0.0

	player.velocity.x = 0
	# replace with damage animation: player.animation.play(jab_anim)
	#same animation end code as jab script
	 
func exit() -> void:
	pass
	
	
func _process_input(event: InputEvent) -> State:
	if pain and event.is_action_pressed(movement_key):
		return walk_state
	elif pain and event.is_action_pressed(jump_key):
		return jump_state
	return null

func process_frame(delta: float) -> State:
	super(delta)
	if pain: return idle_state
	return null

func process_physics(delta: float) -> State:
	knockback()
	knockback_timer += delta
	if knockback_timer >= knockback_duration:
		pain = true
	return super(delta)


func knockback() -> void:
	if knockback_applied:
		pain = true
		print("Knockback already applied")

		return
		
	if hurt_box == null or hurt_box.hitting_area == null:
		pain = true
		return
	
	var knock_dir: Vector2 = (hurt_box.hitting_area.global_position - player.global_position).normalized()
	player.velocity += knock_dir * knockback_force
	knockback_applied = true
	pain = true

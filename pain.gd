class_name PlayerPainState
extends PlayerState

@onready var hurt_box: Area2D = $"HurtBox"

var pain: bool
func enter() -> void:
	pain = false
	
	player.velocity.x = 0
	# replace with damage animation: player.animation.play(jab_anim)
	#same animation end code as jab script
	 
func exit() -> void:
	player.velocity.x = 0
	
	
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
	return super(delta)

func knockback() -> void:
	var knock_dir: Vector2 = hurt_box.hitting_area.global_position - player.global_position
	player.velocity.x += knock_dir.x

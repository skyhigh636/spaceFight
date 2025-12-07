class_name EnemyJumpState
extends EnemyState

const JUMP_VELOCITY: float = -500.0

func enter() -> void:
	enemy.velocity.y = JUMP_VELOCITY
	enemy.animation.play(jump_anim)

func process_physics(delta: float) -> State:
	super(delta)
	
	# Fall state when moving downward
	if enemy.velocity.y > 0:
		return fall_state if fall_state else idle_state
	
	# Check for landing
	if enemy.is_on_floor():
		var distance = get_distance_to_target()
		if distance < chase_range:
			return walk_state
		return idle_state
	
	return null

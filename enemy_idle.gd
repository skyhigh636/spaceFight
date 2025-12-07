class_name EnemyIdleState
extends EnemyState

var DECEL_SPEED: float = 300.0

func enter() -> void:
	enemy.animation.play(idle_anim)

func process_physics(delta: float) -> State:
	super(delta)
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, DECEL_SPEED * 0.15)
	
	# AI: Check if target is in range
	var distance = get_distance_to_target()
	if distance < chase_range and distance > attack_range:
		return walk_state
	elif distance <= attack_range and can_attack() and enemy.is_on_floor():
		# Randomly choose an attack
		var attack_choice = randi() % 3
		if attack_choice == 0:
			return jab_state
		elif attack_choice == 1:
			return straight_state
		else:
			return upper_state
	
	return null

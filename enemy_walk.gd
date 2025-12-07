class_name EnemyWalkState
extends EnemyState

const SPEED: float = 250.0

func enter() -> void:
	enemy.animation.play(walk_anim)
	
func process_physics(delta: float) -> State:
	super(delta)
	
	var distance = get_distance_to_target()
	var move_dir = get_direction_to_target()
	
	# Stop if target is in attack range
	if distance <= attack_range:
		if can_attack() and enemy.is_on_floor():
			# Randomly choose an attack
			var attack_choice = randi() % 3
			if attack_choice == 0:
				return jab_state
			elif attack_choice == 1:
				return straight_state
			else:
				return upper_state
		return idle_state
	
	# Stop if target is out of chase range
	if distance > chase_range:
		return idle_state
	
	# Move towards target
	do_move(move_dir)
	return null

func do_move(move_dir: float) -> void:
	enemy.velocity.x = move_toward(enemy.velocity.x, move_dir * SPEED, SPEED * 0.15)
	
	# Flip sprite based on movement direction
	if move_dir < 0:
		enemy.sprite.flip_h = true
	elif move_dir > 0:
		enemy.sprite.flip_h = false

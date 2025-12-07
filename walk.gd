class_name PlayerWalkState
extends PlayerState

const SPEED: float = 350.0
func enter() -> void:
	player.animation.play(walk_anim)
	
func process_physics(delta: float) -> State:
	super(delta)
	var move_dir = get_move_dir()
	
	if move_dir == 0:
		return idle_state
		
	do_move(move_dir)
	return null
	
	
func process_input(event: InputEvent) -> State:
	super(event)
	if event.is_action_pressed(jump_key) and player.is_on_floor():
		return jump_state
	elif event.is_action_pressed(jab_key) and player.is_on_floor() and event.is_action_pressed("Right"): return straight_state

	elif event.is_action_pressed(jab_key) and player.is_on_floor(): return jab_state

	return null
	
func get_move_dir() -> float:

	return Input.get_axis(left_key,right_key)
	

func do_move(move_dir: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, move_dir * SPEED, SPEED  * 0.15)

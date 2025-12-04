class_name PlayerWalkState
extends PlayerState

const SPEED: float = 150.0
func enter() -> void:
	player.animation.play(walk_anim)
	
func process_physics(delta: float) -> State:
	super(delta)
	var move_dir = get_move_dir()
	
	if move_dir == 0:
		return idle_state
		
	do_move(move_dir)
	return null
	
	

func get_move_dir() -> float:

	return Input.get_axis(left_key,right_key)
	

func do_move(move_dir: float) -> void:
	player.velocity.x = move_dir * SPEED

class_name PlayerUpperState
extends PlayerState
"""
By all accounts the code here is perfectly fine but some issue with the state machines, 
particularly about the up and down inputs, 
disregard it for now come back to it later
"""
var STOP: float = 0
var attacked: bool
var movement: String = "Movement"

func enter() -> void:
	attacked = false
	player.velocity.x = 0
	player.animation.play(upper_anim)
	player.animation.animation_finished.connect(func(_anim): attacked = true)
	



func _process_input(event: InputEvent) -> State:
	if attacked and event.is_action_pressed(jump_key):
		return jump_state
	
	return null

func process_frame(delta: float) -> State:
	super(delta)
	if attacked: return idle_state
	return null

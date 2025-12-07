class_name PlayerJabState
extends PlayerState

var STOP: float = 0

func enter() -> void:
	super()
	player.velocity.x = STOP
	player.animation.play(jab_anim)
	

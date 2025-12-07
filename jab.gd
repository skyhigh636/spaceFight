class_name PlayerJabState
extends PlayerState

var STOP: float = 0
var attacked: bool
"""
all attacks have this same structure, slightly differing if based around directional inputs
"""
@onready var hitbox: Area2D = $HitBox
@onready var hitbox_collision: CollisionShape2D = $HitBox/CollisionShape2D
var original_hitbox_position: Vector2

func _ready():
	super()
	if hitbox_collision:
		original_hitbox_position = hitbox_collision.position

func enter() -> void:
	attacked = false
	player.velocity.x = 0
	flip_hitbox()
	player.animation.play(jab_anim)
	player.animation.animation_finished.connect(func(_anim): attacked = true)
	
func flip_hitbox() -> void:
	if hitbox_collision and player.sprite:
		if player.sprite.flip_h:
			hitbox_collision.position.x = -abs(original_hitbox_position.x)
		else:
			hitbox_collision.position.x = abs(original_hitbox_position.x)

func _process_input(event: InputEvent) -> State:
	if attacked and event.is_action_pressed(movement_key):
		return walk_state
	elif attacked and event.is_action_pressed(jump_key):
		return jump_state
	return null

func process_frame(delta: float) -> State:
	super(delta)
	if attacked: return idle_state
	return null

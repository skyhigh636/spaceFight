class_name EnemyUpperState
extends EnemyState

var attacked: bool
@onready var hitbox: Area2D = $HitBox
@onready var hitbox_collision: CollisionShape2D = $HitBox/CollisionShape2D
var original_hitbox_position: Vector2

func _ready():
	super()
	if hitbox_collision:
		original_hitbox_position = hitbox_collision.position

func enter() -> void:
	attacked = false
	enemy.velocity.x = 0
	flip_hitbox()
	set_attack_time()
	enemy.animation.play(upper_anim)
	enemy.animation.animation_finished.connect(func(_anim): attacked = true)

func flip_hitbox() -> void:
	if hitbox_collision and enemy.sprite:
		if enemy.sprite.flip_h:
			hitbox_collision.position.x = -abs(original_hitbox_position.x)
		else:
			hitbox_collision.position.x = abs(original_hitbox_position.x)

func process_frame(delta: float) -> State:
	super(delta)
	if attacked: 
		return idle_state
	return null

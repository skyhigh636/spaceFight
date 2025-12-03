class_name Player
extends CharacterBody2D

"""
for safekeeping, default movement template
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		_animated_sprite.play("forward")
		if Input.is_action_just_pressed("ui_left") and is_on_floor():
			_animated_sprite.stop()
			_animated_sprite.play("backward") 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("default")

	if(Input.is_action_just_pressed("attack")):
		_animated_sprite.play("jab")
	move_and_slide()
"""

@onready var state_machine: StateMachine = $"State machine"
@onready var animation: AnimationPlayer = $"Animation"

func _init(): state_machine.init()


func _process(delta): state_machine.process_frame(delta)

func _physics_process(delta): state_machine.process_physics(delta)

func _input(event): state_machine.process_input(event)

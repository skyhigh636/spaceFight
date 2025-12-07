class_name Player
extends CharacterBody2D


var state_machine: StateMachine 
var animation: AnimationPlayer
var sprite: AnimatedSprite2D

func _ready(): 
	state_machine = $"State machine"
	animation = $"Animation"
	sprite = $"Sprite"

	state_machine.init()


func _process(delta): state_machine.process_frame(delta)

func _physics_process(delta): state_machine.process_physics(delta)

func _input(event): state_machine.process_input(event)

class_name Enemy
extends CharacterBody2D

var state_machine: Node2D 
var animation: AnimationPlayer
var sprite: AnimatedSprite2D
var target: Player = null
var health: int = 100
"""
he a bit 🥀 but he got spirit, 
all states relating to this have the same logic as player object
"""
func _ready(): 
	find_target()
	state_machine = $"Enemystates"
	animation = $"Animation"
	sprite = $"Sprite"
	find_target()
	state_machine.init()


func _process(delta): 
	state_machine.process_frame(delta)

func _physics_process(delta): 
	state_machine.process_physics(delta)

func find_target() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		target = players[0]

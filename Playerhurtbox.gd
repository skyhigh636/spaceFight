class_name PlayerHurtBox
extends HurtBox


@onready var pain_state: PlayerPainState = $".."
@onready var state_machine: StateMachine = $"res://state_machine.gd"
var hit_area: Node2D

func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null: return
	super(hit_box)
	hit_area = hit_box.owner
	state_machine.change_state(pain_state)
	print("Damaged")
	

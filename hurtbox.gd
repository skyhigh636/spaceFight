class_name HurtBox
extends Area2D
var hitting_area: HitBox
# just dont bother touching this, its fine as is
# at least until ready to do the health system
func _ready():
	collision_layer = 0
	collision_mask = 2
	self.area_entered.connect(on_area_entered)
	
	
func on_area_entered(hit_box: HitBox) -> void:
	if hit_box == null: return
	hitting_area = hit_box
	print("HurtBox - Damaged! hitting_area set to: ", hitting_area)

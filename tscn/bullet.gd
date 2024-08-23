extends RigidBody3D
@onready var bullet_par=preload("res://tscn/bullet_par.tscn")


func _on_body_entered(body):
	_add_eff()
	self.queue_free()
	pass # Replace with function body.
func _add_eff():
	var temp=bullet_par.instantiate()
	self.get_parent().add_child(temp)
	temp.global_position=self.global_position
	temp.emitting=true
	pass


func _on_area_3d_area_entered(area):
	if area.is_in_group("enemy_attk_group"):
		_add_eff()
		self.queue_free()
	pass # Replace with function body.

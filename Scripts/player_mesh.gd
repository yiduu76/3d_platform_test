extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Glo.input_vec!=Vector2.ZERO:
		self.rotation.y=lerp(self.rotation.y,Glo.camera_ro_y+Glo.input_vec.angle(),0.1)
#		self.rotation.y=Glo.camera_ro_y+Glo.input_vec.angle()
	else :
		self.rotation.y=lerp(self.rotation.y,Glo.camera_ro_y,0.1)
#		self.rotation.y=Glo.camera_ro_y
	pass

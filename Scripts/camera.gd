extends Camera3D
@onready var center_pos=Vector2(480,270)
func _ready():
	pass # Replace with function body.

func _process(_delta):
	Glo.carmera_face_dir=$Marker3D1.global_position-self.global_position
	Glo.carmera_left_dir=$Marker3D2.global_position-self.global_position
	Glo.aim_at_pos=$Marker3D3.global_position
	

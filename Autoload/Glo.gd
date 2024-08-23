extends Node
@onready var carmera_face_dir=Vector3.ZERO
@onready var carmera_left_dir=Vector3.ZERO
@onready var camera_look_pos=Vector3.ZERO
@onready var camera_pos=Vector3.ZERO
@onready var camera_aiming_pos=Vector3.ZERO
@onready var camera_aim_pos=Vector3.ZERO
@onready var camera_ro_y=0.0
@onready var input_vec=Vector2.ZERO
@onready var aim_at_pos=Vector3.ZERO
func _ready():
	pass 
func _process(delta):
	
	input_vec.x=-Input.get_axis("ui_up","ui_down")
	input_vec.y=-Input.get_axis("ui_left","ui_right")
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("ui_aiming"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

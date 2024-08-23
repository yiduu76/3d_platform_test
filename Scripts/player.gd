extends CharacterBody3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var bullet_tscn=preload("res://tscn/bullet.tscn")
@onready var move_state="idel"
@onready var animation_node=$player_mesh/AnimationPlayer
@onready var animation_tree=$player_mesh/AnimationTree
@onready var speed=5.0
@onready var acting=false
@onready var input_dir=Vector2.ZERO
@onready var move_target_num=0.0
@onready var jump_target_num=0.0
@onready var shoot_target_num=0.0
@onready var runshoot_target_num=0.0
@onready var camera_spring_length=2.1
const jump_height = 4.5
func _process(delta):
	$camera_pos_margin/camera_pos/SpringArm3D.spring_length=lerp($camera_pos_margin/camera_pos/SpringArm3D.spring_length,camera_spring_length,0.1)
	if Input.is_action_just_pressed("ui_zoom_in"):
		if camera_spring_length>1.1:
			camera_spring_length-=0.1
	elif Input.is_action_just_pressed("ui_zoom_out"):
		if camera_spring_length<5.0:
			camera_spring_length+=0.1
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
	Glo.camera_look_pos=$camera_look_pos.global_position
	Glo.camera_pos=$camera_pos_margin/camera_pos.global_position
	Glo.camera_aiming_pos=$player_mesh/shoot_pos.global_position
	Glo.camera_aim_pos=$player_mesh/aim_pos.global_position
	Glo.camera_ro_y=$camera_pos_margin.rotation.y

	_move()
	if acting==false||is_on_floor():
		jump_target_num=0.0
		if acting==false:
			runshoot_target_num=0.0
			shoot_target_num=0.0
			pass
	else :pass

	if Input.is_action_pressed("ui_up")||Input.is_action_pressed("ui_down")||Input.is_action_pressed("ui_left")||Input.is_action_pressed("ui_right"):
		move_target_num=1.0
		if Input.is_action_just_pressed("ui_jump"):
			jump_target_num=1.0
			_acting(1.1)
			$jump_se.play(0)
		elif Input.is_action_just_pressed("ui_shoot"):
			runshoot_target_num=1.0
			_acting(0.3)
			_shoot()
	else :
		move_target_num=0.0
		if Input.is_action_just_pressed("ui_jump"):
			jump_target_num=1.0
			_acting(1.1)
			$jump_se.play(0)
		elif Input.is_action_just_pressed("ui_shoot"):
			shoot_target_num=1.0
			_acting(0.3)
			_shoot()
	animation_tree[&"parameters/idel_move/blend_amount"]=lerp(animation_tree[&"parameters/idel_move/blend_amount"],move_target_num,0.1)
	animation_tree[&"parameters/jump/blend_amount"]=lerp(animation_tree[&"parameters/jump/blend_amount"],jump_target_num,0.1)
	animation_tree[&"parameters/run_shoot/blend_amount"]=lerp(animation_tree[&"parameters/run_shoot/blend_amount"],runshoot_target_num,0.3)
	animation_tree[&"parameters/shoot/blend_amount"]=lerp(animation_tree[&"parameters/shoot/blend_amount"],shoot_target_num,0.3)
	move_and_slide()
func _input(event):
	if event is InputEventMouseMotion:
		_rotate(-event.relative*0.001)
func _shoot():
	$shoot_se.play(0)
	var temp=bullet_tscn.instantiate()
	self.get_parent().add_child(temp)
	temp.global_position=$player_mesh/shoot_pos.global_position
	var shoot_dir=Vector3.ZERO

	shoot_dir=$player_mesh/shoot_pos.global_position-Glo.aim_at_pos
	temp.linear_velocity=-shoot_dir

func _acting(wait_time):
	acting=true
	$act_timer.wait_time=wait_time
	$act_timer.start(0)
	pass
func _rotate(ro):
	$camera_pos_margin.rotate_y(ro.x)
	$camera_pos_margin/camera_pos.rotate_x(ro.y)
func _move():
	var vec_UD=Vector2.ZERO
	var vec_RL=Vector2.ZERO
	vec_UD.x=Input.get_axis("ui_up","ui_down")*Glo.carmera_face_dir.x*speed
	vec_UD.y=Input.get_axis("ui_up","ui_down")*Glo.carmera_face_dir.z*speed
	vec_RL.x=Input.get_axis("ui_left","ui_right")*Glo.carmera_left_dir.x*speed
	vec_RL.y=Input.get_axis("ui_left","ui_right")*Glo.carmera_left_dir.z*speed
	velocity.x=-vec_UD.x-vec_RL.x
	velocity.z=-vec_UD.y-vec_RL.y
func _on_animation_player_animation_finished(anim_name):
	pass
func _on_act_timer_timeout():
	acting=false

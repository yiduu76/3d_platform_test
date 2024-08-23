extends CharacterBody3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var state="idle"
@onready var animation_node=$enemy/AnimationPlayer
var animation_list
func _ready():
	randomize()
	animation_list=animation_node.get_animation_list()
func _physics_process(delta):
	if is_on_floor():
		pass
	else :
		velocity.y-=gravity*delta
	var face_dir=self.global_position-$Marker3D.global_position
	for i in animation_list:
		if i==state:
			animation_node.play(i)
	
	if state=="walk":
		velocity.x=face_dir.x
		velocity.z=face_dir.z
	elif state=="idle":
		velocity.x=0.0
		velocity.z=0.0
	elif state=="rotate":
		velocity.x=face_dir.x/3
		velocity.z=face_dir.z/3
		self.rotate_y(0.01)
	elif state=="die":
		velocity.x=0.0
		velocity.z=0.0
	move_and_slide()

func _on_body_area_area_entered(area):
	if area.is_in_group("attk_area"):
		velocity.y=1
		$Sound_effect/hitted.play(0)
		state="dying"
func _delete_self():
	self.queue_free()

func _on_animation_player_animation_finished(anim_name):
	match [anim_name]:
		["idle"]:
			var rand_num=randf_range(0,100)
			if rand_num<20:
				state="idle"
				$Sound_effect/walk.playing=false
			elif rand_num<60:
				state="walk"
				$Sound_effect/walk.playing=true
			else:
				state="rotate"
				$Sound_effect/walk.playing=true
		["walk"]:
			var rand_num=randf_range(0,100)
			if rand_num<20:
				state="idle"
				$Sound_effect/walk.playing=false
			elif rand_num<60:
				state="walk"
				$Sound_effect/walk.playing=true
			else:
				state="rotate"
				$Sound_effect/walk.playing=true
		["rotate"]:
			var rand_num=randf_range(0,100)
			if rand_num<20:
				state="idle"
				$Sound_effect/walk.playing=false
			elif rand_num<60:
				state="walk"
				$Sound_effect/walk.playing=true
			else:
				state="rotate"
				$Sound_effect/walk.playing=true
		["dying"]:
			self.queue_free()
		_:
			pass

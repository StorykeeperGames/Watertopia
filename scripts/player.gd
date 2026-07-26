extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 4.5
@onready var camera: Node3D = $SpringArm3D/Camera3D
@onready var anim_player: AnimationPlayer = $Mesh/AnimationPlayer
@onready var anim_tree: AnimationTree = $AnimationTree


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := camera.global_basis * Vector3(input_dir.x, 0, input_dir.y)
	direction = Vector3(direction.x, 0, direction.z).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	# Move and turn the character
	move_and_slide()
	turn_to(direction)

	var current_speed := velocity.length()
	const RUN_SPEED := 3.5

	# Handle animations
	if current_speed > RUN_SPEED:
		anim_tree.set("parameters/movement/transition_request", "run")
		# animating by calling an animation manually
		# anim_player.play("freehand_run", 0.2)
	elif current_speed > 0:
		anim_tree.set("parameters/movement/transition_request", "walk")
		# anim_player.play("freehand_walk", 0.2, lerp(0.5, 1.25, current_speed / 4))
	else:
		anim_tree.set("parameters/movement/transition_request", "idle")
		# anim_player.play("freehand_idle")


# turn the character towards the camera movement direction
func turn_to(direction: Vector3) -> void:
	if direction:
		var yaw := atan2(-direction.x, -direction.z)
		yaw = lerp_angle(rotation.y, yaw, 0.3)
		rotation.y = yaw

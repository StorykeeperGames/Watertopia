extends SpringArm3D
@export var animation_player: AnimationPlayer

# this is the same thing as the line below it, the $ is syntax sugar for get_node
# @onready var camera: Camera3D = get_node("Camera3D")
@onready var camera: Camera3D = $Camera3D
@onready var player: Node3D = get_parent()

@export var turn_rate := 35
var mouse_input: Vector2 = Vector2()
var camera_rig_height: float = position.y


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spring_length = camera.position.z


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Used for thumbstick controls
	# var look_input := Input.get_vector("view_left", "view_right", "view_up", "view_down")

	var look_input: Vector2

	# Poll for mouse input when MOUSE_MODE_CAPTURED is true
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		look_input = -mouse_input * turn_rate * delta

	rotation_degrees.x += -look_input.y
	rotation_degrees.y += look_input.x
	rotation_degrees.x = clampf(rotation_degrees.x, -70, 50)

	# clean up mouse_input
	mouse_input = Vector2()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.screen_relative

	# Toggle mouse_mode between visible and captured
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	position = player.position + Vector3(0, camera_rig_height, 0)
#	self.position = player.position

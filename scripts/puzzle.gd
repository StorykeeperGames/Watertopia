extends Node

@onready var child_node: StaticBody3D = $chest
@onready var child_pipe: CSGMesh3D = $Pipe

@onready var child_pipe_engaged := false

var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if child_node:
		child_node.interact_triggered.connect(_on_interact_triggered)


func _on_interact_triggered(message: String) -> void:
	print("Puzzle received signal! Message: ", message)

	if child_pipe:
		if tween and tween.is_running():
			tween.kill()

		var rotation_target: float = 0 if child_pipe_engaged else 90

		tween = create_tween()
		(
			tween
			. tween_property(child_pipe, "rotation:y", deg_to_rad(rotation_target), 0.2)
			. set_trans(Tween.TRANS_QUAD)
			. set_ease(Tween.EASE_OUT)
		)

		var child_pipe_color_target := Color(0, 0, 1) if child_pipe_engaged else Color(1, 0, 0)
		var new_material := StandardMaterial3D.new()
		new_material.albedo_color = child_pipe_color_target
		child_pipe.material_override = new_material

		child_pipe_engaged = !child_pipe_engaged


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends StaticBody3D

@onready var child_node: Interactable = $Interactable
@onready var child_mesh: CSGMesh3D = $CSGMesh3D

signal interact_triggered(message: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if child_node:
		child_node.interact_triggered.connect(_on_interact_triggered)


func _on_interact_triggered(message: String) -> void:
	print("Parent received signal! Message: ", message)
	if child_mesh:
		var new_material := StandardMaterial3D.new()
		new_material.albedo_color = Color(1, 0, 0)  # Red
		child_mesh.material_override = new_material

		interact_triggered.emit(message)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

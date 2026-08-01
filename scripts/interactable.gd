extends Area3D
class_name Interactable

@export var prompt_message: String = "Interact"

signal interact_triggered(message: String)


func interact(player: CharacterBody3D) -> void:
	# Override this function on specific items
	print("Interacted with: ", name)

	# Emit signal for parent to pick up
	interact_triggered.emit("Hello from child node!")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

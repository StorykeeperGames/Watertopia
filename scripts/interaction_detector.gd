extends Area3D

var current_interactable: Interactable = null
var interactables_in_range: Array[Interactable] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready")
	print("monitoring", monitoring)
	# Connect built-in Area3D signals to track items
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and current_interactable:
		current_interactable.interact(owner)  # pass the player node reference


func _on_area_entered(area: Area3D) -> void:
	print("area entered")
	if area is Interactable:
		interactables_in_range.append(area)
		_update_current_interactable()


func _on_area_exited(area: Area3D) -> void:
	if area is Interactable:
		interactables_in_range.erase(area)
		_update_current_interactable()


func _update_current_interactable() -> void:
	if interactables_in_range.size() > 0:
		# Always prioritize the closest or most recent object
		current_interactable = interactables_in_range[0]
		# TODO: Update UI overlay text here using current interactable.prompt_message
	else:
		current_interactable = null
		# TODO: Hide UI overlay text here

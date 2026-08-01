extends CSGMesh3D

var engaged: bool
signal pipe_toggled(engaged: bool)

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_color()
	if engaged:
		rotation.y = deg_to_rad(0)
	else:
		rotation.y = deg_to_rad(90)	
		
func Initialize(initial_engaged: bool) -> void:
	engaged = initial_engaged
	_rotate()
	_set_color()


func Toggle() -> void:
	engaged = !engaged
	
	_rotate()
	_set_color()
	pipe_toggled.emit(self.name, engaged)
	


func _rotate() -> void:	
	if tween and tween.is_running():
		tween.kill()
		
	var rotation_target: float = 0 if engaged else 90
	
	tween = create_tween()
	(
		tween
		. tween_property(self, "rotation:y", deg_to_rad(rotation_target), 0.2)
		. set_trans(Tween.TRANS_QUAD)
		. set_ease(Tween.EASE_OUT)
	)


func _set_color() -> void:
	var color_target := Color(0, 0, 1) if engaged else Color(1, 0, 0)
	var new_material := StandardMaterial3D.new()
	new_material.albedo_color = color_target
	material_override = new_material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

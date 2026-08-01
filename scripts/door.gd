extends StaticBody3D

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func Open() -> void:
	if tween and tween.is_running():
		tween.kill()
		
	var position_target: float = 3
	
	tween = create_tween()
	(
		tween
		. tween_property(self, "position:y", position.y + position_target, 1)
		. set_trans(Tween.TRANS_QUAD)
		. set_ease(Tween.EASE_OUT)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

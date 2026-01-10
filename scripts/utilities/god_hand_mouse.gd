extends GodHand

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var viewport = get_viewport()
	var global_mouse_pos = viewport.global_canvas_transform * viewport.get_mouse_position()
	update_grab(global_mouse_pos)

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_grab(event.position)
			else:
				end_grab()

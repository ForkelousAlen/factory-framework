extends GodHand

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	update_grab(get_mouse_global_position())

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_grab(get_mouse_global_position())
			else:
				end_grab()

func get_mouse_global_position():
	var viewport = get_viewport()
	var mouse_screen_pos = viewport.get_mouse_position()
	var mouse_global_pos = viewport.get_canvas_transform().affine_inverse() * mouse_screen_pos
	return mouse_global_pos

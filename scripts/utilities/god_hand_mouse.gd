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
	var camera = viewport.get_camera_2d()
	var mouse_screen_pos = viewport.get_mouse_position()
	var viewport_size = viewport.get_visible_rect().size
	var mouse_global_pos = \
		viewport.global_canvas_transform * \
		((mouse_screen_pos - viewport_size / 2) / camera.zoom)
	return mouse_global_pos

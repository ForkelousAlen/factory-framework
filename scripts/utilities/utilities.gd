
class_name Utilities

static func get_mouse_global_position(object: Node) -> Vector2:
	var viewport = object.get_viewport()
	var mouse_screen_pos = viewport.get_mouse_position()
	var mouse_global_pos = viewport.get_canvas_transform().affine_inverse() * mouse_screen_pos
	return mouse_global_pos
	

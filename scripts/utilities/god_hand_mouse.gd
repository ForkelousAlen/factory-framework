extends GodHand

@export
var normal_texture: Texture2D
@export
var grab_texture: Texture2D
@export
var texture_scale: float


func _ready() -> void:
	Input.set_custom_mouse_cursor(normal_texture, Input.CURSOR_ARROW, Vector2(16, 16))

func _process(_delta: float) -> void:
	update_grab(Utilities.get_mouse_global_position(self))

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_grab(Utilities.get_mouse_global_position(self))
				Input.set_custom_mouse_cursor(grab_texture, Input.CURSOR_ARROW, Vector2(16, 16))
			else:
				end_grab()
				Input.set_custom_mouse_cursor(normal_texture, Input.CURSOR_ARROW, Vector2(16, 16))

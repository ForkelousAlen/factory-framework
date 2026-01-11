extends GodHand

@onready 
var sprite: Sprite2D = $Sprite2D

@export
var normal_texture: Texture2D
@export
var grab_texture: Texture2D
@export
var texture_scale: float


func _ready() -> void:
	sprite.texture = normal_texture
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)  # 隐藏鼠标光标

func _process(_delta: float) -> void:
	update_grab(get_mouse_global_position())
	var camera = get_viewport().get_camera_2d()
	if camera != null:
		sprite.scale = Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)  * texture_scale

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_grab(get_mouse_global_position())
				sprite.texture = grab_texture
			else:
				end_grab()
				sprite.texture = normal_texture

func get_mouse_global_position():
	var viewport = get_viewport()
	var mouse_screen_pos = viewport.get_mouse_position()
	var mouse_global_pos = viewport.get_canvas_transform().affine_inverse() * mouse_screen_pos
	return mouse_global_pos

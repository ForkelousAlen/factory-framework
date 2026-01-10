extends Node2D

@onready var camera: Camera2D = $Camera2D

@export var move_speed: float = 300.
@export var rotate_speed: float = 100.
@export var zoom_speed: float = 1.


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		global_position += Vector2.UP.rotated(global_rotation) / camera.zoom.y * delta * move_speed
	if Input.is_action_pressed("move_down"):
		global_position += Vector2.DOWN.rotated(global_rotation) / camera.zoom.y * delta * move_speed
	if Input.is_action_pressed("move_left"):
		global_position += Vector2.LEFT.rotated(global_rotation) / camera.zoom.x * delta * move_speed
	if Input.is_action_pressed("move_right"):
		global_position += Vector2.RIGHT.rotated(global_rotation) / camera.zoom.x * delta * move_speed
	if Input.is_action_pressed("rotate_clockwise"):
		global_rotation_degrees += delta * rotate_speed
	if Input.is_action_pressed("rotate_anticlockwise"):
		global_rotation_degrees -= delta * rotate_speed
	if Input.is_action_pressed("zoom_small"):
		camera.zoom -= Vector2(1, 1) * delta * zoom_speed
	if Input.is_action_pressed("zoom_large"):
		camera.zoom += Vector2(1, 1) * delta * zoom_speed

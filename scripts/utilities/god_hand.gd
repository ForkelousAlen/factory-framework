class_name GodHand
extends StaticBody2D

@onready var raycast: RayCast2D = $RayCast2D
@onready var drag_spring: DampedSpringJoint2D = $DampedSpringJoint2D

var original_gravity_scale: float
var original_linear_damp: float
var original_angular_damp: float

var grabbed_object: RigidBody2D = null:
	set(value):
		grabbed_object = value
		drag_spring.node_a = value.get_path() if value != null else NodePath()


func _ready() -> void:
	drag_spring.node_b = self.get_path()

func _process(_delta: float) -> void:
	pass

func start_grab(grab_position: Vector2):
	raycast.global_position = grab_position
	raycast.target_position = Vector2.ZERO
	raycast.force_raycast_update()
	print(raycast.is_colliding())

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider is RigidBody2D:
			grabbed_object = collider
			original_gravity_scale = grabbed_object.gravity_scale
			original_linear_damp = grabbed_object.linear_damp
			original_angular_damp = grabbed_object.angular_damp
			grabbed_object.gravity_scale = 0
			grabbed_object.linear_damp = 1.
			grabbed_object.angular_damp = 1.

func end_grab():
	if grabbed_object:
		grabbed_object.gravity_scale = original_gravity_scale
		grabbed_object.linear_damp = original_linear_damp
		grabbed_object.angular_damp = original_angular_damp
		grabbed_object = null

func update_grab(new_position: Vector2):
	global_position = new_position

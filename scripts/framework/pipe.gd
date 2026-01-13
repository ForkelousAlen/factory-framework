class_name Pipe
extends Line2D

@onready
var pin_body_a: RigidBody2D = $PinBodyA
@onready
var pin_body_b: RigidBody2D = $PinBodyB
@onready
var pin_joint_a: PinJoint2D = $PinJointA
@onready
var pin_joint_b: PinJoint2D = $PinJointB
@onready
var spring_joint: DampedSpringJoint2D = $SpringJoint

@export
var machine_a: Machine
@export
var machine_b: Machine


func _ready() -> void:
	if machine_a != null and machine_b != null:
		connect_machine(machine_a, machine_b)

func _process(_delta: float) -> void:
	assert (machine_a != null and machine_b != null)
	var new_points: PackedVector2Array = []
	new_points.append(machine_a.global_position)
	new_points.append(machine_b.global_position)
	points = new_points

## 将MachineA与MachineB通过该Pipe进行连接
func connect_machine(a: Machine, b: Machine):	
	pin_body_a.global_position = a.global_position
	pin_body_b.global_position = b.global_position
	pin_joint_a.global_position = a.global_position
	pin_joint_b.global_position = b.global_position
	pin_joint_a.node_a = a.get_path()
	pin_joint_a.node_b = pin_body_a.get_path()
	pin_joint_b.node_a = b.get_path()
	pin_joint_b.node_b = pin_body_b.get_path()
	
	var delta_pos = b.global_position - a.global_position
	var spring_len = delta_pos.length()
	var angle = delta_pos.angle() - PI / 2
	spring_joint.global_position = pin_body_a.global_position
	spring_joint.length = spring_len
	spring_joint.global_rotation = angle
	spring_joint.node_a = pin_body_a.get_path()
	spring_joint.node_b = pin_body_b.get_path()

## Pipe提供给Machine调用的资源拉取接口
func resource_request(requester: Machine, amount: float):
	if requester == machine_a:
		machine_b.resource_port(amount)
	elif  requester == machine_b:
		machine_a.resource_port(amount)

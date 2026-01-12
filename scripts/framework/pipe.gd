class_name Pipe
extends Line2D

@onready
var joint: PinJoint2D = $PinJoint2D

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
	a.add_child(self)
	joint.global_position = a.global_position
	joint.node_a = a.get_path()
	joint.node_b = b.get_path()

## Pipe提供给Machine调用的资源拉取接口
func resource_request(requester: Machine, amount: float):
	if requester == machine_a:
		machine_b.resource_port(amount)
	elif  requester == machine_b:
		machine_a.resource_port(amount)

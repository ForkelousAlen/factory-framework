@abstract
class_name Pipe
extends Line2D

enum Direction {
	IMPORT, 
	EXPORT,
	BIDIRECTION,
}

enum Type {
	ENERGY,
	FUELMENT,
}

@export
var type: Type

var _machine_a: Machine
var _machine_b: Machine
var _connect_id_a: int
var _connect_id_b: int
var _position_node_a: Node2D
var _position_node_b: Node2D


func _process(_delta: float) -> void:
	assert (_machine_a != null and _machine_b != null)
	var new_points: PackedVector2Array = []
	new_points.append(_position_node_a.global_position)
	new_points.append(_position_node_b.global_position)
	points = new_points

## 将MachineA与MachineB通过该Pipe进行连接
## 返回是否连接成功
@abstract
func connect_machine(a: Machine, b: Machine) -> bool

## Pipe提供给Machine调用的资源拉取接口
func pull_substance(requester: Machine, amount: float) -> float:
	if requester == _machine_a:
		return _machine_b.resource_port(_connect_id_b, amount)
	elif requester == _machine_b:
		return _machine_a.resource_port(_connect_id_a, amount)
	else:
		return 0.

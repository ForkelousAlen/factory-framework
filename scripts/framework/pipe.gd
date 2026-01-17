@abstract
class_name Pipe
extends Line2D

enum Direction {
	IMPORT, 
	EXPORT,
}

enum Type {
	ENERGY,
	FUELMENT,
}

@export
var type: Type

var _machine_source: Machine
var _machine_target: Machine
var _connect_id_source: int
var _connect_id_target: int
var _position_node_source: Node2D
var _position_node_target: Node2D


func _process(_delta: float) -> void:
	assert (_machine_source != null and _machine_target != null)
	var new_points: PackedVector2Array = []
	new_points.append(_position_node_source.global_position)
	new_points.append(_position_node_target.global_position)
	points = new_points

## 将MachineA与MachineB通过该Pipe进行连接
## 返回是否连接成功
@abstract
func connect_machine(source_machine: Machine, target_machine: Machine) -> bool

## Pipe提供给Machine调用的资源拉取接口
func pull_substance(amount: float) -> float:
	return _machine_target.resource_port(_connect_id_target, amount)

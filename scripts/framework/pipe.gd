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
		joint.node_a = machine_a.get_path()
		joint.node_b = machine_b.get_path()

func _process(_delta: float) -> void:
	assert (machine_a != null and machine_b != null)
	var new_points: PackedVector2Array = []
	new_points.append(machine_a.global_position)
	new_points.append(machine_b.global_position)
	points = new_points
	
func _connect(a: Machine, b: Machine):
	a.add_child(self)
	joint.node_a = a.get_path()
	joint.node_b = b.get_path()
	

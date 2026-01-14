extends Pipe

@export
var ma: Machine
@export
var mb: Machine


func _ready() -> void:
	connect_machine(ma, mb)

func connect_machine(a: Machine, b: Machine):
	var connect_info_a = a.connect_pipe(self, Direction.BIDIRECTION)
	if !connect_info_a.succeed:
		return
	var connect_info_b = b.connect_pipe(self, Direction.BIDIRECTION)
	if !connect_info_b.succeed:
		a.cancel_connect_pipe(connect_info_a.connect_id)
		return
	
	_machine_a = a
	_machine_b = b
	_connect_id_a = connect_info_a.connect_id
	_connect_id_b = connect_info_b.connect_id
	_position_node_a = connect_info_a.position_node
	_position_node_b = connect_info_b.position_node
	
	var spring_joint: DampedSpringJoint2D = $SpringJoint
	var delta_pos = _position_node_b.global_position - _position_node_a.global_position
	var spring_len = delta_pos.length()
	var angle = delta_pos.angle() - PI / 2
	spring_joint.global_position = _position_node_a.global_position
	spring_joint.length = spring_len
	spring_joint.global_rotation = angle
	spring_joint.node_a = _machine_a.get_path()
	spring_joint.node_b = _machine_b.get_path()

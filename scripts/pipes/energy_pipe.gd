extends Pipe

@export
var ma: Machine
@export
var mb: Machine


func _init() -> void:
	type = Type.ENERGY

func _ready() -> void:
	connect_machine(ma, mb)
	var anima_player: AnimationPlayer = $AnimationPlayer
	anima_player.play("transport")

func connect_machine(source_machine: Machine, target_machine: Machine) -> bool:
	var connect_info_source = source_machine.connect_pipe(self, Direction.EXPORT)
	if !connect_info_source.succeed:
		return false
	var connect_info_target = target_machine.connect_pipe(self, Direction.IMPORT)
	if !connect_info_target.succeed:
		source_machine.cancel_connect_pipe(connect_info_source.connect_id)
		return false
	
	_machine_source = source_machine
	_machine_target = target_machine
	_connect_id_source = connect_info_source.connect_id
	_connect_id_target = connect_info_target.connect_id
	_position_node_source = connect_info_source.position_node
	_position_node_target = connect_info_target.position_node
	
	var spring_joint: DampedSpringJoint2D = $SpringJoint
	var delta_pos = _position_node_target.global_position - _position_node_source.global_position
	var spring_len = delta_pos.length()
	var angle = delta_pos.angle() - PI / 2
	spring_joint.global_position = _position_node_source.global_position
	spring_joint.length = spring_len
	spring_joint.global_rotation = angle
	spring_joint.node_a = _machine_source.get_path()
	spring_joint.node_b = _machine_target.get_path()

	return true

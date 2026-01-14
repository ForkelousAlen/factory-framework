extends Machine

var _import_pipes: Dictionary[int, Pipe]  # 输入管道
var _export_pipes: Dictionary[int, Pipe]  # 出入管道
var _pipe_counter: int = 0  # 管道计数


func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult:
	match direction:
		Pipe.Direction.IN:
			_import_pipes[_pipe_counter] = pipe
		Pipe.Direction.OUT:
			_export_pipes[_pipe_counter] = pipe
		Pipe.Direction.BIDIRECTION:
			_import_pipes[_pipe_counter] = pipe
			_export_pipes[_pipe_counter] = pipe
	
	var result = ConnectResult.new()
	result.succeed = true
	result.position_node = self
	result.connect_id = _pipe_counter
	_pipe_counter += 1
	
	return result

func cancel_connect_pipe(connect_id: int):
	_import_pipes.erase(connect_id)
	_export_pipes.erase(connect_id)

func substance_port(connect_id: int, amount: float) -> float:
	return 0.

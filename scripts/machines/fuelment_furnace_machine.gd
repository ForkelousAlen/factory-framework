extends Machine


func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult:
	var result = ConnectResult.new()
	result.succeed = true
	result.position_node = self
	result.connect_id = 0
	return result

func cancel_connect_pipe(connect_id: int):
	pass

func substance_port(connect_id: int, amount: float) -> float:
	return 0.

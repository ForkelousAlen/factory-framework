extends Machine

var _collected_amount: float = 0.0  # 存储收集到的物资量
var _pipe: Pipe = null  # 连接的管道


func _ready():
	var detection_area: Area2D = $DetectionArea
	detection_area.body_entered.connect(_on_detection_area_body_entered)

func _on_detection_area_body_entered(body: Node):
	var substance := body as Substance
	if substance != null and substance.type == Substance.Type.FUELMENT:
		_collected_amount += substance.amount
		substance.destroy()

func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult:
	assert(pipe != null)

	var result = ConnectResult.new()
	result.succeed = false
	result.position_node = self
	result.connect_id = -1
	
	if direction == Pipe.Direction.EXPORT and pipe.type == Pipe.Type.FUELMENT and _pipe == null:
		_pipe = pipe
		result.succeed = true
		result.connect_id = 0
	
	return result

func cancel_connect_pipe(connect_id: int) -> void:
	assert(connect_id == 0)
	_pipe = null

func substance_port(connect_id: int, amount: float) -> float:
	assert(connect_id == 0)
	var provide_amount = min(amount, _collected_amount)
	_collected_amount -= provide_amount
	return provide_amount

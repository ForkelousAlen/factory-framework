extends Machine

@export
var energy_store: float = 0.
@export
var max_energy_store: float = 1000.
@export
var fuelment_comsumption_rate: float = 100.  # 燃料消耗率
@export
var energy_conversion: float = 100.  # 能量转换率

var _import_pipe: Pipe = null
var _export_pipes: Dictionary[int, Pipe] = {}
var _export_pipe_counter: int = 0  # 管道计数


func _ready() -> void:
	var anima_sprite: AnimatedSprite2D = $AnimatedSprite2D
	anima_sprite.play("work")

func _process(delta: float) -> void:
	if _import_pipe != null and energy_store < max_energy_store:
		var amount = _import_pipe.pull_substance(delta * 100.)
		energy_store += amount * energy_conversion

func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult:
	assert(pipe != null)

	var result = ConnectResult.new()
	result.succeed = false
	result.position_node = self

	if direction == Pipe.Direction.IMPORT and pipe.type == Pipe.Type.FUELMENT and _import_pipe == null:
		_import_pipe = pipe
		result.connect_id = -1
		result.succeed = true

	elif direction == Pipe.Direction.EXPORT and pipe.type == Pipe.Type.ENERGY:
		_export_pipes[result.connect_id] = pipe
		_export_pipe_counter += 1
		result.connect_id = _export_pipe_counter
		result.succeed = true

	return result

func cancel_connect_pipe(connect_id: int) -> void:
	if connect_id == -1:
		_import_pipe = null
	elif connect_id >= 0:
		_export_pipes.erase(connect_id)

func substance_port(connect_id: int, amount: float) -> float:
	assert(connect_id != -1)
	assert(_export_pipes.has(connect_id))
	energy_store -= amount
	return amount

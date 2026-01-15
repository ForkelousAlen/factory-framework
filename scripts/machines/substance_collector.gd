extends Machine

var collected_amount: float = 0.0  # 存储收集到的物资量


func _ready() -> void:
	# 设置为Area2D以支持碰撞检测
	# if not self is Area2D:
	# 	# 如果当前节点不是Area2D，则添加碰撞检测信号监听
	# 	var collision_area = Area2D.new()
	# 	var collision_shape = CollisionShape2D.new()
		
	# 	# 创建一个圆形碰撞形状
	# 	var circle_shape = CircleShape2D.new()
	# 	circle_shape.radius = 32.0
	# 	collision_shape.shape = circle_shape
		
	# 	collision_area.add_child(collision_shape)
	# 	self.add_child(collision_area)
		
	# 	# 连接碰撞信号
	# 	collision_area.body_entered.connect(_on_body_entered)
	pass


func _process(delta: float) -> void:
	pass


# 当有物体进入碰撞区域时调用
func _on_body_entered(body):
	# 检查进入的物体是否是Substance类型
	if body is Substance:
		# 收集Substance的量
		collected_amount += body.amount
		
		# 销毁Substance对象
		body.queue_free()


func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult:
	var result = ConnectResult.new()
	result.succeed = false
	result.position_node = self
	result.connect_id = -1
	
	# 物资收集器不直接参与管道连接，但可以提供收集到的物资
	if direction == Pipe.Direction.EXPORT:
		result.succeed = true
		result.connect_id = 0  # 使用0作为连接ID表示这是导出连接
	
	return result


func cancel_connect_pipe(connect_id: int) -> void:
	# 物资收集器不需要取消连接逻辑
	pass


func substance_port(connect_id: int, amount: float) -> float:
	# 提供收集到的物资，不超过已收集的数量
	var provide_amount = min(amount, collected_amount)
	collected_amount -= provide_amount
	return provide_amount

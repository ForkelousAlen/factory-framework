@abstract
class_name Machine
extends PhysicsBody2D

class ConnectResult:
	var succeed: bool
	var connect_id: int
	var position_node: Node2D


## Machine遭受到攻击时调用该函数
func take_damage():
	pass

## Machine与Pipe建立连接
@abstract
func connect_pipe(pipe: Pipe, direction: Pipe.Direction) -> ConnectResult

## Machine与Pipe取消建立连接
@abstract
func cancel_connect_pipe(connect_id: int)

## Machine的资源供给接口
## Machine对资源的获取采取“拉式模式”，即目标Machine主动向源Machine索取资源
@abstract
func substance_port(connect_id: int, amount: float) -> float

## Machine对象被选中的调用函数
func selected():
	var sprite: Sprite2D = $Sprite2D
	if sprite != null:
		sprite.modulate = Color.GREEN

## Machine对象被取消选中的调用函数
func cancel_selected():
	var sprite: Sprite2D = $Sprite2D
	if sprite != null:
		sprite.modulate = Color.WHITE

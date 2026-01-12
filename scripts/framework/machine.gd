class_name Machine
extends PhysicsBody2D


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

## Machine遭受到攻击时调用该函数
func take_damage():
	pass

## Machine与Pipe的连接测试
## Pipe尝试与Machine连接时，调用该函数进行可连接性判断
func try_connect_pipe() -> bool:
	return true

## Machine正式与Pipe建立连接
## 只有在MachineA与MachineB之间能够通过Pipe进行连接，才会调用该函数
func connect_pipe() -> bool:
	return true

## Machine的资源供给接口
## Machine对资源的获取采取“拉式模式”，即目标Machine主动向源Machine索取资源。
func resource_port(amount: float):
	pass

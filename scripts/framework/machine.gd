class_name Machine
extends PhysicsBody2D


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _take_damage():
	pass

## Machine对资源的获取采取“拉式模式”，即目标Machine主动向源Machine索取资源。
func _resource_port():
	pass

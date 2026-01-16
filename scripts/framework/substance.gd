@abstract
class_name Substance
extends Node2D

enum Type {
	NONE,
	FUELMENT,
}

@export
var type: Type = Type.NONE
@export
var amount: float = 0.


## 物质被摧毁（收集）
func destroy() -> void:
	queue_free()

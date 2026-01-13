extends Node2D

@onready 
var raycast: RayCast2D = $RayCast2D

var machine_a: Machine
var machine_b: Machine

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("select"):
		global_position = Utilities.get_mouse_global_position(self)
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var machine := raycast.get_collider() as Machine
			if machine != null:
				machine.selected()

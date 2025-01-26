extends Camera3D

@export var pan_speed: float = 1.0  # Speed of the pan

func _process(delta: float):
	current = true
	

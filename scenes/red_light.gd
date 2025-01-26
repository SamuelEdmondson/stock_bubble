extends SpotLight3D

@export var blink_count: int = 5
@export var blink_interval: float = 0.5

func blink_light():
	
	for i in range(blink_count * 2):
		visible = !visible
		$RedLightEmission.visible = !$RedLightEmission.visible
		await get_tree().create_timer(blink_interval).timeout

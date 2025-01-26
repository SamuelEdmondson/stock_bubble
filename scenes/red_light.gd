extends SpotLight3D

@export var positive_color: Color
@export var positive_energy: float = .5
@export var positive_blink_count: int = 5
@export var positive_blink_interval: float = 0.5

@export var negative_color: Color
@export var negative_energy: float = .5
@export var negative_blink_count: int = 5
@export var negative_blink_interval: float = 0.5

@export var bubble_color: Color
@export var bubble_energy: float = 1
@export var bubble_blink_count: int = 5
@export var bubble_blink_interval: float = 0.5

func _ready() -> void:
	visible = false
	$LightEmission.visible = false
	
func blink_positive_light():
	
	light_color = positive_color
	$LightEmission.light_color = positive_color
	light_energy = positive_energy
	$LightEmission.light_energy = positive_energy
	
	for i in range(positive_blink_count * 2):
		visible = !visible
		$LightEmission.visible = !$LightEmission.visible
		await get_tree().create_timer(positive_blink_interval).timeout
	
	visible = false
	$LightEmission.visible = false

func blink_negative_light():
	
	light_color = negative_color
	$LightEmission.light_color = negative_color
	light_energy = negative_energy
	$LightEmission.light_energy = negative_energy
	
	for i in range(negative_blink_count * 2):
		visible = !visible
		$LightEmission.visible = !$LightEmission.visible
		await get_tree().create_timer(negative_blink_interval).timeout
	
	visible = false
	$LightEmission.visible = false
		
func blink_bubble_light():
	
	light_color = bubble_color
	$LightEmission.light_color = bubble_color
	light_energy = bubble_energy
	$LightEmission.light_energy = bubble_energy
	
	for i in range(bubble_blink_count * 2):
		visible = !visible
		$LightEmission.visible = !$LightEmission.visible
		await get_tree().create_timer(bubble_blink_interval).timeout
	
	visible = false
	$LightEmission.visible = false

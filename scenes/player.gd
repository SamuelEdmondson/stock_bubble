extends Node3D
signal on_keyboard_press

@onready var camera = $Camera
var rayOrigin = Vector3()
var rayEnd = Vector3()

func ready():
	pass

func _physics_process(delta: float):
	var space_state = get_world_3d().direct_space_state
	var cam = $Camera
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 20
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	if result && Input.is_action_just_pressed("click"):
		on_keyboard_press.emit()

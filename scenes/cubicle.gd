extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Retrieve the texture and set it to the viewport quad.
	$"Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Glowing Screen_Screen Emission_0".material_override.albedo_texture = viewport.get_texture()

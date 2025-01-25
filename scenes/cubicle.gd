extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Retrieve the texture and set it to the viewport quad.
	$"Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Glowing Screen_Screen Emission_0".material_override.albedo_texture = viewport.get_texture()


func _on_player_on_keyboard_press() -> void:
	if $SubViewport/Graph.is_currently_bought:
		sell_stock()
		$SubViewport/Graph.is_currently_bought = !$SubViewport/Graph.is_currently_bought
	else:
		buy_stock()
		$SubViewport/Graph.is_currently_bought = !$SubViewport/Graph.is_currently_bought

func buy_stock():
	print("bought stock!")

func sell_stock():
	print("sold stock!")

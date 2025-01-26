extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Retrieve the texture and set it to the viewport quad.
	$"Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Glowing Screen_Screen Emission_0".material_override.albedo_texture = viewport.get_texture()


func buy_or_sell_stock(money: int):
	if $SubViewport/Graph.is_currently_bought:
		sell_stock(money)
		$SubViewport/Graph.is_currently_bought = !$SubViewport/Graph.is_currently_bought
	else:
		buy_stock(money)
		$SubViewport/Graph.is_currently_bought = !$SubViewport/Graph.is_currently_bought

func buy_stock(money: int):
	print("bought stock!")
	$SubViewport/Graph.buy_stock(money)

func sell_stock(money: int):
	print("sold stock!")
	return $SubViewport/Graph.sell_stock()

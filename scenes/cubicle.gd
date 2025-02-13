extends Node3D

func _ready():
	# Clear the viewport.
	var viewport = $SubViewport
	$SubViewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)

	# Retrieve the texture and set it to the viewport quad.
	$"Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Glowing Screen_Screen Emission_0".material_override.albedo_texture = viewport.get_texture()

func buy_stock(money: int):
	print("bought stock!")
	$SubViewport/Graph.buy_stock(money)

func sell_stock():
	print("sold stock!")
	return $SubViewport/Graph.sell_stock()


func _on_graph_won_game() -> void:
	get_tree().change_scene_to_file("res://you_won.tscn")

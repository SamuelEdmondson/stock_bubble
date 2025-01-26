extends Node3D
var money = 2700
var stock_bought = false

func _ready():
	pass
	
func _on_player_on_keyboard_press():
	if stock_bought == false:
		$Cubicle.buy_stock(money)
		$KeyboardSound.press()
		stock_bought = true
	else:
		get_tree().change_scene_to_file("res://titl_screen.gd")
		money = $Cubicle.sell_stock()
		stock_bought = false
		$KeyboardSound.press()

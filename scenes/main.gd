extends Node3D
var starting_money = 2700

func _on_player_on_keyboard_press():
	var money = $Cubicle.buy_or_sell_stock(starting_money)
	if money != null:
		starting_money = money

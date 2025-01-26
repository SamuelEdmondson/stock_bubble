extends Label
var cash : int = 1500

func update_cash(value):
	cash = round(value)
	text = "Cash: $" + str(round(value))
	set("theme_override_colors/font_color",Color.WHITE)

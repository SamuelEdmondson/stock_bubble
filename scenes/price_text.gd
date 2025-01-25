extends Label

func show_price_red(price):
	text = price + "-"
	set("theme_override_colors/font_color",Color.RED)
	
func show_price_green(price):
	text = price + "+"
	set("theme_override_colors/font_color",Color.GREEN)

extends Label

func update_profit(value):	
	if round(value) < 0:
		text = "-$" + str(round(value)*-1)
		set("theme_override_colors/font_color",Color.RED)
	else:
		text = "+$" + str(round(value))
		set("theme_override_colors/font_color",Color.GREEN)

func clear_profit():
	text = ""

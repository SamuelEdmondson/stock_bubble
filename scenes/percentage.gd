extends Label

func update_percentage(value):
	if (round(value*100) < 0):
		text = str(round(value*100)) + "%"
		set("theme_override_colors/font_color",Color.RED)
	else:
		text = "+" + str(round(value*100)) + "%"
		set("theme_override_colors/font_color",Color.GREEN)
	

func clear_percentage():
	text = ""

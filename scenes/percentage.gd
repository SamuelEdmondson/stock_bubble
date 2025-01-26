extends Label

func update_percentage(value):
	text = str(round(value*100)) + "%"
	set("theme_override_colors/font_color",Color.RED)

func clear_percentage():
	text = ""

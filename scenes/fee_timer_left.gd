extends Label

func update_fee_timer(value):
	text = str(round(value)) + "s"
	set("theme_override_color/font_color", Color.RED)

func clear_fee_timer():
	text = ""

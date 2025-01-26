extends Label

func update_fee(value):
	text = "Fee: $" + str(round(value))
	set("theme_override_color/font_color", Color.RED)

func clear_fee_cost():
	text = ""

extends Label

func update_portfolio(value):
	text = "Portfolio: $" + str(round(value))
	set("theme_override_colors/font_color",Color.WHITE)

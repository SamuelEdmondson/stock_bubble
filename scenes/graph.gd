extends Node2D

var points = []
var counter = 0
var lastPrice = 1000
var currentPrice
var bought_price
var sold_price
var bought_with_money

@export var display_percentage = false
@export var is_currently_bought = false
@export var texture: Texture2D
@export var background_color: Color

func _ready():
	pass
	#var counter = 0
	#while (counter < 50):
		#points.append(Vector2(counter*12, randf_range(0, 400)))
		#counter += 1

func _process(delta):
	
	if points.size() > 30:
		points.pop_front()
	for i in range(points.size()):
			points[i].x = points[i].x - 5*delta
			
	queue_redraw()
	
	if ($NewPriceTimer.is_stopped()):
		$NewPriceTimer.wait_time = randf_range(1, 5)
		$NewPriceTimer.start()
		currentPrice = lastPrice + randi_range(-5, 5)
		var shiftValue = lastPrice - currentPrice
		
		if (currentPrice >= lastPrice):
			$"../TextElements/PriceText".show_price_green(str(currentPrice))
		else:
			$"../TextElements/PriceText".show_price_red(str(currentPrice))
		
		for i in range(points.size()):
			points[i].y = points[i].y - shiftValue
		
		points.append(Vector2(195, 100))
		counter += 1
		lastPrice = currentPrice
		
		if (display_percentage):
			$"../TextElements/ProfitLabels/Percentage".update_percentage(-1 + (currentPrice*1.0 / bought_price*1.0))
			$"../TextElements/ProfitLabels/Profit".update_profit((currentPrice*1.0 / bought_price*1.0) * bought_with_money*1.0 - bought_with_money)
			$"../TextElements/Portfolio".update_portfolio((currentPrice*1.0 / bought_price*1.0) * bought_with_money*1.0)
		queue_redraw()
		#for i in range(points.size()):
			#print("point edited?")
			#points[i].x = points[i].x - 12
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(600, 600)), Color("0C2A29"))
	draw_polyline(points, Color("24EAC9"), 2, true)
	for point in points:
		draw_circle(point, 2, Color.BLACK, true, 1)
	
func buy_stock(money: int):
	bought_price = currentPrice
	print("bought at " + str(bought_price))
	display_percentage = true
	bought_with_money = money
	$"../TextElements/ProfitLabels/Percentage".update_percentage(0)
	$"../TextElements/ProfitLabels/Profit".update_profit(0)
	$"../TextElements/Cash".update_cash(0)
	$"../TextElements/Portfolio".update_portfolio(bought_with_money)
	
func sell_stock():
	# They sell their shares recieving multiplied earning BUT there is a flat fee of 10 bucks (also maybe it will take some time to get out)
	var returned_money = round(bought_with_money * currentPrice*1.0 / bought_price*1.0 - 10)
	print(currentPrice)
	print(bought_price)
	print("sold and got " + str(returned_money))
	display_percentage = false
	$"../TextElements/ProfitLabels/Percentage".clear_percentage()
	$"../TextElements/ProfitLabels/Profit".clear_profit()
	$"../TextElements/Cash".update_cash(round(returned_money))
	$"../TextElements/Portfolio".update_portfolio(0)
	return returned_money

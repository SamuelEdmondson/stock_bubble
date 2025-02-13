extends Node2D

var points = []
var counter = 0
var lastPrice = 9223372036854775807 * .5
var currentPrice
var bought_price
var sold_price
var bought_with_money
var quota = 10000
var fee = 0

signal won_game

var is_in_positive_market_shift = false
var is_in_negative_market_shift = false
var is_in_bubble_market_shift = false

@export var display_percentage = false
@export var is_currently_bought = false
@export var texture: Texture2D
@export var background_color: Color

func _ready():
	$MarketEventTimer.start()
	#var counter = 0
	#while (counter < 50):
		#points.append(Vector2(counter*12, randf_range(0, 400)))
		#counter += 1

func _process(delta):
	
	if (!$FeeTimer.is_stopped()):
		$"../TextElements/ProfitLabels/FeeTimerLeft".update_fee_timer($FeeTimer.time_left)
	else:
		$"../TextElements/ProfitLabels/FeeCost".clear_fee_cost()
		$"../TextElements/ProfitLabels/FeeTimerLeft".clear_fee_timer()
		fee = 0
	
	if ($PositiveShiftTimer.is_stopped()):
		#print("is_in_positive_market_shift is set to false")
		is_in_positive_market_shift = false
	if ($NegativeShiftTimer.is_stopped()):
		#print("is_in_negative_market_shift is set to false")
		is_in_negative_market_shift = false
	if ($BubbleShiftTimer.is_stopped()):
		#print("is_in_bubble_market_shift is set to false")
		is_in_bubble_market_shift = false
	
	if points.size() > 30:
		points.pop_front()
	for i in range(points.size()):
			points[i].x = points[i].x - 20*delta
			
	queue_redraw()
	
	if ($MarketEventTimer.is_stopped()):
		is_in_positive_market_shift = false
		is_in_negative_market_shift = false
		is_in_bubble_market_shift = false
		$MarketEventTimer.wait_time = randf_range(5, 10)
		$MarketEventTimer.start()
		print("stopped")
		var num = randi_range(0, 11)
		if num == 11:
			bubble_market_shift()
		elif num in range(0, 6):
			positive_market_shift()
		else:
			negative_market_shift()
		
	if ($NewPriceTimer.is_stopped()):
		#$"../../Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Light".blink_positive_light()
		$NewPriceTimer.wait_time = randf_range(.25, .5)
		$NewPriceTimer.start()
		currentPrice = generate_next_price()
		var shiftRatio = (currentPrice*1.0) / (lastPrice*1.0)
		var shiftValue = log(lastPrice) - log(currentPrice)
		
		
		for i in range(points.size()):
			points[i].y = points[i].y - shiftValue*200
		
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
	draw_rect(Rect2(Vector2(0, 0), Vector2(600, 600)), Color("000000"))
	draw_polyline(points, Color("1DF649"), 2, true)
	#for point in points:
		#draw_circle(point, 2, Color.BLACK, true, 1)
	
func buy_stock(money: int):
	bought_price = currentPrice
	print("bought at " + str(bought_price))
	display_percentage = true
	bought_with_money = money
	$"../TextElements/ProfitLabels/Percentage".update_percentage(0)
	$"../TextElements/ProfitLabels/Profit".update_profit(0)
	$"../TextElements/Cash".update_cash(0)
	$"../TextElements/Portfolio".update_portfolio(bought_with_money)
	$FeeTimer.start()
	fee = bought_with_money * .2
	$"../TextElements/ProfitLabels/FeeCost".update_fee(bought_with_money * .2)
	
func sell_stock():
	# They sell their shares recieving multiplied earning BUT there is a flat fee of 10 bucks (also maybe it will take some time to get out)
	var returned_money = round(bought_with_money * currentPrice*1.0 / bought_price*1.0 - 10)
	
	if !$FeeTimer.is_stopped():
		returned_money -= fee
	print(currentPrice)
	print(bought_price)
	print("sold and got " + str(returned_money))
	display_percentage = false
	$"../TextElements/ProfitLabels/Percentage".clear_percentage()
	$"../TextElements/ProfitLabels/Profit".clear_profit()
	$"../TextElements/Cash".update_cash(round(returned_money))
	$"../TextElements/Portfolio".update_portfolio(0)
	
	#end game if they are above amount:
	if returned_money >= quota:
		get_tree().change_scene_to_file("res://you_won.tscn")
		
	if returned_money < 100:
		get_tree().change_scene_to_file("res://quota_unmet.tscn")
	return returned_money

func positive_market_shift():
	is_in_positive_market_shift = true
	$PositiveShiftTimer.start()
	$"../../Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Light".blink_positive_light()
	
func bubble_market_shift():
	is_in_bubble_market_shift = true
	$BubbleShiftTimer.start()
	print("blinking bubble light")
	$"../../Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Light".blink_bubble_light()

func negative_market_shift():
	is_in_negative_market_shift = true
	$NegativeShiftTimer.start()
	$"../../Sketchfab_model/c7ca0b3869ba42d1ace1e163b90d388b_fbx/RootNode/Glowing Screen/Light".blink_negative_light()

func generate_next_price():
	if is_in_positive_market_shift:
		print("generated positive")
		return lastPrice * randf_range(1, 1.20)
		
	if is_in_negative_market_shift:
		print("generated negative")
		return lastPrice * randf_range(.80, 1)
		
	if is_in_bubble_market_shift:
		print(lastPrice)
		print("generated bubble")
		return lastPrice * randf_range(.5, 1)
	
	else:
		print("generated normal")
		print(lastPrice)
		return lastPrice * randf_range(.98, 1.02)

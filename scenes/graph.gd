extends Node2D

var points = []
var counter = 0
var lastPrice = 1000
var currentPrice

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
		currentPrice = lastPrice + randi_range(-25, 25)
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
		queue_redraw()
		#for i in range(points.size()):
			#print("point edited?")
			#points[i].x = points[i].x - 12
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, 0), Vector2(600, 600)), Color("0C2A29"))
	draw_polyline(points, Color("24EAC9"), 6, true)
	for point in points:
		draw_circle(point, 2, Color.BLACK, true, 1)
	
	
		

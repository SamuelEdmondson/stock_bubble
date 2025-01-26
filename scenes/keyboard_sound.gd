extends AudioStreamPlayer3D

var keyboard_sounds: Array = []

func _ready():
	keyboard_sounds.append(load("res://keyboard_sounds/keyboard1.wav"))
	keyboard_sounds.append(load("res://keyboard_sounds/keyboard2.wav"))
	keyboard_sounds.append(load("res://keyboard_sounds/keyboard3.wav"))
	keyboard_sounds.append(load("res://keyboard_sounds/keyboard4.wav"))
	keyboard_sounds.append(load("res://keyboard_sounds/keyboard5.wav"))

func press():
	var random_sound = keyboard_sounds[randi() % keyboard_sounds.size()]
	
	stream = random_sound
	
	play()

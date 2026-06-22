extends Node3D

var spinning = false

var current_speed = 0.0
var deceleration = 2.5

func _ready():
	randomize()

func _process(delta):
	if spinning:
		rotate_y(current_speed * delta)

		current_speed -= deceleration * delta

		if current_speed <= 0:
			current_speed = 0
			spinning = false
			print("Wheel stopped!")

func spin():
	if spinning:
		return

	spinning = true
	current_speed = randf_range(15.0, 25.0)

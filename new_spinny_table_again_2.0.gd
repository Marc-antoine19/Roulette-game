extends Node3D
@onready var wheel_visual = $Sphere
@onready var wheel_collision = $StaticBody3D3
var spinning = false

var current_speed = 0.0
var deceleration = 2.5
@onready var ball_scene = preload("res://Ball.tscn")

func _ready():
	randomize()

func _process(delta):
	if spinning:
		wheel_visual.rotate_y(current_speed * delta)
		wheel_collision.rotate_y(current_speed * delta)

		current_speed -= deceleration * delta

		if current_speed <= 0:
			current_speed = 0
			spinning = false
			print("Wheel stopped!")

			var betting_table = get_node("/root/Main/BettingTable")
			betting_table.clear_bets()

			var game = get_node("/root/Main/GameManager")
			game.current_bets.clear()

func spin():
	if spinning:
		return

	spinning = true
	current_speed = randf_range(1.0, 1.0)
	print(wheel_collision.rotation)
	print("WHEEL:", wheel_visual.global_position)
	spawn_ball()
	
func spawn_ball():
	var ball = ball_scene.instantiate()

	get_tree().current_scene.add_child(ball)

	var spawn_pos = wheel_collision.global_position + Vector3(4, 2, 0)
	ball.global_position = spawn_pos

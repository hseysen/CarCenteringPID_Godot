extends Node


@export var Player: CharacterBody2D
@export var setpoint: float                    # 360
@export_category("PID Settings")
@export var P: float                           # 1
@export var I: float                           # 0.012
@export var D: float                           # 0.19
@export var divider: float                     # 1000


var integral = 0.0
var previous_error = 0.0


func _process(delta):
	Input.action_press("accelerate")
	
	var error = setpoint - Player.position.y
	integral += error * delta
	var derivative = (error - previous_error) / delta
	var control_action = (P * error + I * integral + D * derivative) / divider
	previous_error = error

	print(Player.position.y)
	print(error)
	print(control_action)
	print("___")
	Player.steer_angle = control_action


func _on_disturbance_button_pressed():
	Player.position.y = randi_range(-550, 550)

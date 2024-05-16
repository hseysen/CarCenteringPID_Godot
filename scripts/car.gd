extends CharacterBody2D


var wheel_base = 80  # Distance from front to rear wheel
var engine_power = 800  # Forward acceleration force.
var friction = -0.9
var drag = -0.0015
var braking = -450
var max_speed_reverse = 250
var steer_angle = 0
var acceleration
var turn = 0


func _ready():
	velocity = Vector2.ZERO


func _physics_process(delta):
	acceleration = Vector2(800, 0)
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = new_heading * velocity.length()
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()


func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force


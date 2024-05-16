extends Node2D


@export var Player: CharacterBody2D


func _process(delta):
	if Player.position.x > position.x + 1538:
		position.x += 1538 * 2



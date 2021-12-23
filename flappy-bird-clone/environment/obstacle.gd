extends Node2D

signal handle_obstacle

onready var handle_obstacle = $handle_obstacle

const SPEED = 220
const WALL_DISAPPEAR_POS_X = 50


func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -WALL_DISAPPEAR_POS_X:
		# only for test
		#global_position.x = 500
		queue_free()


func _on_wall_body_entered(body):
	if body is Player:
		# handle a case when the player hits the wall
		body.hit_obstacle()


func _on_score_area_body_exited(body):
	if body is Player:
		handle_obstacle.play()
		emit_signal("handle_obstacle")

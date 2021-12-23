extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $obstacle_spawner
onready var ground = $ground

var score = 0 setget set_score


func _ready():
	obstacle_spawner.connect("obstacle_created", self, "on_obstacle_created")


func start_new_game():
	self.score = 0
	obstacle_spawner.start()


func set_player_score():
	self.score += 1


func set_score(new_score):
	score = new_score
	hud.update_score(new_score)


func on_obstacle_created(obs):
	obs.connect("handle_obstacle", self, "set_player_score")


func _on_death_zone_body_entered(body):
	if body is Player:
		body.hit_obstacle()


func _on_player_hit_obstacle():
	game_over()


func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)


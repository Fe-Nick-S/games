extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $obstacle_spawner

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

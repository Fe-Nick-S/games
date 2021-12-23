extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $obstacle_spawner
onready var ground = $ground
onready var menu_layout = $menu

const SCORE_RESILT_DUMP = "user://savedata.save"

var score = 0 setget set_score
var best_score = 0

func _ready():
	obstacle_spawner.connect("obstacle_created", self, "on_obstacle_created")
	load_score_result()


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

	# update score
	if score > best_score:
		best_score = score
		save_score_result()

	menu_layout.init_game_over_menu(score, best_score)


func _on_menu_start_game():
	start_new_game()


func save_score_result():
	var score_file = File.new()
	score_file.open(SCORE_RESILT_DUMP, File.WRITE)
	score_file.store_var(best_score)
	score_file.close()


func load_score_result():
	var score_file = File.new()
	if score_file.file_exists(SCORE_RESILT_DUMP):
		score_file.open(SCORE_RESILT_DUMP, File.READ)
		best_score = score_file.get_var()
		score_file.close()

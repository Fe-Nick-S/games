extends CanvasLayer


signal start_game


onready var start_message = $start_game_ctrl/start_message
onready var tween = $tween
onready var score_label = $game_over_ctrl/VBoxContainer/score_label
onready var best_score_label = $game_over_ctrl/VBoxContainer/best_score_label
onready var game_over_menu = $game_over_ctrl


var is_game_started = false


func _input(event):
	if event.is_action_pressed("flap") && !is_game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		is_game_started = true


func init_game_over_menu(score, best_score):
	score_label.text = "SCORE: " + str(score)
	best_score_label.text = "BEST: " + str(best_score)
	game_over_menu.visible = true
	

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

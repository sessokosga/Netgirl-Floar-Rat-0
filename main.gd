extends Node

var timeline 
var dialogue

func _ready() -> void:
	show_menu()
	timeline  = Dialogic.preload_timeline("res://dialogues/dialogue.dtl")	
	show_menu()

func show_menu() -> void:
	$Background.show()
	$CreditsUI.hide()
	$HomeUI.show()

func show_credits()->void:
	$HomeUI.hide()
	$Background.show()
	$CreditsUI.show()
	
func _on_home_ui_credits() -> void:
	show_credits()

func _on_home_ui_quit() -> void:
	get_tree().quit()

func start_game()-> void:
	$CreditsUI.hide()
	$HomeUI.hide()
	$Background.hide()
	dialogue = Dialogic.start(timeline)
	Dialogic.connect("timeline_ended",show_credits)
	Dialogic.connect("signal_event",handle_dialogue_signal)
	
func _on_home_ui_start() -> void:
	start_game()

func handle_dialogue_signal(event_name:String) -> void:
	match(event_name):
		"show_victim_logo":
			$Victim.show()
		"hide_victim_logo":
			$Victim.hide()
		"start_maze":
			show_maze()
			Dialogic.paused = true
			

func show_maze() -> void:
	$Maze.show()
	$Background.hide()
	$HomeUI.hide()
	$CreditsUI.hide()

func hide_maze() -> void:
	Dialogic.paused = false
	$Maze.hide()
	
func _on_hack_button_pressed() -> void:
	print("Hackk")
	$HackButton.hide()
	show_maze()

func _on_maze_maze_result(success) -> void:
	hide_maze()
	if success : 
		Dialogic.VAR.won = "true"
	else:
		Dialogic.VAR.failed = "true"

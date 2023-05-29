extends Node

var timeline 
var dialogue

func _ready() -> void:
	show_menu()
	timeline  = Dialogic.preload_timeline("res://dialogues/dialogue.dtl")
#	Dialogic.connect("timeline_ended",show_credits)	
	start_game()

func show_menu() -> void:
	$CreditsUI.hide()
	$HomeUI.show()

func show_credits()->void:
	$HomeUI.hide()
	
	$CreditsUI.show()
	
func _on_home_ui_credits() -> void:
	show_credits()

func _on_home_ui_quit() -> void:
	get_tree().quit()

func start_game()-> void:
	$CreditsUI.hide()
	$HomeUI.hide()
	dialogue = Dialogic.start(timeline)
	Dialogic.connect("signal_event",handle_dialogue_signal)
	
func _on_home_ui_start() -> void:
	start_game()

func handle_dialogue_signal(event_name:String) -> void:
	match(event_name):
		"show_victim_logo":
			$Victim.show()
		"show_victim_logo":
			$Victim.hide()

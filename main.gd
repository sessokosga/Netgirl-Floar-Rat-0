extends Node

var timeline 
var dialogue

func _ready() -> void:
	show_menu()
	timeline  = Dialogic.preload_timeline("res://dialogues/dialogue.dtl")
	start_game()

func show_menu() -> void:
	$CreditsUI.hide()
	$HomeUI.show()

func _on_home_ui_credits() -> void:
	$HomeUI.hide()
	$CreditsUI.show()

func _on_home_ui_quit() -> void:
	get_tree().quit()

func start_game()-> void:
	$CreditsUI.hide()
	$HomeUI.hide()
	dialogue = Dialogic.start(timeline)

func _on_home_ui_start() -> void:
	start_game()

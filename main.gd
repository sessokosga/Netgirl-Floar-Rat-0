extends Node

func _ready() -> void:
	show_menu()
	
func show_menu() -> void:
	$CreditsUI.hide()
	$HomeUI.show()

func _on_home_ui_credits() -> void:
	$HomeUI.hide()
	$CreditsUI.show()


func _on_home_ui_quit() -> void:
	get_tree().quit()


func _on_home_ui_start() -> void:
	pass # Replace with function body.

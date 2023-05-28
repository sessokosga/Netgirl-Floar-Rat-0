extends Node

func _ready() -> void:
	show_menu()
	
func show_menu() -> void:
	$HomeUI.show()

func _on_home_ui_credits() -> void:
	pass # Replace with function body.


func _on_home_ui_quit() -> void:
	get_tree().quit()


func _on_home_ui_start() -> void:
	pass # Replace with function body.

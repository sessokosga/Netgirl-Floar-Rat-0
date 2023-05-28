extends CanvasLayer
signal start()
signal credits()
signal quit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	start.emit()


func _on_credits_pressed() -> void:
	credits.emit()


func _on_quit_pressed() -> void:
	quit.emit()

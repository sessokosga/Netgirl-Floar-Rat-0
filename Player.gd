extends Area2D
var velocity : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2.ZERO
@export var speed = 200
var old_position : Vector2

signal player_end(success:bool)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("move_right"):
		position += Vector2.RIGHT * delta * speed
		old_position = position + Vector2.LEFT * delta * speed*2
	elif Input.is_action_pressed("move_left"):
		position += Vector2.LEFT * delta * speed
		if has_overlapping_bodies():
			position += Vector2.RIGHT * delta * speed*2
	elif Input.is_action_pressed("move_down"):
		position += Vector2.DOWN * delta * speed
		if has_overlapping_bodies():
			position += Vector2.UP * delta * speed*2
	elif Input.is_action_pressed("move_up"):
		position += Vector2.UP * delta * speed
		if has_overlapping_bodies():
			position += Vector2.DOWN * delta * speed*2
	
	if has_overlapping_bodies():
		position = old_position
		player_end.emit(false)
	
	
	
	
	


func _on_body_entered(body: Node2D) -> void:
	pass

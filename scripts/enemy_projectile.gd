extends Area2D

var speed = 400
var direction : Vector2
var player
func set_direction(target):
	direction = position.direction_to(target)
	pass
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _physics_process(delta: float):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		player = body
		body.change_health(-15)
		queue_free()
	
	pass

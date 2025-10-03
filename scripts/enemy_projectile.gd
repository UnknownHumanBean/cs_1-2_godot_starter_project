extends Area2D

var speed = 300
var direction : Vector2

func set_direction(target):
	direction = position.direction_to(target)
	pass
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _physics_process(delta: float):
	position += direction * speed * delta
func _on_body_entered(_body):
	
	
	pass

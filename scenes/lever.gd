extends Area2D

var on = false
var player
var in_range = false
@onready var _animation_lever: AnimatedSprite2D = $AnimatedSprite2D

func on_body_entered(body):
	if body == player:
		in_range = true
		
func _process(_float) -> void:
	if in_range == true and Input.is_action_just_pressed("ui_select"):
		on = true
	
	if on == true:
		update_animation()
		
func update_animation():
	_animation_lever.play("res://sprites/items/ALever.png")

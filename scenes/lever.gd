extends Area2D

var on = false
var player
var in_range = false
var number_on = 0
@onready var _animation_lever: AnimatedSprite2D = $AnimatedSprite2D

func on_body_entered(body):
	if body == "Player":
		in_range = true
		
func _process(_float) -> void:
	if in_range == true and Input.is_action_just_pressed("ui_select"):
		number_on += 1
		on = true
	
	if on == true:
		update_animation()
		
	#if number_on == 3:
		#Do something
		
func update_animation():
	_animation_lever.play("res://sprites/items/ALever.png")
	

extends CharacterBody2D


var in_range = false
var chasing = false
var attacking = false
@onready var player = %Player
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

var xSpeed = 200
var ySpeed = 200
var xDirection
var yDirection
var speed_mult = 1

func _ready() -> void:
	pass

@warning_ignore("unused_parameter")
func _on_in_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _on_in_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _on_attacking_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		attacking = true
		in_range = false
	pass # Replace with function body.
	
@warning_ignore("unused_parameter")
func _on_attacking_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		attacking = false
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _on_chasing_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#set_direction(player.position)
		chasing = true
	pass # Replace with function body.

@warning_ignore("unused_parameter")
func _on_chasing_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chasing = false
	pass # Replace with function body.
	
#@warning_ignore("unused_parameter")
#func _physics_process(delta: float) -> void:
	#velocity.x = xDirection * xSpeed * speed_mult
	#velocity.y = yDirection * ySpeed * speed_mult
	
	update_animation()
	move_and_slide()
	
func update_animation():
	if in_range:
		print("In Range!")
		#if (Some code I dont know how to do, that is supposed to make the turrets fire at me.)
	pass
	
#@warning_ignore("unused_parameter", "shadowed_variable")
#func set_direction(player: position):
	#pass
	
func shoot():
	
	var projectile_clone = projectile_original.instantiate()

	projectile_clone.global_position = position

	projectile_clone.set_direction(player.position)

	get_tree().get_root().add_child(projectile_clone)

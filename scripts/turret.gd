extends CharacterBody2D

var projectile_original = preload("res://scenes/enemy_projectile.tscn")
var speed = 300
var start_time = 2
var timer = start_time
var in_range = false
var player

func _process(delta):
	if in_range:
		timer -= delta
	if timer < 0:
		shoot(player)
		timer = start_time

func _ready():
	
	pass
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
	 # Replace with function body.
# TODO: Create a new projectile instance
		var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
		projectile_clone.global_position = position
	
	# TODO: Set projectile direction using facing variable
		projectile_clone.set_direction(body.position)
	# TODO: Add projectile to the game world
		get_tree().get_root().add_child(projectile_clone)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.

func shoot(target):
	if target.name == "Player":
		
		var projectile_clone = projectile_original.instantiate()
	
		projectile_clone.global_position = position
	
		projectile_clone.set_direction(target.position)
	
		get_tree().get_root().add_child(projectile_clone)
	

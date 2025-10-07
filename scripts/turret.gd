extends CharacterBody2D

var projectile_original = preload("res://scenes/enemy_projectile.tscn")
var speed = 300
var start_time = 1.5
var timer = start_time
var in_range = false
var player
var health
var maxHealth = 100

func _process(delta):
	if in_range:
		timer -= delta
		if timer < 0:
			shoot()
			timer = start_time

func _ready():
	health = maxHealth
	pass
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = false
	pass # Replace with function body.

func shoot():
	
	var projectile_clone = projectile_original.instantiate()

	projectile_clone.global_position = position

	projectile_clone.set_direction(player.position)

	get_tree().get_root().add_child(projectile_clone)
	
func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Enemy Health: ", health)
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()
	print("Enemy Health: ", health)

func die():
	print("Enemy defeated!")
	queue_free()

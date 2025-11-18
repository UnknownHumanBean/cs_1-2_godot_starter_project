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
var ranged_atk_timer = 1.2
var melee_atk_timer = 1
var rangedatk = 0
var meleeatk = 0
var melee = false
var melee_atk_duration = 1
var animation = true
var start_time = 1.5
var timer = start_time
var health
var maxHealth = 100
var body
var facing

func _ready() -> void:
	body = player
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func _on_in_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = true
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func _on_in_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = false
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func _on_attacking_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		attacking = true
		in_range = false
	pass
	
@warning_ignore("unused_parameter", "shadowed_variable")
func _on_attacking_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		attacking = false
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func _on_chasing_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#set_direction(player.position)
		chasing = true
	pass

@warning_ignore("unused_parameter", "shadowed_variable")
func _on_chasing_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chasing = false
	pass 
	update_animation()
	move_and_slide()
	
func update_animation():
	if in_range:
		print("In Range!")
	
func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)

func _on_body_entered(_player):
	if body.name == "Player":
		player = body
		body.change_health(-1)
		
	if abs(position.x - player.position.x) > abs(position.y - player.position.y):
		if position.x > player.position.y:
			facing = "right"
		else: 
			facing = "left"
		if position.y > player.position.y:
			facing = "down"
		else:
			facing = "up"
func _process(delta):
	if in_range:
		timer -= delta
		if timer < 0:
			shoot()
			timer = start_time
	if chasing == true:
		global_position = position
		#%Player.set_direction(player.position)
	#if in_range == true:
		#animation.fliph = true
	#elif in_range == false:
		#animation.fliph = false
	if attacking:
		if meleeatk < 0:
			melee = true
			meleeatk = melee_atk_timer
			if body.name == "Player":
				player = body
				body.change_health(-5)
			print ("Attacked")
		elif meleeatk >0:
			melee = false
			meleeatk -= delta
func _physics_process(_delta: float) -> void:
	velocity.x = xSpeed
	velocity.y = ySpeed
	if chasing == true:
		global_position = position
		%Player.set_direction(player.position)
		if in_range == true:
			animation.fliph = true
		elif in_range == false:
			animation.fliph = false
	
func set_direction(_new_direction: Vector2):
	if chasing == true:
		global_position = position
		%Player.set_direction(player.position)

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
		#if (Something):
			#the turret fires at me.
	pass
	
#@warning_ignore("unused_parameter", "shadowed_variable")
#func set_direction(player: position):
	#pass
	
func shoot():
	
	var projectile_clone = projectile_original.instantiate()

	projectile_clone.global_position = position

	projectile_clone.set_direction(player.position)

	get_tree().get_root().add_child(projectile_clone)
	
	
#func _process(_float) -> void:
	#if in_range == true:
		#animation.fliph = true
	#elif in_range == false:
		#animation.fliph = false

func process(delta):
	if attacking:
		if meleeatk <= 0:
			melee = true
			meleeatk = melee_atk_timer
			print("Attacked")
			#play animation
		elif meleeatk >= 0.001:
			meleeatk -= delta
	melee_atk_duration -= delta
	if melee_atk_duration <= 0:
		melee = false
		
	if abs(position.x - player.position_x) > abs(position.y - player.position_y):
		if position.x > position.player_y:
			facing = "right"

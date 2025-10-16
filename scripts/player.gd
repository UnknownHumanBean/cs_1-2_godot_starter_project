extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
var is_atking = false
var atk_timer = 0.6
@export var offset : Vector2 = Vector2(0, -25)
@onready var melee_box : CollisionShape2D = $Area2D/CollisionShape2D2
var in_range = false
var maxHealth = 100
var health = maxHealth
var atk_cooldown = 0.6
var _body
var mana_gain_amount = 1
var mana_amount = 0
var max_mana = 100
var max_energy = 100
var energy_gain = 1
var energy_amount = 0
var mana_tax = 1
var speed_mult = 1
var regeneration = 5
var nat_regeneration = .01
var saturation = 0
var max_saturation = 100
var sat_use_speed = 1
var nat_regen_speed = 1

func _ready() -> void:
	energy_amount = max_energy
	saturation = max_saturation
	pass

func _physics_process(_delta):
	xDirection = Input.get_axis("ui_left", "ui_right")
	yDirection = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = xDirection * xSpeed * speed_mult
	velocity.y = yDirection * ySpeed * speed_mult
	
	if xDirection > 0:
		facing = "right"
		melee_box.position = Vector2 (25,-20)
	elif xDirection < 0:
		facing = "left"
		melee_box.position = Vector2 (-25,-20)
	elif yDirection < 0:
		facing = "up"
		melee_box.position = Vector2 (0,-50)
	elif yDirection > 0:
		facing = "down"
		melee_box.position = Vector2 (0,17)
	
	if Input.is_action_just_pressed("ui_select"):
		if mana_amount >= 10 * mana_tax:
			shoot()
			mana_amount -= 10 * mana_tax
			print ("Mana " + str(mana_amount))
			
		elif mana_amount <= 10 * mana_tax:
			mana_amount += 0 + mana_gain_amount
			print ("Mana " + str(mana_amount))
	# call the animation function
	update_animation()
	
	
	# This is a special Godot function that makes the movement happen
	move_and_slide()

	if Input.is_action_just_pressed("ui_text_delete"):
		is_atking = true
		atk_timer = atk_cooldown
		attack(_body)
		
	if is_atking:
		atk_timer -= _delta
		if atk_timer < 0:
			is_atking = false
			atk_timer = 0.6
		
# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	# TODO: Set the animation based on the facing direction
	if velocity.is_zero_approx():
		_animation_player.play("idle_" + facing)
	# This combines "idle_" with whatever direction we're facing
		pass
	elif !velocity.is_zero_approx():
		#walking animation here
		_animation_player.play("walk_" + facing)
		
	if is_atking:
		_animation_player.play("attack_"+ facing)
		
		
		pass
		
	


# TODO: Create health change function for interactions
func change_health(_amount:int):
		health += _amount
		mana_tax *= 1.1
		if health <= 0:
			die()
		if health > maxHealth:
			health = maxHealth
		

func change_coins(_amount:int):
	coins += _amount
	print("you have " +str(coins) +" coins")
	health = health + regeneration
	
	
	if coins >= 3:
		coins -= 3
		speed_mult *= 1.1
		mana_gain_amount *= 2
		energy_gain *= 2
		saturation = saturation + 10
		sat_use_speed = sat_use_speed * 2
		nat_regen_speed = nat_regen_speed * 2
		
func die(): 
	queue_free()
	
# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position + offset
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(facing)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)

	pass
		
func on_body_entered(body):
	if body.is_in_group("enemies"): 
		var _in_range = true
		
func attack(body):
	if in_range == true and body.is_in_group("enemies"):
		print ("hit")
		
func _process(_delta: float) -> void:
	if saturation >= 1 and health < 100:
		saturation -= .01 * sat_use_speed
		health = health + (nat_regeneration * nat_regen_speed)
		
	if health >= maxHealth:
		health = maxHealth
		
	if saturation >= max_saturation:
		saturation = max_saturation

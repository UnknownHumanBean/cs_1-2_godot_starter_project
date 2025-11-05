extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")
@onready var melee_area: Area2D = $MeleeArea

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
var is_atking = false
var atk_timer = 0.0
@export var offset : Vector2 = Vector2(0, -25)
@onready var melee_box : CollisionShape2D = $Area2D/CollisionShape2D2
var in_range = false
var maxHealth = 100
var health = maxHealth
var atk_cooldown = 0.6
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
var exhaustion = 1
var moving = false
var rng := RandomNumberGenerator.new()
var n = rng.randi_range(1, 10)
var f = rng.randf()
var f2 = rng.randf_range(2.5, 7.0)
var attack_damage = 25
var attack_hit_done = false
var body
var spell_ID = 0
var sprint = 100
var sprinting = false

func _ready() -> void:
	energy_amount = max_energy
	saturation = max_saturation
	rng.randomize()
	#melee_area.monitoring = true
	#melee_area.set_deferred("monitorable", true)
	pass

func _physics_process(_delta):
	xDirection = Input.get_axis("Key_A", "Key_D")
	yDirection = Input.get_axis("Key_W", "Key_S")

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
	
	if Input.is_action_just_pressed("Key_F"):
		if spell_ID == 0:
			if mana_amount >= 10 * mana_tax:
				shoot()
				mana_amount -= 10 * mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 1:
			if mana_amount >= 25 * mana_tax:
				shoot_2()
				mana_amount -= 25 *mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 10:
			if mana_amount >= 15 * mana_tax:
				speed_mult *= 1.05
				mana_amount -= 15 * mana_tax
				mana_tax += 0.25
				print ("Mana " + str(mana_amount))
		if spell_ID == 9:
			if mana_amount >= 5 * mana_tax:
				mana_gain_amount *= 1.03
				mana_amount -= 5 * mana_tax
				mana_tax += 0.1
				print ("Mana " + str(mana_amount))
		if spell_ID == 2:
			if mana_amount >= 7 * mana_tax:
				mana_amount -= 7 * mana_tax
				max_energy += 10
				max_mana += 10
				print ("Mana " + str(mana_amount))
		if spell_ID == 3:
			if mana_amount >= 0 * mana_tax:
				mana_amount -= 0 * mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 4:
			if mana_amount >= 0 * mana_tax:
				mana_amount -= 0 * mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 5:
			if mana_amount >= 50 * mana_tax:
				mana_amount -= 50 * mana_tax
				maxHealth *= mana_amount/mana_tax
				health = maxHealth
				
				print ("Mana " + str(mana_amount))
		if spell_ID == 6:
			if mana_amount >= 0 * mana_tax:
				mana_amount -= 0 * mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 7:
			if mana_amount >= 0 * mana_tax:
				mana_amount -= 0 * mana_tax
				print ("Mana " + str(mana_amount))
		if spell_ID == 8:
			if mana_amount >= 100:
				mana_amount -= 100
				mana_tax -= speed_mult/saturation
				print ("Mana " + str(mana_amount))

	if Input.is_action_just_pressed("ui_select"):
			mana_amount += mana_gain_amount
			print ("Mana " + str(mana_amount))
	
	update_animation()
	move_and_slide()

	if Input.is_action_just_pressed("Key_X"):
		start_attack()
		
	if is_atking:
		atk_timer -= _delta
		if atk_timer <= 0:
			is_atking = false
			attack_hit_done = false
			
		update_animation()
		move_and_slide()
		
	if Input.is_action_just_pressed("Key_C"):
		if spell_ID < 10:
			spell_ID += 1
			print("Spell " +str(spell_ID) +" Equiped")
		elif spell_ID >= 10:
			spell_ID = 0
			print("Spell " +str(spell_ID) +" Equiped")


func change_coins(_amount:int):
	coins += _amount
	#temporary:
	print("you have " +str(coins) +" coins")
	health = health + regeneration
	
func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position + offset
	projectile_clone.set_direction(facing)
	get_tree().get_root().add_child(projectile_clone)

	pass
	
func shoot_2():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position + offset
	projectile_clone.set_direction(facing)
	get_tree().get_root().add_child(projectile_clone)
		
@warning_ignore("shadowed_variable")
func on_body_entered(body):
	if body.is_in_group("enemies"): 
		var _in_range = true
		
func start_attack() -> void:
	# Start an attack, run the hit once immediately
	is_atking = true
	atk_timer = atk_cooldown
	if not attack_hit_done:
		do_melee_attack()
		attack_hit_done = true
		
func do_melee_attack() -> void:
	#var bodies = melee_area.get_overlapping_bodies()
	#for body in bodies:
		if body and body.is_in_group("enemies"):
			if body.has_method("take_damage"):
				body.take_damage(attack_damage)
			elif body.has_method("change_health"):
				body.change_health(attack_damage)
				
func update_animation():
	if velocity.length() < 1:
		_animation_player.play("idle_" + facing)
	else:
		_animation_player.play("walk_" + facing)
		
func change_health(_amount:int) -> void:
	health += _amount
	if health < 1:
		die()
	if health > maxHealth:
		health = maxHealth
	print("Health: ", health)
	
func die() -> void:
	print("WASTED!")
	queue_free()
		
func _process(_delta: float) -> void:
	if saturation >= 1 and health < 100:
		saturation -= .01 * sat_use_speed
		health = health + (nat_regeneration * nat_regen_speed)
		
	if health >= maxHealth:
		health = maxHealth
		
	if saturation >= max_saturation:
		saturation = max_saturation
		
	if mana_amount >= max_mana:
		mana_amount = max_energy
		print ("Mana " + str(mana_amount))
		
	if energy_amount >= max_energy:
		energy_amount = max_energy
		
	
		
	if Input.get_axis("Key_A", "Key_D") and energy_amount >= 1:
		sprint = 100
		energy_amount -= 0.25 * exhaustion
		sprinting = true
	elif Input.get_axis("Key_A", "Key_D") and energy_amount <= 1:
		sprint = 0
		sprinting = false
		
	if Input.get_axis("Key_W", "Key_S") and energy_amount >= 1:
		sprint = 100
		energy_amount -= 0.25 * exhaustion
		sprinting = true
	elif Input.get_axis("Key_W", "Key_S") and energy_amount <= 1:
		sprint = 0
		sprinting = false
		
	if sprinting == false:
		@warning_ignore("integer_division")
		energy_amount += energy_gain / exhaustion

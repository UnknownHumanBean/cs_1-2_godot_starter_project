extends Area2D

# TODO: Add speed variable for how fast projectile moves
# var speed = ?
var Speed = 500
var direction : Vector2
var facing = 0

# TODO: Add direction variable to store which way to move
# var direction = Vector2.ZERO

func _physics_process(_delta):
	# TODO: Calculate movement using direction and speed
	# Similar to player movement: velocity = direction * speed
	position += direction * Speed * _delta
	
	# TODO: Apply the movement
	# Use: move_and_slide()
	
	
	# TODO: Print movement for debugging
	# print("Projectile moving: ", velocity)
	
	pass

# TODO: Create function to set projectile direction
func set_direction(_facing :String):
	# TODO: Convert facing string to Vector2 direction
	# Use if statements: "up" -> Vector2.UP, "down" -> Vector2.DOWN, etc.
	# Set direction = the Vector2 result
	if _facing == "up":
		direction = Vector2(0,-1)
	# TODO: Print the direction for debugging
	# print("Projectile direction set to: ", direction)
	if _facing == "down":
		direction = Vector2(0,1)
		
	if _facing == "right":
		direction = Vector2(1,0)
		
	if _facing =="left":
		direction = Vector2(-1,0)
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	# TODO: Remove projectile when it goes off screen
	# Use: queue_free()
	
	# TODO: Print when projectile is removed
	# print("Projectile removed - went off screen")
	
	pass

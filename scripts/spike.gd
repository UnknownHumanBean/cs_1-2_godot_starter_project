extends Area2D

func _on_body_entered(body):
	if body.name == "player":
		body.change_health(-10)
		print ("OOF")
	# TODO: Check if the object that touched the spike is the player
	# Use an if statement to check: if body.name == "Player":
	
	
	# TODO: Make the player take damage
	# Call the player's health change function: body.change_health(-10)
	
	
	# TODO: Print a message about the spike hit
	# Something like: print("Player hit spikes!")

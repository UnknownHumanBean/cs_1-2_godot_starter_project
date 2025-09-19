extends Node


func _on_body_entered(body):
	if body.name == "player":
		body.change_coins(1)
		queue_free()
	# TODO: Check if the object that touched the coin is the player
	
	
	
	
	# TODO: Print a message when the coin is collected
	
	
	# TODO: Remove the coin from the game
	
	

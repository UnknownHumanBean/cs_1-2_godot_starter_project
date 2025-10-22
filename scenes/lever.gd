extends Area2D

@export var lever_name: String = "lever_1"
var in_range: bool = false
var is_on: bool = false

signal toggled(name, state)

func _ready() -> void:
	add_to_group("levers")
	# ensure monitoring is on so Area2D signals work
	monitoring = true

func _on_Lever_body_entered(body: Node) -> void:
	# detect player; you can also check is_in_group("players") if you add the player to that group
	if body.name == "Player" or body.is_in_group("player"):
		in_range = true

func _on_Lever_body_exited(body: Node) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		in_range = false

func _process(_delta: float) -> void:
	# Press E / "attack" while in range to toggle
	if in_range and Input.is_action_just_pressed("attack"):
		toggle()

func toggle() -> void:
	is_on = not is_on
	if has_node("AnimatedSprite2D"):
		if has_node("AnimatedSprite2D"):
		# play the "on" or "off" animation (Godot 4 ternary style)
			$AnimatedSprite2D.play("on" if is_on else "off")
	elif has_node("Sprite"):
		# assume Sprite2D with two frames: 0 = off, 1 = on
		if $Sprite is Sprite2D and $Sprite.frames:
			$Sprite.frame = 1 if is_on else 0

	emit_signal("toggled", lever_name, is_on)

	# If you have a global GameManager autoload, call a handler if it exists
	if Engine.has_singleton("GameManager"):
		# In Godot autoloads are available as global variables named by the autoload key.
		# Try calling GameManager.on_lever_toggled if it exists.
		if GameManager and GameManager.has_method("on_lever_toggled"):
			GameManager.on_lever_toggled(lever_name, is_on)
			

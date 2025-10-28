extends Area2D

@export var lever_name: String = "lever_1"
var in_range: bool = false
var is_on: bool = false

signal toggled(name, state)

func _ready() -> void:
	add_to_group("levers")
	# ensure monitoring is on so Area2D signals work
	#monitoring = true

func _on_Lever_body_entered(body: Node) -> void:
	
	if body.name == "Player" or body.is_in_group("player"):
		in_range = true

func _on_Lever_body_exited(body: Node) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		in_range = false

func _process(_delta: float) -> void:
	if in_range and Input.is_action_just_pressed("Key_Z"):
		toggle()

func toggle() -> void:
	is_on = not is_on
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("on" if is_on else "off")

	emit_signal("toggled", lever_name, is_on)

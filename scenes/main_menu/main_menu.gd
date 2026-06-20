extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Apenas garante que o mouse estara visivel no meu
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Ao pressionar o botao, mata essa cena do menu e vai para a cena do terminal.
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/terminal/terminal.tscn")

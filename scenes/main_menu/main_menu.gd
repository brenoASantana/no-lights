extends Control

var soundtrack = preload("res://assets/audio/Library Studies - Pentagram Home Video/Flexi Disc.ogg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Manda o Autoload tocar. Se já estiver tocando, ele inteligentemente ignora.
	AudioGlobal.play_music(soundtrack)

	# Apenas garante que o mouse estara visivel no meu
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Ao pressionar o botao, mata essa cena do menu e vai para a cena do terminal.
func _on_button_pressed() -> void:
	# 1. Sequestra e oculta o mouse instantaneamente!
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	get_tree().change_scene_to_file("res://scenes/terminal/terminal.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits/credits.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options/options.tscn")


func _on_exit_button_pressed() -> void:
	#TODO: Inserir função de save antes de sair
	get_tree().quit()

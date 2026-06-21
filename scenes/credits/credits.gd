extends Control

# Expor a variável permite que você ajuste a velocidade direto no Inspetor da Godot, sem abrir o código
@export var roll_speed: float = 60.0

@onready var credits_container = $VBoxContainer

var soundtrack = preload("res://assets/audio/Library Studies - Pentagram Home Video/The Closed Gate.ogg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioGlobal.stop_music()
	AudioGlobal.play_music(soundtrack)
	# SETUP INICIAL:
	# Pega a altura total da janela do jogo e empurra o container para essa exata coordenada.
	# Isso faz o texto nascer exatamente um pixel abaixo da borda inferior da tela.
	credits_container.position.y = get_viewport_rect().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Permite pular os créditos apertando ESC (ou a tecla mapeada em "ui_cancel")
	if Input.is_action_just_pressed("ui_cancel"):
		_end_credits()

	# MOVIMENTO CONTÍNUO:
	# Subtrair do eixo Y faz o nó subir.
	# Multiplicar pelo 'delta' é fundamental: garante que o texto suba na mesma velocidade
	# num monitor de 60Hz ou num de 144Hz.
	credits_container.position.y -= roll_speed * delta

	# CICLO DE VIDA (Garbage Collection Visual):
	# Como o jogo sabe que os créditos acabaram?
	# Quando a posição Y do container ficar mais negativa do que a sua própria altura.
	# Isso significa que a última letra da última linha cruzou a borda superior do monitor.
	if credits_container.position.y < -credits_container.size.y:
		_end_credits()


func _end_credits() -> void:
	# O encerramento natural após a leitura completa
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

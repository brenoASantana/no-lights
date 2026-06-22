extends Control

@onready var volume_slider = $VBoxContainer/VolumeSlider # Ajuste para o caminho do seu nó

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# SETUP INICIAL: 
	# Quando o jogador abre o menu, a barra precisa estar no lugar certo.
	# Nós pegamos o DB atual do servidor, convertemos para Linear (0.0 a 1.0) e aplicamos na barra.
	var master_bus_index = AudioServer.get_bus_index("Master")
	var actual_db_volume = AudioServer.get_bus_volume_db(master_bus_index)
	
	volume_slider.value = db_to_linear(actual_db_volume)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_volume_slider_value_changed(value: float) -> void:
	# AÇÃO REATIVA:
	# O jogador arrastou a barra. Pegamos o valor Linear (0.0 a 1.0),
	# convertemos matematicamente para Decibéis e mandamos pro servidor de áudio.
	var master_bus_index = AudioServer.get_bus_index("Master")
	var new_volume_db = linear_to_db(value)
	
	AudioServer.set_bus_volume_db(master_bus_index, new_volume_db)

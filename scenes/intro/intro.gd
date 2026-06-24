extends Control

# Controladores de Estado
var visible_prompt: bool = false
var tween_prompt: Tween

@onready var skip_label = $MarginContainer/SkipLabel

func _unhandled_input(event: InputEvent) -> void:
	# 1. Filtro de Ruído: Ignora movimentos de mouse ou quando a tecla é solta
	if event is InputEventMouseMotion or not event.is_pressed():
		return
		
	# 2. SEGUNDO CLIQUE (Confirmação): O prompt já está na tela?
	if visible_prompt:
		# Verifica se a tecla apertada foi especificamente o ESC (ui_cancel)
		if event.is_action_pressed("ui_cancel"):
			_skip_to_menu()
			return # Mata a execução aqui
			
	# 3. PRIMEIRO CLIQUE (Despertar): Se o prompt estava invisível, faz ele aparecer
	_show_soft_prompt()

func _show_soft_prompt() -> void:
	# Trava de segurança para não recriar o Tween se o jogador ficar metralhando o teclado
	if visible_prompt:
		# (Opcional) Aqui podemos resetar o tempo para o prompt demorar mais a sumir
		return
		
	visible_prompt = true
	
	if tween_prompt:
		tween_prompt.kill()
		
	tween_prompt = create_tween()
	# Faz o Fade In subindo a opacidade para 1.0 em meio segundo
	tween_prompt.tween_property(skip_label, "modulate:a", 1.0, 0.5)
	
	# Mantém o texto visível por 3 segundos
	tween_prompt.tween_interval(3.0)
	
	# Faz o Fade Out voltando para 0.0 opacidade
	tween_prompt.tween_property(skip_label, "modulate:a", 0.0, 0.5)
	
	# Quando o Fade Out terminar, desliga a flag de visibilidade
	tween_prompt.tween_callback(func(): visible_prompt = false)

func _skip_to_menu() -> void:
	# Garante a limpeza de memória matando o tween ativo antes de trocar de cena
	if tween_prompt:
		tween_prompt.kill()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_intro_cutscene_animation_finished(anim_name: StringName) -> void:
	_skip_to_menu()

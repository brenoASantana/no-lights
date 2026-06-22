extends RichTextLabel

var timer_per_letter: float = 0.03
var actual_tween: Tween
var soundtrack = preload("res://assets/audio/Library Studies - Pentagram Home Video/A Warning Before Reading.ogg")


func _ready() -> void:
	AudioGlobal.stop_music()
	AudioGlobal.play_music(soundtrack)

	var array_introducao = System.pages["prologo"]
	var texto_completo = "\n".join(array_introducao)

	_print_terminal(texto_completo + "\n\nDigite 'olhar quarto' para começar ou 'ajuda' para comandos.")
	$LineEdit.grab_focus()


func _print_terminal(new_phrase: String, final_event: Callable = Callable()) -> void:
	if actual_tween:
		actual_tween.kill()

	var initial_caracter = get_total_character_count()
	append_text(new_phrase)
	visible_characters = initial_caracter

	var final_caracters = get_total_character_count()
	var new_letters_quant = final_caracters - initial_caracter
	var calculated_time = float(new_letters_quant) * timer_per_letter

	# CORREÇÃO: Sem o "var", agora ele atualiza a variável global corretamente!
	actual_tween = create_tween()
	actual_tween.tween_property(self, "visible_characters", get_total_character_count(), calculated_time)

	if final_event.is_valid():
		actual_tween.tween_callback(final_event)


func _interpret_command(input: String) -> void:
	var words = input.split(" ")
	var verb = words[0]

	var object = ""
	if words.size() > 1:
		object = input.get_slice(" ", 1)

	match verb:
		"ajuda", "help":
			_print_terminal(System.pages["ajuda"])
		"olhar", "investigar":
			_process_action("olhar", object)
		"pegar", "coletar":
			_process_action("pegar", object)
		"ler":
			_process_action("ler", object)
		"usar", "utilizar":
			# O comando "usar" exige 3 palavras (ex: usar chave porta)
			if words.size() >= 3:
				var target = input.get_slice(" ", 2)
				_process_interation(object, target)
			else:
				_print_terminal("Como usar? Formato correto: usar [item] [alvo]. (Ex: usar chave porta)")
		_:
			_print_terminal("Comando inválido. Digite 'ajuda' para comandos suportados.")


func _process_action(verb: String, object: String) -> void:
	if object == "":
		_print_terminal("O que você quer " + verb + "? Especifique um objeto (Ex: " + verb + " janela)")
		return

	var room_data = System.pages["comodos"][System.current_room]

	# 1. Define em qual "gaveta" do JSON do quarto atual nós vamos procurar
	var category = ""
	match verb:
		"olhar", "investigar":
			category = "olhar"
		"pegar", "coletar":
			category = "itens"
		"ler":
			category = "documentos"

	# 2. Verifica se a gaveta existe e se o objeto que o jogador digitou está lá
	if room_data.has(category) and room_data[category].has(object):
		# Lógica exclusiva para o verbo "pegar"
		if category == "itens":
			if System.inventory.has(object):
				_print_terminal("Você já pegou esse item. Ele está no seu inventário.")
				return
			System.inventory.append(object)

		# Pega os dados do objeto (pode ser um texto simples ou um Dicionário com áudio)
		var item_data = room_data[category][object]

		if typeof(item_data) == TYPE_DICTIONARY:
			var text_to_print = item_data["texto"]

			if item_data.has("event_sound"):
				var audio_file = load("res://assets/audio/" + item_data["event_sound"] + ".ogg")
				_print_terminal(text_to_print, AudioGlobal.play_music.bind(audio_file))
			else:
				_print_terminal(text_to_print)

		elif typeof(item_data) == TYPE_STRING:
			_print_terminal(item_data)

			# Lógica de evento hardcoded na action (como perder sanidade ao olhar a janela)
			if verb == "olhar" and object == "janela":
				System.change_sanity(-10)
	else:
		_print_terminal("Você não pode " + verb + " isso agora.")


func _process_interation(inventory_item: String, scenario_target: String) -> void:
	var room_data = System.pages["comodos"][System.current_room]

	if room_data.has("interacoes") and room_data["interacoes"].has(scenario_target):
		var interaction_data = room_data["interacoes"][scenario_target]
		var required_item = interaction_data["requer"]

		if inventory_item == required_item and System.inventory.has(inventory_item):
			# SUCESSO
			if interaction_data.has("event_sound"):
				var audio_file = load("res://assets/audio/" + interaction_data["event_sound"] + ".ogg")
				_print_terminal(interaction_data["texto_sucesso"], AudioGlobal.play_music.bind(audio_file))
			else:
				_print_terminal(interaction_data["texto_sucesso"])

			# ==========================================
			# TODO: CÓDIGO DE TRANSIÇÃO DE CENA AQUI
			# ==========================================

		else:
			# FALHA
			_print_terminal(interaction_data["texto_falha"])
	else:
		_print_terminal("Não faz sentido usar isso aí.")


func _on_line_edit_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		$LineEdit.accept_event()
		var command_typed = $LineEdit.text
		$LineEdit.clear()
		var clean_awnser = command_typed.to_lower().strip_edges()
		if clean_awnser == "":
			return
		text = "> " + command_typed + "\n\n"
		_interpret_command(clean_awnser)

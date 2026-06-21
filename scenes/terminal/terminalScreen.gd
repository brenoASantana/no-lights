extends RichTextLabel

var timer_per_letter: float = 0.03
var actual_tween: Tween
var soundtrack = preload("res://assets/audio/Library Studies - Pentagram Home Video/A Warning Before Reading.ogg")

func _ready() -> void:
	# Manda o Autoload calar a boca, cortando o som do Menu
	AudioGlobal.stop_music()
	AudioGlobal.play_music(soundtrack)
	
	# 1. Puxa toda a introdução do JSON juntando as frases com quebra de linha
	var array_introducao = System.pages["introducao"]
	var texto_completo = "\n".join(array_introducao)
	
	# 2. Imprime a introdução e as instruções iniciais direto na tela
	_print_terminal(texto_completo + "\n\nDigite 'olhar quarto' para começar ou 'ajuda' para comandos.")
	
	# 3. Colocamos o foco automaticamente no campo de texto
	$LineEdit.grab_focus()

func _print_terminal(new_Phrase: String) -> void:
	# Trava de Segurança: Se o jogador digitar um comando antes do texto atual terminar,
	# nós "matamos" a animação antiga para a nova poder assumir a tela limpa.
	if actual_tween:
		actual_tween.kill()
	
	var initial_caracter = get_total_character_count()	
	append_text(new_Phrase)
	visible_characters = initial_caracter
	
	# 2. Verifica qual é o novo total de letras na tela
	var final_caracters = get_total_character_count()
	
	# 3. Descobre exatamente quantas letras NOVAS precisamos animar
	var new_letters_quant = final_caracters - initial_caracter
	
	# 4. A mágica matemática: Tempo Total = Quantidade de Letras * Velocidade de 1 Letra
	var calculated_time = float(new_letters_quant) * timer_per_letter
	
	# Cria o motor e aplica o tempo dinâmico
	var actual_tween = create_tween()
	actual_tween.tween_property(self, "visible_characters", get_total_character_count(), calculated_time)

func _interpret_command(input: String)-> void:
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
		_:
			_print_terminal("Comando inválido. Digite 'ajuda' para comandos suportados.")
			
func _process_action(verb: String, object: String) -> void:
	if object == "":
		_print_terminal("O que você quer "+ verb + "? Especifique um objeto (Ex: "+ verb + " janela)")
		return 
	
	if System.pages.has(verb) and System.pages[verb].has(object):
		var awnser_text = System.pages[verb][object]
		_print_terminal(awnser_text)
		
		if object == "janela":
			System.change_sanity(-10) 
			
	else:
		_print_terminal("Você não vê nenhum '" + object + "' aqui para " + verb + ".")
	

# Esta função "ouve" cada tecla que você aperta enquanto está no LineEdit
func _on_line_edit_gui_input(event: InputEvent) -> void:
	# Verifica se a tecla apertada foi o Enter ("ui_accept" é o nome padrão do Enter na Godot)
	if event.is_action_pressed("ui_accept"):
		
		# 1. Sequestramos o evento! Isso diz à Godot: "Eu já cuidei do Enter, não mude o foco e não faça mais nada!"
		$LineEdit.accept_event()
		
		# 2. Pegamos o texto e limpamos o campo na mesma hora
		var command_typed = $LineEdit.text
		$LineEdit.clear()
		
		# 3. Fazemos a mesma limpeza de antes
		var cleanAwnser = command_typed.to_lower().strip_edges()
		
		if cleanAwnser == "":
			return
			
		# 4. Limpa a tela e imprime o comando
		text = "> " + command_typed + "\n\n"
		
		# 5. Roda a nossa lógica do jogo
		_interpret_command(cleanAwnser)

extends RichTextLabel

func _ready() -> void:
	# Exemplo de como a fase chamaria a função assim que o jogo abrir:
	_print_terminal("O sol não nasceu hoje...")
	
	# Colocamos o foco automaticamente no campo de texto para o player nao precisar clicar
	$LineEdit.grab_focus()
	

func _print_terminal(new_Phrase: String) -> void:
	# 1. Injeta a frase no nó
	text = new_Phrase
	
	# 2. Zera as letras visíveis (esconde o texto para a animação fazer sentido)
	visible_characters = 0
	
	# 3. Liga a fábrica e cria o motor de animação vazio
	var tween = create_tween()
	
	# 4. Dá a ordem para o motor:
	# (alvo: eu mesmo, propriedade: "visible_characters", valor final: total de letras, tempo: 3 segundos)
	tween.tween_property(self, "visible_characters", get_total_character_count(), 3.0)


func _on_line_edit_text_submitted(new_text: String) -> void:
	# Limpamos espacos vazios que o player possa ter digitado sem querer
	var cleanAwnser = new_text.strip_edges()
	
	# Ignoramos se apertar Enter sem digitar nada
	if cleanAwnser == "":
		return
	# Salvamos o nome no nosso Autoload Global
	System.player_name = cleanAwnser
	
	# Escondemos o campo de digitacao, pois nao precisamos mais dele
	$LineEdit.hide()
	
	# Imprimimos a resposta usando o nome que acabamos de salvar na memoria
	_print_terminal("Acesso concedido, " + System.player_name + ".\nIniciando simulação de sanidade...")
	
	 

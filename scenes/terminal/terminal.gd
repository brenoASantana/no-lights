extends RichTextLabel

func _ready() -> void:
	# Exemplo de como a fase chamaria a função assim que o jogo abrir:
	# _print_terminal("O sol não nasceu hoje...")
	pass

func _print_terminal(nova_frase: String) -> void:
	# 1. Injeta a frase no nó
	text = nova_frase
	
	# 2. Zera as letras visíveis (esconde o texto para a animação fazer sentido)
	visible_characters = 0
	
	# 3. Liga a fábrica e cria o motor de animação vazio
	var tween = create_tween()
	
	# 4. Dá a ordem para o motor:
	# (alvo: eu mesmo, propriedade: "visible_characters", valor final: total de letras, tempo: 3 segundos)
	tween.tween_property(self, "visible_characters", get_total_character_count(), 3.0)

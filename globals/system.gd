extends Node

# 1. Os Megafones (Sinais Globais)
signal on_change_hp
signal on_change_sanity

# 2. O Estado (Variáveis Globais na Memória)
var player_name: String = ""
var health: int = 100
var sanity: int = 100

# O dicionario que vai guardar toda a historia do JSON
var pages: Dictionary = {}

func _ready() -> void:
	# Assim que o jogo abre, ele lê o arquivo e guarda na memória
	_load_story()

# 3. As Porteiras (Controladores de Estado)
func on_hit_player(damage: int) -> void:
	health -= damage
	on_change_hp.emit(health)
	
func change_sanity(amount: int) -> void:
	sanity += amount
	on_change_sanity.emit(sanity)

func _load_story() -> void :
	var path_file = "res://data/story.json"
	
	# Verifica se o arquivo existe para evitar crashes
	if FileAccess.file_exists(path_file):
		# Abre o arquivo em modo leitura
		var file = FileAccess.open(path_file, FileAccess.READ)
		
		# Puxa todo o texto lá de dentro
		var text_content = file.get_as_text()
		
		# Transforma a string de texto em um Dicionario navegável
		pages = JSON.parse_string(text_content)
		file.close()
	else:
		print("Erro: Arquivo story.json não encontrado!")

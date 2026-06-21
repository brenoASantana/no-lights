extends Node

# Este é o nosso Toca-Fitas universal
var music_player: AudioStreamPlayer

func _ready() -> void:
	# Criamos o nó via código assim que o jogo abre para não precisarmos de uma cena .tscn
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

# A nossa API pública para qualquer cena chamar
func play_music(new_music: AudioStream) -> void:
	# A MÁGICA DA IDEMPOTÊNCIA:
	# Se a fita que mandaram tocar for exatamente a mesma que já está rodando, ignore!
	if music_player.stream == new_music and music_player.playing:
		return 
		
	# Caso contrário, troca a fita e dá o play
	music_player.stream = new_music
	music_player.play()

func stop_music() -> void:
	music_player.stop()
	music_player.stream = null

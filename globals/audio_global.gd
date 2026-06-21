extends Node

# Este é o nosso Toca-Fitas universal
var music_player: AudioStreamPlayer
var actual_tween: Tween

func _ready() -> void:
	# Criamos o nó via código assim que o jogo abre para não precisarmos de uma cena .tscn
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

# A nossa API pública para qualquer cena chamar
func play_music(new_music: AudioStream) -> void:
	if music_player.stream == new_music and music_player.playing:
		return 

	# 1. Rebaixamos o nó atual para "temporário"
	var temp_music_player = music_player
	
	# 2. Criamos o novo titular oficial do sistema
	music_player = AudioStreamPlayer.new()
	
	# 1. ESTADO ZERO: Garante que a música nova nasça totalmente muda antes de adicioná-la à cena
	music_player.volume_db = -80.0
	
	add_child(music_player)
	
	# 3. Preparamos a música nova
	music_player.stream = new_music
	music_player.play()
	
	# 4. A MÁGICA DO TWEEN ACONTECE AQUI
	_do_crossfade(temp_music_player, music_player)

func stop_music() -> void:
	music_player.stop()
	music_player.stream = null

func _do_crossfade(temp_music_player: AudioStreamPlayer, music_player: AudioStreamPlayer) -> void:
	if actual_tween:
		actual_tween.kill()
	
	actual_tween = create_tween()
	
	# Inicia o bloco paralelo
	actual_tween.set_parallel(true)
	
	# Se existir uma música velha, abaixa o volume dela para o silêncio absoluto em 2 segundos
	if temp_music_player != null:
		actual_tween.tween_property(temp_music_player, "volume_db", -80.0, 2.0)
	
	# Sobe a música nova para o volume ambiente (-15 dB) nos mesmos 2 segundos
	actual_tween.tween_property(music_player, "volume_db", -15.0, 2.0)
	
	# Fecha o bloco paralelo. Tudo daqui para baixo voltará a ser executado em fila (esperando acabar)
	actual_tween.set_parallel(false)
	
	# 2. CALLBACK DIRECIONADO: Passamos a referência da função "queue_free" do nó temporário
	# A Godot vai esperar os 2 segundos da animação acabarem para, só então, executar a limpeza.
	if temp_music_player != null:
		actual_tween.tween_callback(temp_music_player.queue_free)
	 

extends Node

# 1. Os Megafones (Sinais)
signal on_change_hp
signal on_change_sanity

# 2. O Estado (Variáveis Globais na Memória)
var player_name: String = ""
var health: int = 100
var sanity: int = 100

# 3. As Porteiras (Funções de Modificação)
func on_hit_player(damage: int) -> void:
	health -= damage
	on_change_hp.emit(health)
	
func change_sanity(amount: int) -> void:
	sanity += amount
	on_change_sanity.emit(sanity)

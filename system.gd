extends Node

# --- Megafones (Sinais Globais) ---
signal on_change_hp
signal on_change_sanity

# --- Estado (Memória) ---
var player_name: String = ""
var health: int = 100
var sanity: int = 100

# --- Porteiras (Controladores de Estado) ---
func on_hit_player(damage: int) -> void:
	health = health - damage
	on_change_hp.emit(health)
	
func change_sanity(amount: int) -> void:
	sanity = sanity + amount
	on_change_sanity.emit(sanity)

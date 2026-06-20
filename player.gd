extends Area2D

signal hit

@export var speed = 400 
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	# ... (seu código de movimento original continua aqui) ...
	pass

func _on_body_entered(_body: Node2D) -> void:
	# O _body com underline avisa a engine que não usaremos o parâmetro do inimigo
	hide() # O próprio Player desaparece após ser atingido
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	# Correção vital: garante que o jogador nasça vulnerável e pronto para colidir
	$CollisionShape2D.disabled = false

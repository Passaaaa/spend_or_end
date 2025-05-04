extends Area2D

func _ready():
	# Conectar la señal programáticamente (opcional si ya lo haces por el editor)
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()

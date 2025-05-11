extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	print("Colisión detectada")  # Debug
	if body.is_in_group("player"):
		body.die()  # El jugador muere

extends CharacterBody2D

@export var speed: float = 50.0
@export var gravity: float = 1000.0
@export var bounce_force: float = -500.0

var active = false
var direction = -1  # siempre hacia la izquierda

func _ready():
	$TopDetector.connect("body_entered", Callable(self, "_on_top_detector_body_entered"))
	$Hitbox.connect("body_entered", Callable(self, "_on_hitbox_body_entered"))
	$ScreenNotifier.connect("screen_entered", Callable(self, "_on_screen_notifier_screen_entered"))

func _physics_process(delta):
	if not active:
		return

	# Movimiento horizontal + gravedad
	velocity.y += gravity * delta
	velocity.x = speed * direction

	move_and_slide()

func _on_screen_notifier_screen_entered():
	active = true

func _on_top_detector_body_entered(body):
	print("🟩 Golpe por encima detectado")  # Debug
	if body.is_in_group("player"):
		body.velocity.y = bounce_force  # Rebota al jugador hacia arriba
		queue_free()  # Eliminar enemigo

func _on_hitbox_body_entered(body):
	print("🟥 Colisión lateral detectada")  # Debug
	if body.is_in_group("player"):
		body.die()  # El jugador muere

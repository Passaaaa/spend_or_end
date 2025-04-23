extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = -700.0
@export var gravity: float = 1000.0

func _physics_process(delta: float) -> void:
	# Movimiento horizontal
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Saltar si estamos en el suelo
	if is_on_floor():
		velocity.y = jump_force

	# Mover al personaje
	move_and_slide()

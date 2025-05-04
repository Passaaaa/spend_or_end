extends CharacterBody2D

@export var speed: float = 100.0
@export var jump_force: float = -700.0
@export var gravity: float = 1000.0
@export var jump_release_factor: float = 0.5  # Cuánto se reduce la fuerza si sueltas pronto

var is_jumping = false

func _physics_process(delta: float) -> void:
	# Movimiento automático hacia la derecha
	velocity.x = speed

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Permitir salto solo si estamos en el suelo
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_force
			is_jumping = true

	# Acortar el salto si se suelta la tecla pronto
	if is_jumping and Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= jump_release_factor
		is_jumping = false

	# Si ya caímos, desactivamos el estado de salto
	if is_on_floor() and velocity.y >= 0:
		is_jumping = false

	move_and_slide()
	
	if position.y > 1000:  # Ajusta según la altura de tu escenario
		die()

func die():
	if get_tree().paused: return  # Evita que se active dos veces
	var death_screen = get_tree().current_scene.get_node("DeathScreen")
	death_screen.show_screen()

extends CharacterBody2D

@export var speed: float = 100.0
@export var jump_force: float = -700.0
@export var gravity: float = 1000.0
@export var jump_release_factor: float = 0.5
@export var rebound_force: float = -150.0
@export var rebound_time: float = 0.2

var is_jumping = false
var is_rebounding = false
var rebound_timer = 0.0

func _physics_process(delta: float) -> void:
	# Movimiento automático con rebote
	if is_rebounding:
		rebound_timer -= delta
		if rebound_timer <= 0.0:
			is_rebounding = false
	else:
		velocity.x = speed

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_force
			is_jumping = true

	# Salto más corto si sueltas rápido
	if is_jumping and Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= jump_release_factor
		is_jumping = false

	if is_on_floor() and velocity.y >= 0:
		is_jumping = false
		
	if position.y > 1000:
		die()
		
	# Detectar colisión lateral
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_normal().x < -0.9:  # Chocando de frente (de izquierda a derecha)
			velocity.x = rebound_force
			is_rebounding = true
			rebound_timer = rebound_time
			
func die():
	if get_tree().paused:
		return
	var death_screen = get_tree().current_scene.get_node("DeathScreen")
	if death_screen:
		death_screen.show_screen()
	else:
		print("⚠ No se encontró DeathScreen en la escena")

extends CharacterBody2D

# --- MOVIMIENTO BASE ---
@export var speed: float = 100.0
@export var jump_force: float = -700.0
@export var gravity: float = 1000.0
@export var jump_release_factor: float = 0.5

# --- REBOTE AL CHOCAR CON PAREDES ---
@export var rebound_force: float = -150.0
@export var rebound_time: float = 0.2

# --- JETPACK ---
@export var jetpack_force: float = -300.0
@export var jetpack_duration: float = 10.0

# --- ESTADOS ---
var is_jumping = false
var is_rebounding = false
var rebound_timer = 0.0
var jetpack_active = false
var jetpack_timer = 0.0

func _ready():
	add_to_group("player")
	$JetpackSprite.visible = false
	$PlayerSprite.visible = true

func _physics_process(delta: float) -> void:
	# Movimiento horizontal automático
	if is_rebounding:
		rebound_timer -= delta
		if rebound_timer <= 0.0:
			is_rebounding = false
	else:
		velocity.x = speed

	# Jetpack activo: controla el vuelo
	if jetpack_active:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jetpack_force
		else:
			velocity.y += gravity * delta

		jetpack_timer -= delta
		if jetpack_timer <= 0.0:
			jetpack_active = false
			$JetpackSprite.visible = false
			$PlayerSprite.visible = true

	else:
		# Gravedad normal + salto
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = jump_force
				is_jumping = true

		if is_jumping and Input.is_action_just_released("ui_accept") and velocity.y < 0:
			velocity.y *= jump_release_factor
			is_jumping = false

		if is_on_floor() and velocity.y >= 0:
			is_jumping = false

	# Muerte por caída al vacío
	if position.y > 1000:
		die()

	# Movimiento y colisiones
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_normal().x < -0.9 and not is_rebounding:
			velocity.x = rebound_force
			is_rebounding = true
			rebound_timer = rebound_time

func activate_jetpack():
	jetpack_active = true
	jetpack_timer = jetpack_duration
	$JetpackSprite.visible = true
	$PlayerSprite.visible = false

func die():
	if get_tree().paused:
		return
	var death_screen = get_tree().current_scene.get_node("DeathScreen")
	if death_screen:
		death_screen.show_screen()
	else:
		print("No se encontró DeathScreen en la escena")

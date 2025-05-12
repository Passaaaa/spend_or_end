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
var has_died = false

@onready var sfx = $SFX
@onready var player_sprite = $PlayerSprite
@onready var jetpack_sprite = $JetpackSprite
@onready var dead_sprite = $DeadSprite

func _ready():
	add_to_group("player")
	jetpack_sprite.visible = false
	player_sprite.visible = true
	dead_sprite.visible = false

func _physics_process(delta: float) -> void:
	if has_died:
		velocity.x = 0
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()
		return

	# Movimiento horizontal automático
	if is_rebounding:
		rebound_timer -= delta
		if rebound_timer <= 0.0:
			is_rebounding = false
	else:
		velocity.x = speed

	# Jetpack activo
	if jetpack_active:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jetpack_force
		else:
			velocity.y += gravity * delta

		jetpack_timer -= delta
		if jetpack_timer <= 0.0:
			jetpack_active = false
			jetpack_sprite.visible = false
			player_sprite.visible = true
			sfx.stop()
	else:
		# Gravedad normal + salto
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			if Input.is_action_just_pressed("ui_accept"):
				play_sound("res://04_audio/01_SFX/fx_jump_short.mp3")
				velocity.y = jump_force
				is_jumping = true

		if is_jumping and Input.is_action_just_released("ui_accept") and velocity.y < 0:
			velocity.y *= jump_release_factor
			is_jumping = false  # ⬅ ya no reproduce sonido aquí

		if is_on_floor() and velocity.y >= 0:
			is_jumping = false

	# Muerte por caída
	if not has_died and position.y > 1000:
		global_position.y = 999
		die()

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_normal().x < -0.9 and not is_rebounding:
			velocity.x = rebound_force
			is_rebounding = true
			rebound_timer = rebound_time
			play_sound("res://04_audio/01_SFX/fx_bounce.mp3")

func activate_jetpack():
	jetpack_active = true
	jetpack_timer = jetpack_duration
	jetpack_sprite.visible = true
	player_sprite.visible = false
	await get_tree().create_timer(0.25).timeout
	play_sound("res://04_audio/01_SFX/fx_jetpack_loop.mp3")

func die():
	if has_died or get_tree().paused:
		return
	has_died = true

	# Detener horizontal, permitir gravedad
	velocity.x = 0

	# Cambiar sprites
	player_sprite.visible = false
	jetpack_sprite.visible = false
	dead_sprite.visible = true

	play_sound("res://04_audio/01_SFX/fx_death.mp3")
	await get_tree().create_timer(1.07).timeout

	var death_screen = get_tree().current_scene.get_node("DeathScreen")
	if death_screen:
		death_screen.show_screen()
	else:
		print("No se encontró DeathScreen en la escena")

func play_sound(path: String):
	print("Reproduciendo en nodo:", sfx.get_path())  # TEMPORAL DEBUG
	if not sfx:
		print("Error: nodo SFX no encontrado")
		return

	if ResourceLoader.exists(path):
		var stream = load(path)
		if stream:
			sfx.stop()
			sfx.stream = stream
			sfx.play()
	else:
		print("Audio no encontrado: ", path)

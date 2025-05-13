extends Node2D

@export var lvlNoCap = PackedScene
@export var lvlCap = PackedScene
@onready var fx_ui = $FX_UI # Nodo de sonido para clics

@onready var music = $Music

func _ready():
	var music_path = "res://04_audio/02_music/Music_Quiz.mp3"
	if ResourceLoader.exists(music_path):
		var stream = load(music_path)
		music.stream = stream
		music.play()
	else:
		print("⚠ No se encontró la música:", music_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_boton_capitalista_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.6).timeout  # Espera un poco
	get_tree().change_scene_to_packed(lvlCap)


func _on_boton_no_capitalista_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.6).timeout  # Espera un poco
	get_tree().change_scene_to_packed(lvlNoCap)
	
func _play_button_sound():
	if fx_ui:
		fx_ui.play()
	

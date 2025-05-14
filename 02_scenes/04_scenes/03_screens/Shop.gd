extends Node2D

@export var lvlNoCap = PackedScene
@export var lvlCap = PackedScene
@onready var fx_ui = $FX_UI # Nodo de sonido para clics

@onready var music = $Music
@onready var tienda = $Tienda
@onready var periodico = $Periodico
@onready var texto_Cap = $Periodico/Capitalista
@onready var texto_noCap = $Periodico/NoCapitalista
@onready var changeSceneTo: PackedScene


func _ready():
	var music_path = "res://04_audio/02_music/Music_Quiz.mp3"
	if ResourceLoader.exists(music_path):
		var stream = load(music_path)
		music.stream = stream
		music.play()
	else:
		print("⚠ No se encontró la música:", music_path)
	tienda.visible = true
	periodico.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_boton_capitalista_pressed():
	_play_button_sound()
	
	tienda.visible = false
	periodico.visible = true
	texto_Cap.visible = true
	texto_noCap.visible = false
	
	changeSceneTo = lvlCap
	
	CounterController._addIndex(1)


func _on_boton_no_capitalista_pressed():
	_play_button_sound()
	
	tienda.visible = false
	periodico.visible = true
	texto_Cap.visible = false
	texto_noCap.visible = true
	
	changeSceneTo = lvlNoCap
	CounterController._addIndex(0)
	
func _play_button_sound():
	if fx_ui:
		fx_ui.play()
	
func _on_button_next_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.6).timeout  # Espera un poco
	get_tree().change_scene_to_packed(changeSceneTo)

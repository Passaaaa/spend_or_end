extends CanvasLayer

@onready var Background = $Background
@onready var tutorial_panel = $TutorialPanel
@onready var opciones_panel = $OpcionesPanel
@onready var music_slider = $OpcionesPanel/MusicSlider
@onready var sfx_slider = $OpcionesPanel/SfxSlider
@onready var intro_panel = $IntroPanel
@onready var fx_ui = $FX_UI  # Nodo de sonido para clics

func _ready():
	Background.visible = true
	tutorial_panel.visible = false
	opciones_panel.visible = false

func _on_button_empezar_pressed():
	_play_button_sound()
	intro_panel.visible = true
	Background.visible = false

func _on_button_opciones_pressed():
	_play_button_sound()
	opciones_panel.visible = true
	Background.visible = false

func _on_button_volver_pressed():
	_play_button_sound()
	opciones_panel.visible = false
	Background.visible = true

func _on_button_empezar_lvl_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://02_scenes/03_levels/01_level01/level_1.tscn")

func _on_button_salir_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()

func _on_music_slider_value_changed(value):
	# Desactivado para pruebas
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	pass

func _on_sfx_slider_value_changed(value):
	# Desactivado para pruebas
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	pass

func _on_button_tutorial_pressed():
	_play_button_sound()
	tutorial_panel.visible = true
	intro_panel.visible = false

func linear_to_db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return 20.0 * (log(value) / log(10))

func _play_button_sound():
	if fx_ui:
		fx_ui.play()

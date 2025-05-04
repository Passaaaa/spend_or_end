extends CanvasLayer

@onready var main_panel = $MainPanel
@onready var tutorial_panel = $TutorialPanel
@onready var opciones_panel = $OpcionesPanel
@onready var music_slider = $OpcionesPanel/MusicSlider
@onready var sfx_slider = $OpcionesPanel/SfxSlider

func _ready():
	main_panel.visible = true
	tutorial_panel.visible = false
	opciones_panel.visible = false
	
func _on_button_empezar_pressed():
	tutorial_panel.visible = true
	main_panel.visible = false

func _on_button_opciones_pressed():
	opciones_panel.visible = true
	main_panel.visible = false
	
func _on_button_volver_pressed():
	opciones_panel.visible = false
	main_panel.visible = true

func _on_button_empezar_lvl_pressed():
	# Cambia a la escena del nivel 1
	get_tree().change_scene_to_file("res://02_scenes/03_levels/01_level01/level_1.tscn")
	
func _on_button_salir_pressed():
	get_tree().quit()
	
func _on_music_slider_value_changed(value):
	# Desactivado para pruebas
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	pass
	
func _on_sfx_slider_value_changed(value):
	# Desactivado para pruebas
	# AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	pass

func linear_to_db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return 20.0 * (log(value) / log(10))

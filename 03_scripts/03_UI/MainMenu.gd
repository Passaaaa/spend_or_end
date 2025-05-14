extends CanvasLayer

@onready var Background = $Background
@onready var tutorial_panel = $TutorialPanel
@onready var opciones_panel = $OpcionesPanel
@onready var intro_panel = $IntroPanel

@onready var music_slider = $OpcionesPanel/MusicaSlider
@onready var music_sliderPausa = $OpcionesPanelPausa/MusicaSliderPausa

@onready var sfx_slider = $OpcionesPanel/SfxSlider
@onready var sfx_sliderPausa = $OpcionesPanelPausa/SfxSliderPausa

@onready var fx_ui = $FX_UI  # Nodo de sonido para clics


func _ready():
	
	var config = ConfigFile.new()
	
	var audio = config.load("user://settings.cfg")
	
	if audio:
		if config.has_section_key("audio", "music_volume"):
			music_slider.value = config.get_value("audio", "music_volume")
			music_sliderPausa.value = config.get_value("audio", "music_volume")
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), music_slider.value)
		if config.has_section_key("audio", "sfx_volume"):
			sfx_slider.value = config.get_value("audio", "sfx_volume")
			sfx_sliderPausa.value = config.get_value("audio", "sfx_volume")
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), sfx_slider.value)
	else:
		music_slider.value = 0
		sfx_slider.value = 0
		music_sliderPausa.value = 0
		sfx_sliderPausa.value = 0
		
	Background.visible = true
	tutorial_panel.visible = false
	opciones_panel.visible = false
	
	music_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	music_sliderPausa.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx"))
	sfx_sliderPausa.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx"))
	

func _on_button_empezar_pressed():
	_play_button_sound()
	intro_panel.visible = true
	Background.visible = false

func _on_button_opciones_pressed():
	_play_button_sound()
	opciones_panel.visible = true
	Background.visible = false

func _on_button_volver_pressed():
	
	opciones_panel.visible = false
	Background.visible = true
	_play_button_sound()
	

func _on_button_empezar_lvl_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://02_scenes/03_levels/01_level01/level_1.tscn")

func _on_button_salir_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), value)

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

func _on_musica_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
func _exit_tree():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_slider.value)
	config.set_value("audio", "sfx_volume", sfx_slider.value)
	config.save("user://settings.cfg")




func _on_button_creditos_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_scenes/03_screens/Creditos.tscn")

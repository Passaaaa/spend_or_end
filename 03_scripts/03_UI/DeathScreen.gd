extends CanvasLayer

@onready var fx_ui = $FX_UI  # Nodo de sonido para clics
@onready var gameover = $GameOver

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # Para que funcione en pausa
	visible = false

func show_screen():
	visible = true
	var gameover_path = "res://04_audio/01_SFX/fx_gameover.mp3"
	if ResourceLoader.exists(gameover_path):
		var stream = load(gameover_path)
		gameover.stream = stream
		gameover.play()
	else:
		print("⚠ No se encontró la música:", gameover_path)
	get_tree().paused = true

func _on_button_reiniciar_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_button_salir_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://02_scenes/04_scenes/03_screens/MainMenu.tscn")

func _play_button_sound():
	if fx_ui:
		fx_ui.play()

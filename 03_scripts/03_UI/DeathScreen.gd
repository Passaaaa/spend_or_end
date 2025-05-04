extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # Permite que este nodo funcione en pausa
	visible = false  # Oculta al inicio

func show_screen():
	visible = true
	get_tree().paused = true  # Pausa el juego

func _on_button_reiniciar_pressed():
	get_tree().paused = false  # Es necesario despausar antes de reiniciar
	get_tree().reload_current_scene()

func _on_button_salir_pressed():
	get_tree().quit()

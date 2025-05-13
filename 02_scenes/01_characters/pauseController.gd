extends Node

@onready var is_paused: bool
@onready var menuInstance = preload("res://02_scenes/04_scenes/03_screens/MainMenu.tscn")
var menu = null

# Called when the node enters the scene tree for the first time.
func _ready():
	is_paused = false

func _input(event):
	if event.is_action_pressed("ui_pause"):
		print("dkkdkdkdkdkddk")
		toggle_pause()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func toggle_pause():
	

	

	
	if is_paused:
		get_tree().paused = false
		is_paused = false
		menu.queue_free()
	else:
		print("b")
		menu = menuInstance.instantiate()
		add_child(menu)
		get_tree().paused = true
		menu.visible = true
		
		var inicio = menu.get_node("Background")
		var tutorial = menu.get_node("TutorialPanel")
		var intro = menu.get_node("IntroPanel")
		var opciones = menu.get_node("OpcionesPanel")
		var opcionesPausa = menu.get_node("OpcionesPanelPausa")
		
		opcionesPausa.visible = true
		inicio.visible = false
		tutorial.visible = false
		intro.visible = false
		opciones.visible = false
	
		is_paused = true
		
	
	

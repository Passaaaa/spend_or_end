extends Node2D

@export var lvlNoCap = PackedScene
@export var lvlCap = PackedScene
@onready var fx_ui = $FX_UI # Nodo de sonido para clics

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	

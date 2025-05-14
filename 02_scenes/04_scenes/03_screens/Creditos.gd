extends Node2D

@onready var creditos = $Background/VBoxContainer
@onready var velocidad = 50.0
@onready var posicion = -1200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if creditos.position.y > posicion:
		creditos.position.y -= velocidad * delta
		if creditos.position.y < posicion:
			creditos.position.y = posicion


func _on_button_menu_pressed():
	get_tree().change_scene_to_file("res://02_scenes/04_scenes/03_screens/MainMenu.tscn")

extends Node2D

@export var lvlNoCap = PackedScene
@export var lvlCap = PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_boton_capitalista_pressed():
	get_tree().change_scene_to_packed(lvlCap)


func _on_boton_no_capitalista_pressed():
	get_tree().change_scene_to_packed(lvlNoCap)
	

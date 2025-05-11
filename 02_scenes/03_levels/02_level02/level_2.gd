extends Node2D


var background: Array[TextureRect] = []
@export var textura: Texture2D 
# Called when the node enters the scene tree for the first time.

func _ready():

	for child in get_children():
		if child is TextureRect:
			background.append(child)

	for rect in background:
		rect.texture = textura	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	pass



   

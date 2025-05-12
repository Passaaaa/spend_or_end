extends Node2D


var background: Array[TextureRect] = []
@export var textura: Texture2D 
# Called when the node enters the scene tree for the first time.
@onready var music = $Music

func _ready():
	var music_path = "res://04_audio/02_music/Music_Lvl04.mp3"
	if ResourceLoader.exists(music_path):
		var stream = load(music_path)
		music.stream = stream
		music.play()
		
	for child in get_children():
		if child is TextureRect:
			background.append(child)

	for rect in background:
		rect.texture = textura	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	pass

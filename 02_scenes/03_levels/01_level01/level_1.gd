extends Node2D  # O el nodo raíz de tu nivel

@onready var music = $Music

func _ready():
	var music_path = "res://04_audio/02_music/Music_Lvl01.mp3"
	if ResourceLoader.exists(music_path):
		var stream = load(music_path)
		music.stream = stream
		music.play()
	else:
		print("⚠ No se encontró la música:", music_path)

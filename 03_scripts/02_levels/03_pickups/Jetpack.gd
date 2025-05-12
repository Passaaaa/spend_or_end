extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.play_sound("res://04_audio/01_SFX/fx_pickup.mp3")
		body.activate_jetpack()
		queue_free()

extends Node2D


@onready var finalMalo = $FinalMalo
@onready var finalBueno = $FinalBueno
@onready var progressBarCap = $FinalMalo/ProgressBarCap
@onready var progressBarNoCap = $FinalBueno/ProgressBarNoCap
@onready var capitalista: bool
@onready var fx_ui = $FX_UI

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var capIndex = CounterController.capIndex
	var noCapIndex = CounterController.noCapIndex

	if capIndex > noCapIndex:
		finalMalo.visible = true
		finalBueno.visible = false
		capitalista = true
	else: 
		finalMalo.visible = false
		finalBueno.visible = true
		capitalista = false

	if capitalista:
		if capIndex == 3:
			progressBarCap.value = 0
		else:
			if capIndex == 2:
				progressBarCap.value = 33
	else:
		if noCapIndex == 3:
			progressBarNoCap.value = 100
		else:
			if noCapIndex == 2:
				progressBarNoCap.value = 66
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_next_pressed():
	_play_button_sound()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://02_scenes/04_scenes/03_screens/MainMenu.tscn")

func _play_button_sound():
	if fx_ui:
		fx_ui.play()

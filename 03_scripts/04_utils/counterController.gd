extends Node

@onready var capIndex: int = 0
@onready var noCapIndex: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _addIndex(count: int):
	if count == 1:
		capIndex = capIndex + 1
		print(capIndex)
	 
	if count == 0:
		noCapIndex = noCapIndex + 1
		print(noCapIndex)
func _returnIndex():
	return [capIndex, noCapIndex]

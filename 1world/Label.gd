extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hp = get_node("../../players/Player")
	if hp != null:
		text =  "\n      HP: " + str(hp.health)
	else:
		text =  "\n      HP: 0"

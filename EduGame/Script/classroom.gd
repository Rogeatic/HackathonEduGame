extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	print(GlobalData.json_data_)


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_button_pressed():
	print(GlobalData.json_data_)
	pass # Replace with function body.

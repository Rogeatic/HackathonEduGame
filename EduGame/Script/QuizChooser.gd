extends Control
signal http_request_completed

func _ready():

	populate_item_list()	



func populate_item_list():
	# creates catagory node and stores it as a var
	var catagoryList = $Panel/CatagoryList
	
	var catagory_array = GlobalData.categoryDict_.keys()
	for item in catagory_array:
		catagoryList.add_item(item)
	
	
	# gets each button and assigns it as a var
	var easyButton = $Panel/easyButton
	var medButton = $Panel/mediumButton
	var hardButton = $Panel/hardButton
	
	easyButton.text = GlobalData.difficultyList_[0]
	medButton.text = GlobalData.difficultyList_[1]
	hardButton.text = GlobalData.difficultyList_[2]



func _on_ItemList_item_selected(index):
	print('slected item', $Panel/CatagoryList.get_item_text(index))

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")



func _Get_Api_Data():

	#print("Button pressed")  # Add this line
	var url = "https://opentdb.com/api.php?amount=" + str(GlobalData.number_of_quesions_) + "&category=" + str(GlobalData.selected_catagory_) + "&difficulty=" + str(GlobalData.selected_difficulty_) + "&type=" + str(GlobalData.type_of_question_[0])

	$Panel/HTTPRequest.request(url)
	print("get api data called")



func _on_play_pressed():
	var selected_subject = $Panel/CatagoryList.get_selected_items()
	# NEED TO CHECK IF SELECTED SUBER == NULL
	if len(selected_subject) > 0:
		GlobalData.selected_catagory_ = GlobalData.categoryDict_.values()[selected_subject[0]]
	
		self.connect("http_request_completed", Callable(self, "_on_http_request_done"))
		_Get_Api_Data()

	pass # Replace with function body.



func _on_http_request_request_completed(result, response_code, headers, body):
	GlobalData.json_data_ = JSON.parse_string(body.get_string_from_utf8())

	emit_signal("http_request_completed")



func _on_http_request_done():
	# Continue your code after the HTTP request here
	# Load the Quiz
	get_tree().change_scene_to_file('res://Scenes/quiz.tscn')
	self.disconnect("http_request_completed", Callable(self, "_on_http_request_done"))
	# self.disconnect("http_request_completed", self, "_on_http_request_done")



func _on_easy_button_pressed():
	GlobalData.selected_difficulty_ = GlobalData.difficultyList_[0] # easy, diffculty_list_ to avoid any chances of errors
	print(GlobalData.selected_difficulty_)



func _on_medium_button_pressed():
	GlobalData.selected_difficulty_ = GlobalData.difficultyList_[1]
	print(GlobalData.selected_difficulty_)



func _on_hard_button_pressed():
	GlobalData.selected_difficulty_ = GlobalData.difficultyList_[2]
	print(GlobalData.selected_difficulty_)



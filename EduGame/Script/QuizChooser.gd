extends Control



#var categoryDict = {
#	"Natural Science": 17,
#	"Geography": 22,
#	"Math": 19,
#	"Computer Science": 18,
#	"History": 23
#}




signal http_request_completed


func _ready():
	var subjects = GlobalData.categoryDict_.keys()
	var itemList = $Panel/ItemList 
	populate_item_list(subjects, itemList)
	
	

func populate_item_list(items_array, itemNode):
	itemNode.clear()
	
	for item in items_array:
		itemNode.add_item(item)

func _on_ItemList_item_selected(index):
	print('slected item', $ItemList.get_item_text(index))




func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _Get_Api_Data():
	#print("Button pressed")  # Add this line
	var url = "https://opentdb.com/api.php?amount=" + str(GlobalData.number_of_quesions_) + "&category=" + str(GlobalData.selected_catagory_) + "&difficulty=" + str(GlobalData.selected_difficulty_[0]) + "&type=" + str(GlobalData.type_of_question_[0])

	$Panel/HTTPRequest.request(url)
	print("get api data called")

func _on_play_pressed():
	var selected_subject = $Panel/ItemList.get_selected_items()
	
	# GlobalData.subject_studying_ = selected_subject
	#print(ApiSecondNew.categoryDict.values())
	
	# NEED TO CHECK IF SELECTED SUBER == NULL
	if len(selected_subject) > 0:
		GlobalData.selected_catagory_ = GlobalData.categoryDict_.values()[selected_subject[0]]
	#var input = ApiSecondNew.categoryDict.values()[selected_subject[0]]
	
		self.connect("http_request_completed", Callable(self, "_on_http_request_done"))
		_Get_Api_Data()
	#var data = _Get_Api_Data()


	#print(GlobalData.getFirstQuestion())
	#print(GlobalData.removeFirstQuestion())
	#get_tree().change_scene_to_file('res://Scenes/classroom.tscn')
	
	
	pass # Replace with function body.


func _on_http_request_request_completed(result, response_code, headers, body):
	GlobalData.json_data_ = JSON.parse_string(body.get_string_from_utf8())
	emit_signal("http_request_completed")
	# print(str(GlobalData.json_data_))
	
func _on_http_request_done():
	# Continue your code after the HTTP request here
	get_tree().change_scene_to_file('res://Scenes/classroom.tscn')
	self.disconnect("http_request_completed", Callable(self, "_on_http_request_done"))
	#self.disconnect("http_request_completed", self, "_on_http_request_done")

extends Control



func _ready():
	var subjects = GlobalData.pos_subjects_
	var itemList = $Panel/ItemList 
	populate_item_list(subjects, itemList)
	

func populate_item_list(items_array, itemNode):
	itemNode.clear()
	
	for item in items_array:
		itemNode.add_item(item)

func _on_ItemList_item_selected(index):
	print('slected item', $ItemList.get_item_text(index))


func _on_item_list_item_activated(index):
	print('connected')
	pass # Replace with function body.


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_play_pressed():
	var selected_subject = $Panel/ItemList.get_selected_items()
	
	GlobalData.subject_studying = selected_subject
	
	
	pass # Replace with function body.

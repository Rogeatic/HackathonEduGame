extends Control



func _ready():
	var subjects = ["Math", "Science", "Health"]
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

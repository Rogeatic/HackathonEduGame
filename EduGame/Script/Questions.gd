extends MarginContainer
var question_label
var but1
var but2
var but3
var but4

var answers
var question
var index
var label
var timer
var buttons
# Called when the node enters the scene tree for the first time.
func _ready():
	index = 0
	label = $Question/Label
	timer = $Question/Timer
	label.visible = false
	GlobalData.json_wrong_["results"] = []
	question_label = $Question
	but1 = $Question/Button1
	but2 = $Question/Button2
	but3 = $Question/Button3
	but4 = $Question/Button4

	question = GlobalData.getFirstQuestion()
	question_label.text = question

	answers = GlobalData.getFirstAnswers()
	but1.text = answers[0]
	but3.text = answers[2]
	but4.text = answers[3]
	but2.text = answers[1]
	buttons = [but1, but2, but3, but4]
	for i in buttons:
		i.modulate = Color(1,1,1)	

func _on_button_1_pressed():
	checkIfCorrect(but1)

func _on_button_2_pressed():
	checkIfCorrect(but2)

func _on_button_3_pressed():
	checkIfCorrect(but3)

func _on_button_4_pressed():
	checkIfCorrect(but4)


func _move_to_next_QuestionData():
	if index < GlobalData.getQuestionsLength()-1:
		index += 1
		
		question = GlobalData.getQuestion(index)
		answers = GlobalData.getAnswers(index)
		
		question_label.text = question
		
		for i in buttons:
			i.modulate = Color(1,1,1)	
		
		but1.text = answers[0]
		but2.text = answers[1]
		but3.text = answers[2]
		but4.text = answers[3]
	else:
		print(GlobalData.json_wrong_["results"])
		print("done")
		
		#Go To the Dream State
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
func checkIfCorrect(button):
	if button.text == GlobalData.getCorrectAnswer(index):
		timer.wait_time = 5
		button.modulate = Color(0, 1, 0)	
	else:
		timer.wait_time = 10
		GlobalData.json_wrong_["results"].append(GlobalData.json_data_["results"][index])
		button.modulate = Color(1, 0, 0)
		for i in buttons:
			if i.text == GlobalData.getCorrectAnswer(index):
				i.modulate = Color(0,1,0)	
	label.visible = true
	timer.autostart = true
	timer.start()
	disableButtons()
		

func _process(delta):
	label.text = str(int(timer.wait_time))
	if timer.wait_time <= .75:
		timer.wait_time = 10
		label.visible = false
		timer.autostart = false
		enableButtons()
		_move_to_next_QuestionData()
	timer.wait_time -=1 * delta
	print(str(int(timer.wait_time)))
	
func disableButtons():
	but1.disabled = true
	but2.disabled = true
	but3.disabled = true
	but4.disabled = true

func enableButtons():
	but1.disabled = false
	but2.disabled = false
	but3.disabled = false
	but4.disabled = false

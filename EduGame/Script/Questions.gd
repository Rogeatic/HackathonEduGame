extends MarginContainer
var question_label
var but1
var but2
var but3
var but4

var answers
var question
var index
var savedColor
# Called when the node enters the scene tree for the first time.
func _ready():
	index = 0
	GlobalData.incorrect_ = 0
	question_label = $Question
	but1 = $Question/Button1
	but2 = $Question/Button2
	but3 = $Question/Button3
	but4 = $Question/Button4

	question = GlobalData.getFirstQuestion()
	question_label.text = question

	answers = GlobalData.getFirstAnswers()
	savedColor = Color(1, 1, 1)
	but1.text = answers[0]
	but3.text = answers[2]
	but4.text = answers[3]
	but2.text = answers[1]

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
		
		but1.modulate = savedColor
		but2.modulate = savedColor
		but3.modulate = savedColor
		but4.modulate = savedColor
		
		but1.text = answers[0]
		but2.text = answers[1]
		but3.text = answers[2]
		but4.text = answers[3]
	else:
		print("done")
		pass
		# MOVE TO NEXT SCREEN
func checkIfCorrect(button):
	if button.text == GlobalData.getCorrectAnswer(index):
		_move_to_next_QuestionData()
	else:
		GlobalData.incorrect_ += 1
		button.modulate = Color(1, 0, 0)
		#button.background_color = Color(0.5, 0.2, 0.1) 
		

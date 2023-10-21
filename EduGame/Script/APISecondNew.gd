extends Control
var numberOfQuestions = 5



var categoryDict = {
	"Natural Science": 17,
	"Geography": 22,
	"Math": 19,
	"Computer Science": 18,
	"History": 23
}
var Difficulty = ["easy", "medium", "hard"]
var input = "Natural Science"
var category = categoryDict[input]
var type = ["multiple", "boolean"]
var jsonData = null
var placeHolderList = {"results":[]}



func _Get_Api_Data():
	#print("Button pressed")  # Add this line
	var url = "https://opentdb.com/api.php?amount=" + str(numberOfQuestions) + "&category=" + str(category) + "&difficulty=" + str(Difficulty[0]) + "&type=" + str(type[0])

	$HTTPRequest.request(url)

	#if len(jsonData) > 0:
	#	question = jsonData["results"].pop(0)
	#print(question)
	
	#var correctAnswer = question["correct_answer"]
	#var incorrectAnswers = question["incorrect_answers"]
	
	#var answers = incorrectAnswers + [correctAnswer]
	#answers.shuffle()
	
	#var isCorrect = []
	#for i in range(answers.size()):
	#	isCorrect.append(answers[i] == correctAnswer)



	
	
	
func _on_http_request_request_completed(result, response_code, headers, body):
	GlobalData.json_data_ = JSON.parse_string(body.get_string_from_utf8())
	#print(jsonData["results"])
	
	
	
	# Extract the question and answers
	var question = GlobalData.json_data_.getAndPopFirstQuestion()
	print(question["question"])
	
	
	# Get generated list of answers 
	var correctAnswer = question["correct_answer"]
	var incorrectAnswers = question["incorrect_answers"]
	var answers = getRandomAnswersList(correctAnswer, incorrectAnswers)
	var questionNum = 1
	for answer in answers:
		print(str(questionNum) + ")" + answer)
		questionNum+=1
	# get user answer
	
	# Create a list of true and false values where true indicates the correct answer's index
	var isCorrect = []
	for i in range(answers.size()):
		isCorrect.append(answers[i] == correctAnswer)
	
	

func getFirstQuestion():
	if len(jsonData["results"]) > 0:
		return jsonData["results"][0]
	else:
		print("failed get data, might be out of questions")
		return jsonData

func removeFirstQuestion():
		placeHolderList["results"].add(jsonData["results"][0])
		jsonData["results"].remove_at(0)
func getRandomAnswersList(correctAnswer, incorrectAnswers):
	# Randomize the order of the answers, including the correct answer
	var answers = incorrectAnswers + [correctAnswer]
	answers.shuffle()
	return answers

	
	
	#$HTTPRequest.request("https://api.quizlet.com/")
	#$HTTPRequest.request("https://access-2.kahoot.com/auth/realms/kahoot-api/protocol/openid-connect/token")
	#$HTTPRequest.request("https://api.quizlet.com/")

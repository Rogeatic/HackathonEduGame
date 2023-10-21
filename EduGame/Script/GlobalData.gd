extends Node

# underscore at the end of variable name is how to show that the var is global
# var pos_subjects_ = ["Math", "Science", "English"]

var categoryDict_ = {
	"Natural Science": 17,
	"Geography": 22,
	"Math": 19,
	"Computer Science": 18,
	"History": 23
}

var difficultyList_ = [
	"easy",
	"medium",
	"hard"
]

var type_of_question_ = ["multiple", "boolean"]
var number_of_quesions_ = 5
var selected_catagory_ # this is the value not the key
var selected_difficulty_ = "easy"

var subject_studying_

var json_data_
var json_wrong_ = {"results":[]}

func getFirstQuestion():
	if (len(json_data_["results"]) > 0):
		print (json_data_)
		return json_data_["results"][0]["question"]
	else:
		print("outOfQuestions")
		return null

#func removeFirstQuestion():
#	if (len(json_data_["results"]) > 0):
#		print ("removing")
#		json_carrier_["results"].append(json_data_["results"][0]["question"])
#		json_data_["results"].remove_at(0)
#		return json_carrier_["results"][len(json_carrier_["results"])-1]
#	else:
#		print("outOfQuestions")
#		return null

func removeFirstQuestion():
	if (len(json_data_["results"]) > 0):
		# print ("removing")
		json_wrong_["results"].append(json_data_["results"][0]["question"])
		# json_data_["results"].remove_at(0)
		return json_wrong_["results"][len(json_wrong_["results"])-1]
	else:
		print("outOfQuestions")
		return null

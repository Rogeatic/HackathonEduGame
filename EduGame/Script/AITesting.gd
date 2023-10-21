extends Node


var http_request = HTTPRequest.new()

func _ready():
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request.request("https://api.deepai.org/api/text-generator", [], HTTPClient.METHOD_POST)

func _on_request_completed(result, response_code, headers, body):
	#if result == HTTPRequest.RESULT_SUCCESS:
	print(body.get_string_from_utf8())

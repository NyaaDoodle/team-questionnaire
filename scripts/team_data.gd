class_name TeamData

var id: int
var name: String
var color: Color
var questions: Array[Question]

func _init(input_id: int, input_name: String, input_color: Color, input_questions: Array[Question]) -> void:
    id = input_id
    name = input_name
    color = input_color
    questions = input_questions
class_name Team extends Resource

@export var id: int = 0
@export var name: String = ""
@export var color: Color = Color.BLACK
@export var questions: Array[Question] = []
@export var score: int = 0
var _current_question_index: int = 0

func has_questions_left() -> bool:
    return _current_question_index < questions.size()

func get_next_question() -> Question:
    if not has_questions_left():
        return null
    var question: Question = questions[_current_question_index]
    _current_question_index += 1
    return question
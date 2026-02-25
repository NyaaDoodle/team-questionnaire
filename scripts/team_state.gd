class_name TeamState

var team_data: TeamData
var score: int
var _current_question_index: int

func _init(input_team_data: TeamData) -> void:
    team_data = input_team_data
    score = 0
    _current_question_index = 0

func has_questions_left() -> bool:
    return _current_question_index < team_data.questions.size()

func get_next_question() -> Question:
    if not has_questions_left():
        return null
    var question: Question = team_data.questions[_current_question_index]
    _current_question_index += 1
    return question
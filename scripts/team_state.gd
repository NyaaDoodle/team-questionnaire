class_name TeamState

var team_data: TeamData
var score: int
var current_question: int

func _init(input_team_data: TeamData) -> void:
    team_data = input_team_data
    score = 0
    current_question = 0
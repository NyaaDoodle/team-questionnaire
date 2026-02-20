class_name GameManager extends Node

@onready var screen_loader: ScreenLoader = $ScreenLoader

var teams: Array[TeamState] = []

func _ready() -> void:
    _start_game()

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("close_game"):
        get_tree().quit()

func _start_game() -> void:
    _prepare_teams()

func _prepare_teams() -> void:
    _prepare_red_team()
    _prepare_blue_team()

func _prepare_red_team() -> void:
    var question1: Question = Question.new("Red Question 1", "Correct", "Incorrect", Question.AnswerChoice.LeftAnswer)
    var question2: Question = Question.new("Red Question 2", "Correct", "Incorrect", Question.AnswerChoice.RightAnswer)
    var question3: Question = Question.new("Red Question 3", "Correct", "Incorrect", Question.AnswerChoice.LeftAnswer)
    var questions: Array[Question] = [question1, question2, question3]
    var red_team_data: TeamData = TeamData.new(1, "Team Red", Color.RED, questions)
    var red_team_state: TeamState = TeamState.new(red_team_data)
    teams.append(red_team_state)

func _prepare_blue_team() -> void:
    var question1: Question = Question.new("Blue Question 1", "Correct", "Incorrect", Question.AnswerChoice.RightAnswer)
    var question2: Question = Question.new("Blue Question 2", "Correct", "Incorrect", Question.AnswerChoice.LeftAnswer)
    var question3: Question = Question.new("Blue Question 3", "Correct", "Incorrect", Question.AnswerChoice.RightAnswer)
    var questions: Array[Question] = [question1, question2, question3]
    var blue_team_data: TeamData = TeamData.new(2, "Team Blue", Color.BLUE, questions)
    var blue_team_state: TeamState = TeamState.new(blue_team_data)
    teams.append(blue_team_state)
    
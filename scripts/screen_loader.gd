class_name ScreenLoader extends Node

signal game_screen_closed

@export var initial_scene: PackedScene
@export var result_screen_scene: PackedScene
@export var question_screen_scene: PackedScene

var current_screen: GameScreen

func _ready() -> void:
	var question: Question = Question.new()
	question.question_string = "Test Question String"
	question.left_answer_string = "Correct"
	question.right_answer_string = "לא נכון"
	question.correct_answer = Question.AnswerChoice.LeftAnswer
	var team: TeamData = TeamData.new()
	team.id = 1
	team.name = "a"
	team.color = Color.WHITE
	team.questions = []
	show_question_screen(question, team)

func spawn_screen(screen_scene: PackedScene) -> void:
	close_current_screen()
	current_screen = screen_scene.instantiate()
	current_screen.request_close.connect(close_current_screen)
	add_child(current_screen)

func show_result_screen(left_hand_score: int, right_hand_score: int) -> void:
	spawn_screen(result_screen_scene)
	if current_screen is ResultsScreen:
		current_screen.setup(left_hand_score, right_hand_score)
	else:
		print_incorrect_screen_scene_error("ResultsScreen")
		close_current_screen()
	
func show_question_screen(question: Question, team: TeamData) -> void:
	spawn_screen(question_screen_scene)
	if current_screen is QuestionScreen:
		current_screen.setup(question, team.color)
	else:
		print_incorrect_screen_scene_error("QuestionScreen")
		close_current_screen()

func close_current_screen() -> void:
	if is_instance_valid(current_screen):
		current_screen.queue_free()
		game_screen_closed.emit()

func print_incorrect_screen_scene_error(expected_type: String) -> void:
	push_error("Incorrect screen scene specified, expected %s" % expected_type)
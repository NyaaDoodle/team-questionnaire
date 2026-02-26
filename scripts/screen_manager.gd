class_name ScreenManager extends Node

signal results_screen_closed
signal question_screen_closed
signal correct_answer_chosen
signal wrong_answer_chosen

@export var _results_screen_scene: PackedScene
@export var _question_screen_scene: PackedScene

@onready var _background_panel: BackgroundPanel = $BackgroundPanel

var _current_screen: GameScreen

func _spawn_screen(screen_scene: PackedScene, on_requested_close: Callable) -> void:
	# Spawns a GameScreen based scene. No inititalization of the spawned screen is done.
	_close_current_screen()
	_current_screen = screen_scene.instantiate()
	_current_screen.requested_close.connect(on_requested_close)
	add_child(_current_screen)

func _spawn_results_screen(left_team: Team, right_team: Team, label_text: String = "") -> void:
	_spawn_screen(_results_screen_scene, _close_results_screen)
	if _current_screen is ResultsScreen:
		_current_screen.setup(left_team.score, right_team.score, label_text)
	else:
		_print_incorrect_screen_scene_error("ResultsScreen")
		_close_current_screen()

func _spawn_question_screen(question: Question) -> void:
	_spawn_screen(_question_screen_scene, close_question_screen)
	if _current_screen is QuestionScreen:
		_current_screen.setup(question)
		_current_screen.correct_answer_chosen.connect(correct_answer_chosen.emit)
		_current_screen.wrong_answer_chosen.connect(wrong_answer_chosen.emit)
	else:
		_print_incorrect_screen_scene_error("QuestionScreen")
		_close_current_screen()

func show_results_screen(left_team: Team, right_team: Team, label_text: String = "") -> void:
	_background_panel.slide_switch_to_halves(left_team.color, right_team.color)
	_spawn_results_screen(left_team, right_team, label_text)

func show_final_results_screen(left_team: Team, right_team: Team, victory_state: GameManager.VictoryState) -> void:
	var win_text: String = ""
	match victory_state:
		GameManager.VictoryState.Tie:
			win_text = "It's a tie!"
			_background_panel.slide_switch_to_halves(left_team.color, right_team.color)
		GameManager.VictoryState.LeftTeamWon:
			win_text = "The winner is %s!" % left_team.name
			_background_panel.slide_switch_to_left_panel(left_team.color)
		GameManager.VictoryState.RightTeamWon:
			win_text = "The winner is %s!" % right_team.name
			_background_panel.slide_switch_to_right_panel(right_team.color)
	_spawn_results_screen(left_team, right_team, win_text)
	
func show_question_screen(question: Question, background_color: Color, direction: Team.Direction) -> void:
	_slide_change_background(background_color, direction)
	_spawn_question_screen(question)

func _slide_change_background(color: Color, direction: Team.Direction) -> void:
	match direction:
		Team.Direction.LeftTeam:
			_background_panel.slide_switch_to_left_panel(color)
		Team.Direction.RightTeam:
			_background_panel.slide_switch_to_right_panel(color)

func _close_current_screen() -> void:
	if is_instance_valid(_current_screen):
		_current_screen.queue_free()

func _close_results_screen() -> void:
	_close_current_screen()
	results_screen_closed.emit()

func close_question_screen() -> void:
	_close_current_screen()
	question_screen_closed.emit()

func _print_incorrect_screen_scene_error(expected_type: String) -> void:
	push_error("ScreenManager._print_incorrect_screen_scene_error: Incorrect screen scene specified, expected %s" % expected_type)
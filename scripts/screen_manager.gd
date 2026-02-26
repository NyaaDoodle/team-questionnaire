class_name ScreenManager extends Node

signal results_screen_closed
signal question_screen_closed
signal correct_answer_chosen
signal wrong_answer_chosen

@export var _results_screen_scene: PackedScene
@export var _question_screen_scene: PackedScene

@onready var _background_panel: BackgroundPanel = $BackgroundPanel

var _current_screen: GameScreen

func spawn_screen(screen_scene: PackedScene, on_requested_close: Callable) -> void:
	# Spawns a GameScreen based scene. No inititalization of the spawned screen is done.
	close_current_screen()
	_current_screen = screen_scene.instantiate()
	_current_screen.requested_close.connect(on_requested_close)
	add_child(_current_screen)

func show_results_screen(left_hand_score: int, right_hand_score: int, background_color: Color, label_text: String = "") -> void:
	_background_panel.change_color(background_color)
	spawn_screen(_results_screen_scene, close_results_screen)
	if _current_screen is ResultsScreen:
		_current_screen.setup(left_hand_score, right_hand_score, label_text)
	else:
		_print_incorrect_screen_scene_error("ResultsScreen")
		close_current_screen()
	
func show_question_screen(question: Question, background_color: Color) -> void:
	_background_panel.change_color(background_color)
	spawn_screen(_question_screen_scene, close_question_screen)
	if _current_screen is QuestionScreen:
		_current_screen.setup(question)
		_current_screen.correct_answer_chosen.connect(correct_answer_chosen.emit)
		_current_screen.wrong_answer_chosen.connect(wrong_answer_chosen.emit)
	else:
		_print_incorrect_screen_scene_error("QuestionScreen")
		close_current_screen()

func close_current_screen() -> void:
	if is_instance_valid(_current_screen):
		_current_screen.queue_free()

func close_results_screen() -> void:
	close_current_screen()
	results_screen_closed.emit()

func close_question_screen() -> void:
	close_current_screen()
	question_screen_closed.emit()

func _print_incorrect_screen_scene_error(expected_type: String) -> void:
	push_error("ScreenManager._print_incorrect_screen_scene_error: Incorrect screen scene specified, expected %s" % expected_type)
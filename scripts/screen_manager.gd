class_name ScreenManager extends Node

signal results_screen_closed
signal question_screen_closed
signal correct_answer_chosen
signal wrong_answer_chosen

@export var results_screen_scene: PackedScene
@export var question_screen_scene: PackedScene

var current_screen: GameScreen

func spawn_screen(screen_scene: PackedScene, on_requested_close: Callable) -> void:
	# Spawns a GameScreen based scene. No inititalization of the spawned screen is done.
	close_current_screen()
	current_screen = screen_scene.instantiate()
	current_screen.requested_close.connect(on_requested_close)
	add_child(current_screen)

func show_results_screen(left_hand_score: int, right_hand_score: int, background_color: Color, label_text: String = "") -> void:
	spawn_screen(results_screen_scene, close_results_screen)
	if current_screen is ResultsScreen:
		current_screen.setup(left_hand_score, right_hand_score, background_color, label_text)
	else:
		print_incorrect_screen_scene_error("ResultsScreen")
		close_current_screen()
	
func show_question_screen(question: Question, background_color: Color) -> void:
	spawn_screen(question_screen_scene, close_question_screen)
	if current_screen is QuestionScreen:
		current_screen.setup(question, background_color)
		current_screen.correct_answer_chosen.connect(correct_answer_chosen.emit)
		current_screen.wrong_answer_chosen.connect(wrong_answer_chosen.emit)
	else:
		print_incorrect_screen_scene_error("QuestionScreen")
		close_current_screen()

func close_current_screen() -> void:
	if is_instance_valid(current_screen):
		current_screen.queue_free()

func close_results_screen() -> void:
	close_current_screen()
	results_screen_closed.emit()

func close_question_screen() -> void:
	close_current_screen()
	question_screen_closed.emit()

func print_incorrect_screen_scene_error(expected_type: String) -> void:
	push_error("Incorrect screen scene specified, expected %s" % expected_type)
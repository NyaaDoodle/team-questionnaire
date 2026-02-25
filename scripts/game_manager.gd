class_name GameManager extends Node

@export var _game_data: GameData
@onready var _screen_manager: ScreenManager = $ScreenManager

var _teams: Array[Team]:
	set(value):
		_game_data.teams = value
	get:
		return _game_data.teams

var _turn_queue: TurnQueue

func _ready() -> void:
	_prepare_connections_in_screen_manager()
	_start_game()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_game"):
		_exit_program()

func _exit_program() -> void:
	get_tree().quit()

func _start_game() -> void:
	_prepare_teams()
	_start_next_turn()

func _prepare_teams() -> void:
	_turn_queue = TurnQueue.new(_game_data.teams)

func _prepare_connections_in_screen_manager() -> void:
	_screen_manager.question_screen_closed.connect(_on_question_screen_closed)
	_screen_manager.results_screen_closed.connect(_on_results_screen_closed)
	_screen_manager.correct_answer_chosen.connect(_on_correct_answer_chosen)

func _remove_connections_in_screen_manager() -> void:
	if _screen_manager.question_screen_closed.is_connected(_on_question_screen_closed):
		_screen_manager.question_screen_closed.disconnect(_on_question_screen_closed)
	if _screen_manager.results_screen_closed.is_connected(_on_results_screen_closed):
		_screen_manager.results_screen_closed.disconnect(_on_results_screen_closed)
	if _screen_manager.correct_answer_chosen.is_connected(_on_correct_answer_chosen):
		_screen_manager.correct_answer_chosen.disconnect(_on_correct_answer_chosen)

func _on_question_screen_closed() -> void:
	_show_results_screen()

func _on_results_screen_closed() -> void:
	_turn_queue.move_to_next_team()
	_start_next_turn()

func _on_correct_answer_chosen() -> void:
	var current_team: Team = _turn_queue.get_current_team()
	if current_team != null:
		current_team.score += 1

func _start_next_turn() -> void:
	if _turn_queue.is_empty():
		end_game()
	else:
		var current_team: Team = _turn_queue.get_current_team()
		if current_team.has_questions_left():
			_ask_team_question(current_team)
		else:
			_turn_queue.remove_current_team()
			_start_next_turn()
		

func _ask_team_question(current_team: Team) -> void:
	if current_team.has_questions_left():
		var current_question: Question = current_team.get_next_question()
		_screen_manager.show_question_screen(current_question, current_team.color)

func _show_results_screen() -> void:
	_screen_manager.show_results_screen(_teams[0].score, _teams[1].score, Color.BLACK)

func end_game() -> void:
	_remove_connections_in_screen_manager()
	_screen_manager.results_screen_closed.connect(_exit_program)
	var left_team_score = _teams[0].score
	var right_team_score = _teams[1].score
	var win_text = ""
	if left_team_score == right_team_score:
		win_text = "It is a draw!"
	else:
		win_text = "The winner is %s!" % (_teams[0].name if left_team_score > right_team_score else _teams[1].name)
	_screen_manager.show_results_screen(_teams[0].score, _teams[1].score, Color.BLACK, win_text)

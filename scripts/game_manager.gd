class_name GameManager extends Node

enum VictoryState { LeftTeamWon, RightTeamWon, Tie }

@export var _game_data: GameData
@onready var _screen_manager: ScreenManager = $ScreenManager

var _left_team: Team = null
var _right_team: Team = null
var _current_team: Team = null

func _ready() -> void:
	_start_game()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_game"):
		_exit_program()

func _exit_program() -> void:
	get_tree().quit()

func _start_game() -> void:
	_prepare_connections_in_screen_manager()
	_prepare_teams()
	if _check_teams_validity():
		_start_next_turn()
	else:
		_exit_program()

func _prepare_teams() -> void:
	_left_team =  _game_data.left_team
	_right_team = _game_data.right_team
	_current_team = _left_team

func _check_teams_validity() -> bool:
	if _left_team == null:
		push_error("GameManager._check_teams_validity: Left team is set to null")
		return false
	elif _left_team.direction != Team.Direction.LeftTeam:
		push_error("GameManager._check_teams_validity: Left team's direction is not set to LeftTeam")
		return false
	elif _right_team == null:
		push_error("GameManager._check_teams_validity: Right team is set to null")
		return false
	elif _right_team.direction != Team.Direction.RightTeam:
		push_error("GameManager._check_teams_validity: Right team's direction is not set to RightTeam")
		return false
	return true

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
	_move_to_next_team()
	_start_next_turn()

func _on_correct_answer_chosen() -> void:
	_current_team.score += 1

func _move_to_next_team():
	_current_team = _left_team if (_current_team == _right_team or _current_team == null) else _right_team

func _is_any_team_have_questions():
	return _left_team.has_questions_left() || _right_team.has_questions_left()

func _start_next_turn() -> void:
	if not _is_any_team_have_questions():
		end_game()
	else:
		if _current_team.has_questions_left():
			_ask_team_question()
		else:
			_move_to_next_team()
			_start_next_turn()
		

func _ask_team_question() -> void:
	if _current_team.has_questions_left():
		var current_question: Question = _current_team.get_next_question()
		_screen_manager.show_question_screen(current_question, _current_team.color, _current_team.direction)

func _show_results_screen() -> void:
	_screen_manager.show_results_screen(_left_team, _right_team)

func _decide_winning_team() -> VictoryState:
	if _left_team.score == _right_team.score:
		return VictoryState.Tie
	elif _left_team.score > _right_team.score:
		return VictoryState.LeftTeamWon
	else:
		return VictoryState.RightTeamWon

func end_game() -> void:
	_remove_connections_in_screen_manager()
	var victory_state: VictoryState = _decide_winning_team()
	_screen_manager.results_screen_closed.connect(_exit_program)
	_screen_manager.show_final_results_screen(_left_team, _right_team, victory_state)
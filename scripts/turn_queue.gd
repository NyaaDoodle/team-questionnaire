class_name TurnQueue

var _teams: Array[TeamState] = []
var _current_team_index: int = 0

func _init(input_teams: Array[TeamState]) -> void:
    _teams = input_teams.duplicate()
    _current_team_index = 0

func is_empty() -> bool:
    return _teams.is_empty()

func get_current_team() -> TeamState:
    if is_empty():
        return null
    return _teams[_current_team_index]

func remove_current_team() -> void:
    if not is_empty():
        _teams.remove_at(_current_team_index)
        move_to_next_team()

func move_to_next_team() -> void:
    if not is_empty():
        _current_team_index = (_current_team_index + 1) % _teams.size()
class_name ResultsScreen extends GameScreen

@onready var left_hand_label: Label = $LeftHandLabel
@onready var right_hand_label: Label = $RightHandLabel

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_results_screen"):
		requested_close.emit()

func setup(left_score: int, right_score: int) -> void:
	left_hand_label.text = str(left_score)
	right_hand_label.text = str(right_score)

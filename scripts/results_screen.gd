class_name ResultsScreen extends GameScreen

@onready var left_hand_label: Label = $LeftHandLabel
@onready var right_hand_label: Label = $RightHandLabel
@onready var title_label: Label = $TitleLabel

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_results_screen"):
		requested_close.emit()

func setup(left_score: int, right_score: int, background_color: Color, label_text: String = "") -> void:
	left_hand_label.text = str(left_score)
	right_hand_label.text = str(right_score)
	title_label.text = label_text
	change_background_color(background_color)

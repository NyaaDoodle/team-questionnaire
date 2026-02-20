class_name QuestionScreen extends GameScreen

signal correct_answer_chosen
signal wrong_answer_chosen

@onready var question_label: Label = $QuestionLabel
@onready var left_answer_button: Button = $LeftAnswerButton
@onready var right_answer_button: Button = $RightAnswerButton

var correct_answer_button: Button
var wrong_answer_button: Button
var is_answer_chosen: bool = false

func _input(event: InputEvent) -> void:
	if is_answer_chosen and event.is_action_pressed("close_question_screen"):
		requested_close.emit()

func setup(question: Question, background_color: Color) -> void:
	_set_labels(question.question_string,
	 question.left_answer_string,
	 question.right_answer_string)
	_set_buttons(question.correct_answer)
	change_background_color(background_color)

func _set_labels(question_string: String,
				left_button_string: String,
				right_button_string: String) -> void:
	question_label.text = question_string
	left_answer_button.text = left_button_string
	right_answer_button.text = right_button_string

func _set_buttons(correct_answer: Question.AnswerChoice) -> void:
	var is_left_button_correct_answer: bool = (correct_answer == Question.AnswerChoice.LeftAnswer)
	correct_answer_button = left_answer_button if is_left_button_correct_answer else right_answer_button
	wrong_answer_button = right_answer_button if is_left_button_correct_answer else left_answer_button
	correct_answer_button.pressed.connect(_on_correct_answer_button_pressed)
	wrong_answer_button.pressed.connect(_on_wrong_answer_button_pressed)

func _on_correct_answer_button_pressed() -> void:
	_disable_buttons()
	_color_button(correct_answer_button, Color.GREEN)
	correct_answer_chosen.emit()
	is_answer_chosen = true

func _on_wrong_answer_button_pressed() -> void:
	_disable_buttons()
	_color_button(wrong_answer_button, Color.RED)
	_color_button(correct_answer_button, Color.GREEN)
	wrong_answer_chosen.emit()
	is_answer_chosen = true

func _disable_buttons() -> void:
	left_answer_button.disabled = true
	right_answer_button.disabled = true

func _color_button(button: Button, color: Color) -> void:
	var stylebox = button.get_theme_stylebox("normal").duplicate()
	stylebox.bg_color = color
	button.add_theme_stylebox_override("normal", stylebox)
	button.add_theme_stylebox_override("pressed", stylebox)
	button.add_theme_stylebox_override("hover", stylebox)
	button.add_theme_stylebox_override("disabled", stylebox)
	button.add_theme_stylebox_override("focus", stylebox)
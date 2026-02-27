class_name QuestionScreen extends GameScreen

signal correct_answer_chosen
signal wrong_answer_chosen

@onready var question_label: Label = $QuestionLabel
@onready var left_answer_button: AnswerButton = $LeftAnswerButton
@onready var right_answer_button: AnswerButton = $RightAnswerButton

var correct_answer_button: Button
var wrong_answer_button: Button
var is_answer_chosen: bool = false

func _input(event: InputEvent) -> void:
	if is_answer_chosen and event.is_action_pressed("close_question_screen"):
		requested_close.emit()

func setup(question: Question) -> void:
	_set_labels(question.question_string,
	 question.left_answer_string,
	 question.right_answer_string)
	_set_buttons(question.correct_answer)

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
	correct_answer_button.set_as_correct_answer(_on_correct_answer_button_pressed)
	wrong_answer_button.set_as_wrong_answer(_on_wrong_answer_button_pressed)

func _on_correct_answer_button_pressed() -> void:
	correct_answer_chosen.emit()
	is_answer_chosen = true

func _on_wrong_answer_button_pressed() -> void:
	correct_answer_button.reveal_answer()
	wrong_answer_chosen.emit()
	is_answer_chosen = true
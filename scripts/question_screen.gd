class_name QuestionScreen extends GameScreen

@onready var question_label: Label = $QuestionLabel
@onready var left_answer_button: Button = $LeftAnswerButton
@onready var right_answer_button: Button = $RightAnswerButton

func setup(question: Question, background_color: Color) -> void:
	set_labels(question.question_string,
	 question.left_answer_string,
	 question.right_answer_string)
	set_buttons()
	change_background_color(background_color)

func set_labels(question_string: String,
				left_button_string: String,
				right_button_string: String) -> void:
	question_label.text = question_string
	left_answer_button.text = left_button_string
	right_answer_button.text = right_button_string

func set_buttons() -> void:
	pass
extends GameScreen

@onready var question_label: Label = $QuestionLabel
@onready var left_answer_button: Button = $AnswerButtons/LeftAnswerButton
@onready var right_answer_button: Button = $AnswerButtons/RightAnswerButton

func setup(question: Question):
	set_labels(question.question_string,
	 question.left_answer_string,
	 question.right_answer_string)
	set_buttons()
	set_background()

func set_labels(question_string: String,
				left_button_string: String,
				right_button_string: String) -> void:
	question_label.text = question_string
	left_answer_button.text = left_button_string
	right_answer_button.text = right_button_string

func set_buttons():
	pass

func set_background():
	pass

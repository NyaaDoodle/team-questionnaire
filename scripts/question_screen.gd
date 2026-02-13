extends GameScreen

enum CorrectAnswerChoice { LeftSide, RightSide }

@onready var question_label: Label = $QuestionLabel
@onready var left_answer_button: Button = $AnswerButtons/LeftAnswerButton
@onready var right_answer_button: Button = $AnswerButtons/RightAnswerButton

func setup(question_string: String,
		   left_button_string: String,
		   right_button_string: String,
		   correct_answer_choice: CorrectAnswerChoice):
	question_label.text = question_string
	left_answer_button.text = left_button_string
	right_answer_button.text = right_button_string
	match correct_answer_choice:
		CorrectAnswerChoice.LeftSide:
			pass
		CorrectAnswerChoice.RightSide:
			pass

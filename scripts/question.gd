class_name Question extends Resource

enum AnswerChoice { LeftAnswer, RightAnswer }

@export var question_string: String = ""
@export var left_answer_string: String = ""
@export var right_answer_string: String = ""
@export var correct_answer: AnswerChoice = AnswerChoice.LeftAnswer

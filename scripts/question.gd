class_name Question

enum AnswerChoice { LeftAnswer, RightAnswer }

var question_string: String
var left_answer_string: String
var right_answer_string: String
var correct_answer: AnswerChoice

func _init(input_question_string: String,
           input_left_answer_string: String,
           input_right_answer_string: String,
           input_correct_answer: AnswerChoice):
    question_string = input_question_string
    left_answer_string = input_left_answer_string
    right_answer_string = input_right_answer_string
    correct_answer = input_correct_answer

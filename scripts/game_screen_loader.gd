class_name ScreenLoader extends Node

@export var initial_scene: PackedScene
@export var result_screen_scene: PackedScene
@export var question_screen_scene: PackedScene

var current_screen: GameScreen

func _ready() -> void:
	show_result_screen(0, 0)

func show_result_screen(left_hand_score: int, right_hand_score: int) -> void:
	current_screen = result_screen_scene.instantiate()
	current_screen.request_close.connect(close_current_screen)
	add_child(current_screen)
	current_screen.setup(left_hand_score, right_hand_score)

func close_current_screen() -> void:
	if is_instance_valid(current_screen):
		current_screen.close()

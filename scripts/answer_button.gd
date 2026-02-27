class_name AnswerButton extends Button

@onready var _audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var _correct_answer_sfx: AudioStream
@export var _wrong_answer_sfx: AudioStream
var _color : Color

func set_as_correct_answer(on_pressed_callable: Callable) -> void:
	_setup(Color.GREEN, _correct_answer_sfx, on_pressed_callable)

func set_as_wrong_answer(on_pressed_callable: Callable) -> void:
	_setup(Color.RED, _wrong_answer_sfx, on_pressed_callable)

func _setup(reveal_color: Color, reveal_sfx: AudioStream, on_pressed_callable: Callable):
	_color = reveal_color
	_audio_player.stream = reveal_sfx
	pressed.connect(on_pressed_callable)

func _disable_button() -> void:
	disabled = true

func _play_sound() -> void:
	_audio_player.play()

func _change_color() -> void:
	var stylebox = get_theme_stylebox("normal").duplicate()
	stylebox.bg_color = _color
	add_theme_stylebox_override("normal", stylebox)
	add_theme_stylebox_override("pressed", stylebox)
	add_theme_stylebox_override("hover", stylebox)
	add_theme_stylebox_override("disabled", stylebox)
	add_theme_stylebox_override("focus", stylebox)

func reveal_answer() -> void:
	_disable_button()
	_change_color()

func _on_pressed() -> void:
	_play_sound()
	reveal_answer()
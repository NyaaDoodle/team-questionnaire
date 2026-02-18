class_name BackgroundPanel extends Panel

@export var initial_color: Color
var style_box: StyleBoxFlat

func _ready() -> void:
	style_box = StyleBoxFlat.new()
	style_box.bg_color = initial_color
	add_theme_stylebox_override("panel", style_box)

func change_color(color: Color) -> void:
	style_box.bg_color = color
	add_theme_stylebox_override("panel", style_box)

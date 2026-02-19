class_name GameScreen extends Control

@onready var background: ColorRect = $Background

signal requested_close

func change_background_color(color: Color) -> void:
	background.color = color

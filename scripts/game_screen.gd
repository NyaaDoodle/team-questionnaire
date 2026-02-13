class_name GameScreen extends Node

signal request_close

func close() -> void:
	queue_free()

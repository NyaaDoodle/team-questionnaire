class_name ScreenLoader extends Node

@export var initial_scene: PackedScene

func _ready() -> void:
	var instance = initial_scene.instantiate()
	add_child(instance)

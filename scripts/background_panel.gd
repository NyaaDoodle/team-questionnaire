class_name BackgroundPanel extends Control

enum ShowState { Hidden, Half, Full }

@onready var _static_panel: ColorRect = $StaticPanel
@onready var _left_panel: ColorRect = $LeftPanel
@onready var _right_panel: ColorRect = $RightPanel

var _static_style_box: StyleBoxFlat = StyleBoxFlat.new()
var _left_style_box: StyleBoxFlat = StyleBoxFlat.new()
var _right_style_box: StyleBoxFlat = StyleBoxFlat.new()

func _ready() -> void:
    _static_panel.add_theme_stylebox_override("panel", _static_style_box)
    _left_panel.add_theme_stylebox_override("panel", _left_style_box)
    _right_panel.add_theme_stylebox_override("panel", _right_style_box)

func get_slide_tween() -> Tween:
    var tween = create_tween()
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.set_ease(Tween.EASE_OUT)
    return tween

func tween_slide_left_panel(show_state: ShowState) -> void:
    var destination_ratio: float = 0.0
    match show_state:
        ShowState.Hidden:
            destination_ratio = 0
        ShowState.Half:
            destination_ratio = 0.5
        ShowState.Full:
            destination_ratio = 1
    var tween = get_slide_tween()
    tween.tween_property(_left_panel, "anchor_right", destination_ratio, 0.5)

func tween_slide_right_panel(show_state: ShowState) -> void:
    var destination_ratio: float = 0.0
    match show_state:
        ShowState.Hidden:
            destination_ratio = 1
        ShowState.Half:
            destination_ratio = 0.5
        ShowState.Full:
            destination_ratio = 0
    var tween = get_slide_tween()
    tween.tween_property(_right_panel, "anchor_left", destination_ratio, 0.5)

func slide_switch_to_left_panel(left_panel_color: Color) -> void:
    change_left_panel_color(left_panel_color)
    tween_slide_right_panel(ShowState.Hidden)
    tween_slide_left_panel(ShowState.Full)
    
func slide_switch_to_right_panel(right_panel_color: Color) -> void:
    change_right_panel_color(right_panel_color)
    tween_slide_left_panel(ShowState.Hidden)
    tween_slide_right_panel(ShowState.Full)

func slide_switch_to_halves(left_panel_color: Color, right_panel_color: Color) -> void:
    change_left_panel_color(left_panel_color)
    change_right_panel_color(right_panel_color)
    tween_slide_left_panel(ShowState.Half)
    tween_slide_right_panel(ShowState.Half)

func instant_switch_to_static_panel(static_panel_color: Color) -> void:
    change_static_panel_color(static_panel_color)
    _left_panel.anchor_right = 0.0
    _right_panel.anchor_left = 1.0

func change_style_box_color(style_box: StyleBoxFlat, color: Color) -> void:
    style_box.bg_color = color

func change_static_panel_color(color: Color) -> void:
    change_style_box_color(_static_style_box, color)

func change_left_panel_color(color: Color) -> void:
    change_style_box_color(_left_style_box, color)

func change_right_panel_color(color: Color) -> void:
    change_style_box_color(_right_style_box, color)    



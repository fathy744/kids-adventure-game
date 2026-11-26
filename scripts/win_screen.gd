extends CanvasLayer
## Win screen shown after the quiz. Buttons go to map or replay the level.

@onready var stars_label: Label = $Panel/VBox/StarsLabel
@onready var map_button: Button = $Panel/VBox/MapButton
@onready var replay_button: Button = $Panel/VBox/ReplayButton


func _ready() -> void:
	visible = false
	map_button.pressed.connect(_on_map_pressed)
	replay_button.pressed.connect(_on_replay_pressed)


func show_win(stars: int, total: int) -> void:
	stars_label.text = "جمعت %d من %d نجوم!" % [stars, total]
	visible = true


func _on_map_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()

extends Control
## Main menu: start, hero choice entry, quit (desktop only).

@onready var start_button: Button = $StartButton
@onready var quit_button: Button = $QuitButton
@onready var progress_label: Label = $ProgressLabel


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	if OS.has_feature("web"):
		quit_button.visible = false
	if GameState.completed_levels.size() > 0:
		progress_label.text = "أهلًا بيك تاني يا بطل! كمل المغامرة."
	else:
		progress_label.text = "مغامرة جديدة مستنياك!"


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/HeroSelect.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()

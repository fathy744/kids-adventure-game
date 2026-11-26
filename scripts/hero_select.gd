extends Control
## Hero selection: rabbit (أرنوب), robot (روبو), stickman (ستيكو).

@onready var rabbit_button: Button = $HeroRow/RabbitBox/RabbitButton
@onready var robot_button: Button = $HeroRow/RobotBox/RobotButton
@onready var stickman_button: Button = $HeroRow/StickmanBox/StickmanButton
@onready var back_button: Button = $BackButton
@onready var chosen_label: Label = $ChosenLabel


func _ready() -> void:
	rabbit_button.pressed.connect(func() -> void: _choose("rabbit"))
	robot_button.pressed.connect(func() -> void: _choose("robot"))
	stickman_button.pressed.connect(func() -> void: _choose("stickman"))
	back_button.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))
	chosen_label.text = "البطل الحالي: " + GameState.hero_display_name(GameState.selected_hero)


func _choose(hero_id: String) -> void:
	GameState.select_hero(hero_id)
	get_tree().change_scene_to_file("res://scenes/WorldMap.tscn")

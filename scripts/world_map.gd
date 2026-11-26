extends Control
## World map: 5 worlds. Only Forest Level 1 is playable in v0.1.0;
## other worlds are locked with friendly "coming soon" text.

@onready var forest_button: Button = $WorldList/ForestButton
@onready var sea_button: Button = $WorldList/SeaButton
@onready var desert_button: Button = $WorldList/DesertButton
@onready var space_button: Button = $WorldList/SpaceButton
@onready var castle_button: Button = $WorldList/CastleButton
@onready var back_button: Button = $BackButton
@onready var hero_label: Label = $HeroLabel


func _ready() -> void:
	hero_label.text = "البطل: " + GameState.hero_display_name(GameState.selected_hero)
	forest_button.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://scenes/Level01.tscn"))
	back_button.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://scenes/HeroSelect.tscn"))

	sea_button.disabled = true
	desert_button.disabled = true
	space_button.disabled = true
	castle_button.disabled = true

	if GameState.is_completed("forest_1"):
		forest_button.text = "الغابة - المرحلة 1 (خلصتها! العب تاني)"
	else:
		forest_button.text = "الغابة - المرحلة 1 (العب دلوقتي)"

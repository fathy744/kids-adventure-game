extends Node2D
## Level 01 (Forest): collect 5 stars, reach treasure, answer quiz, win.

const LEVEL_ID := "forest_1"

var stars_collected: int = 0
var stars_total: int = 5
var _quiz_open: bool = false

@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD
@onready var quiz: CanvasLayer = $QuizPopup
@onready var win: CanvasLayer = $WinScreen
@onready var treasure: Area2D = $Treasure
@onready var left_button: Button = $TouchControls/LeftButton
@onready var right_button: Button = $TouchControls/RightButton
@onready var jump_button: Button = $TouchControls/JumpButton
@onready var menu_button: Button = $HUD/MenuButton


func _ready() -> void:
	var stars := get_tree().get_nodes_in_group("stars")
	stars_total = stars.size()
	for s in stars:
		if s.has_signal("collected"):
			s.collected.connect(_on_star_collected)
	treasure.reached.connect(_on_treasure_reached)
	quiz.answered_correct.connect(_on_quiz_correct)
	hud.set_stars(0, stars_total)

	left_button.button_down.connect(func() -> void: player.touch_left = true)
	left_button.button_up.connect(func() -> void: player.touch_left = false)
	right_button.button_down.connect(func() -> void: player.touch_right = true)
	right_button.button_up.connect(func() -> void: player.touch_right = false)
	jump_button.button_down.connect(func() -> void: player.queue_touch_jump())
	menu_button.pressed.connect(func() -> void: get_tree().change_scene_to_file("res://scenes/WorldMap.tscn"))


func _on_star_collected(_star: Area2D) -> void:
	stars_collected += 1
	hud.set_stars(stars_collected, stars_total)
	if stars_collected >= stars_total:
		hud.show_message("جمعت كل النجوم! روح للكنز!")
	else:
		hud.show_message("برافو! نجمة جديدة!")


func _on_treasure_reached(_treasure: Area2D) -> void:
	if _quiz_open:
		return
	_quiz_open = true
	player.controls_enabled = false
	player.velocity = Vector2.ZERO
	if stars_collected < stars_total:
		hud.show_message("وصلت للكنز! جاوب السؤال عشان تفتحه.")
	else:
		hud.show_message("وصلت للكنز ومعاك كل النجوم!")
	quiz.show_quiz()


func _on_quiz_correct() -> void:
	_quiz_open = false
	GameState.complete_level(LEVEL_ID, stars_collected)
	win.show_win(stars_collected, stars_total)

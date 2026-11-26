extends CanvasLayer
## In-level HUD: star counter + short encouraging message.

@onready var star_label: Label = $StarLabel
@onready var message_label: Label = $MessageLabel
@onready var hero_label: Label = $HeroLabel


func _ready() -> void:
	hero_label.text = GameState.hero_display_name(GameState.selected_hero)
	set_stars(0, 5)
	show_message("اجمع النجوم ووصل للكنز!")


func set_stars(count: int, total: int) -> void:
	star_label.text = "النجوم: %d / %d" % [count, total]


func show_message(text: String) -> void:
	message_label.text = text

extends Node
## Global game state: selected hero, progress, save/load to user://save.json.
## No network, no data collection. Local save only.

const SAVE_PATH := "user://save.json"
const HEROES := ["rabbit", "robot", "stickman"]

var selected_hero: String = "rabbit"
var stars_total: int = 0
var completed_levels: Array = []
var unlocked_level: int = 1


func _ready() -> void:
	load_game()


func hero_display_name(hero_id: String) -> String:
	match hero_id:
		"rabbit":
			return "أرنوب"
		"robot":
			return "روبو"
		"stickman":
			return "ستيكو"
	return "أرنوب"


func select_hero(hero_id: String) -> void:
	if HEROES.has(hero_id):
		selected_hero = hero_id
		save_game()


func complete_level(level_id: String, stars: int) -> void:
	if not completed_levels.has(level_id):
		completed_levels.append(level_id)
	stars_total = maxi(stars_total, stars)
	unlocked_level = maxi(unlocked_level, 2)
	save_game()


func is_completed(level_id: String) -> bool:
	return completed_levels.has(level_id)


func save_game() -> void:
	var data := {
		"selected_hero": selected_hero,
		"stars_total": stars_total,
		"completed_levels": completed_levels,
		"unlocked_level": unlocked_level,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_warning("Could not open save file for writing.")
		return
	file.store_string(JSON.stringify(data))
	file.close()


func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return
	var text := file.get_as_text()
	file.close()
	var parsed: Variant = JSON.parse_string(text)
	if parsed is Dictionary:
		var data: Dictionary = parsed
		selected_hero = str(data.get("selected_hero", "rabbit"))
		if not HEROES.has(selected_hero):
			selected_hero = "rabbit"
		stars_total = int(data.get("stars_total", 0))
		completed_levels = data.get("completed_levels", [])
		unlocked_level = int(data.get("unlocked_level", 1))

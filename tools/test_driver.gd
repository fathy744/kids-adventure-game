extends Node
## Headless gameplay smoke test (not part of the shipped game flow).
## Run: godot --headless --path . res://tools/TestDriver.tscn --quit-after 900
## Prints TEST_PASS and quits 0 on success, TEST_FAIL + quit 1 otherwise.

var _failed: bool = false


func _fail(msg: String) -> void:
	_failed = true
	push_error("TEST_FAIL: " + msg)
	print("TEST_FAIL: " + msg)


func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame

	var packed: PackedScene = load("res://scenes/Level01.tscn") as PackedScene
	if packed == null:
		_fail("Level01 scene failed to load")
		get_tree().quit(1)
		return
	var level: Node = packed.instantiate()
	add_child(level)

	for i in range(10):
		await get_tree().physics_frame

	var player: Node2D = level.get_node_or_null("Player") as Node2D
	var star1: Node2D = level.get_node_or_null("Star1") as Node2D
	var treasure: Node2D = level.get_node_or_null("Treasure") as Node2D
	var quiz: CanvasLayer = level.get_node_or_null("QuizPopup") as CanvasLayer
	var win: CanvasLayer = level.get_node_or_null("WinScreen") as CanvasLayer
	if player == null or star1 == null or treasure == null or quiz == null or win == null:
		_fail("missing expected Level01 nodes")
		get_tree().quit(1)
		return

	# Collect first star by teleporting the player onto it.
	player.global_position = star1.global_position
	if player is CharacterBody2D:
		(player as CharacterBody2D).velocity = Vector2.ZERO
	for i in range(15):
		await get_tree().physics_frame
	var collected: int = int(level.get("stars_collected"))
	if collected != 1:
		_fail("expected stars_collected=1, got %d" % collected)
	else:
		print("TEST_OK star collected")

	# Reach treasure -> quiz must open.
	player.global_position = treasure.global_position
	if player is CharacterBody2D:
		(player as CharacterBody2D).velocity = Vector2.ZERO
	for i in range(15):
		await get_tree().physics_frame
	if not quiz.visible:
		_fail("quiz did not open at treasure")
	else:
		print("TEST_OK quiz opened")

	# Answer correctly (rabbit) -> win screen + save flag.
	var rabbit_button: Button = quiz.get_node_or_null("Panel/VBox/AnswerRabbit") as Button
	if rabbit_button == null:
		_fail("rabbit answer button missing")
	else:
		rabbit_button.pressed.emit()
		for i in range(5):
			await get_tree().process_frame
		if not win.visible:
			_fail("win screen did not show after correct answer")
		else:
			print("TEST_OK win screen shown")
		if not GameState.is_completed("forest_1"):
			_fail("save flag forest_1 not completed")
		else:
			print("TEST_OK save completed flag")

	if _failed:
		get_tree().quit(1)
	else:
		print("TEST_PASS")
		get_tree().quit(0)

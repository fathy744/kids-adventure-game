extends CharacterBody2D
## Kid-friendly platformer hero: run + jump, keyboard arrows/WASD/space + touch buttons.

const SPEED := 320.0
const JUMP_VELOCITY := -620.0
const START_POSITION := Vector2(150, 640)

var touch_left: bool = false
var touch_right: bool = false
var touch_jump_queued: bool = false
var controls_enabled: bool = true

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity", 980.0)

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	_apply_hero_texture()


func _apply_hero_texture() -> void:
	var path := "res://assets/sprites/hero_rabbit.png"
	match GameState.selected_hero:
		"robot":
			path = "res://assets/sprites/hero_robot.png"
		"stickman":
			path = "res://assets/sprites/hero_stickman.png"
		_:
			path = "res://assets/sprites/hero_rabbit.png"
	var tex: Texture2D = load(path) as Texture2D
	if tex != null:
		sprite.texture = tex


func queue_touch_jump() -> void:
	touch_jump_queued = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _gravity * delta

	var direction := 0.0
	if controls_enabled:
		direction = Input.get_axis("move_left", "move_right")
		if touch_left:
			direction -= 1.0
		if touch_right:
			direction += 1.0
		direction = clampf(direction, -1.0, 1.0)

		var want_jump := Input.is_action_just_pressed("jump") or touch_jump_queued
		if want_jump and is_on_floor():
			velocity.y = JUMP_VELOCITY
		touch_jump_queued = false
	else:
		touch_jump_queued = false

	if direction != 0.0:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)

	move_and_slide()

	# Safety respawn (no harsh game over for kids).
	if global_position.y > 950.0:
		global_position = START_POSITION
		velocity = Vector2.ZERO

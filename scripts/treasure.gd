extends Area2D
## Treasure goal at the end of the level. Triggers the quiz once.

signal reached(treasure: Area2D)

var _triggered: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if _triggered:
		return
	if body.is_in_group("player"):
		_triggered = true
		reached.emit(self)


func reset_trigger() -> void:
	_triggered = false

extends Area2D
## Collectible star. Emits collected once, then frees itself.

signal collected(star: Area2D)

var _base_y: float = 0.0
var _time: float = 0.0
var _taken: bool = false


func _ready() -> void:
	_base_y = position.y
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	_time += delta
	position.y = _base_y + sin(_time * 2.5) * 8.0
	rotation = sin(_time * 1.5) * 0.15


func _on_body_entered(body: Node2D) -> void:
	if _taken:
		return
	if body.is_in_group("player"):
		_taken = true
		collected.emit(self)
		queue_free()

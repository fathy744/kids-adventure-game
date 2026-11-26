extends CanvasLayer
## Educational quiz popup. Correct answer opens the treasure (win).
## Wrong answers lose a heart; hearts refill instead of harsh game over.

signal answered_correct

const MAX_HEARTS := 3

var hearts: int = MAX_HEARTS

@onready var hearts_label: Label = $Panel/VBox/HeartsLabel
@onready var feedback_label: Label = $Panel/VBox/FeedbackLabel
@onready var rabbit_button: Button = $Panel/VBox/AnswerRabbit
@onready var cat_button: Button = $Panel/VBox/AnswerCat
@onready var dog_button: Button = $Panel/VBox/AnswerDog


func _ready() -> void:
	visible = false
	rabbit_button.pressed.connect(_on_correct)
	cat_button.pressed.connect(_on_wrong)
	dog_button.pressed.connect(_on_wrong)
	_update_hearts()


func show_quiz() -> void:
	hearts = MAX_HEARTS
	feedback_label.text = "اختار الإجابة الصح!"
	_update_hearts()
	visible = true


func hide_quiz() -> void:
	visible = false


func _update_hearts() -> void:
	hearts_label.text = "القلوب: %d" % hearts


func _on_correct() -> void:
	feedback_label.text = "برافو! إجابة صح!"
	hide_quiz()
	answered_correct.emit()


func _on_wrong() -> void:
	hearts -= 1
	if hearts <= 0:
		hearts = MAX_HEARTS
		feedback_label.text = "ولا يهمك! حاول تاني، فكر في الجزر."
	else:
		feedback_label.text = "قربت! حاول تاني."
	_update_hearts()

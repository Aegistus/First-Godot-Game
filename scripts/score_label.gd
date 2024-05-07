extends Label

@onready var score_label = $"."

func _ready():
	GameManager.score_change.connect(update_score)
	
func update_score(newScore):
	print("Updating score label")
	score_label.text = str(newScore)

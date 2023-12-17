extends Area2D

var score : int = 500

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		body.sumScore(score)
		body.takeSpecialArrow("Fuego")
		queue_free()

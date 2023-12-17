extends Area2D

signal signalHealth(health:int)
signal signalScore(score:int)

var health : int = 20
var score : int = 200

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		body.sumScore(score)
		body.sumHealth(health)
		queue_free()

extends Node

var nextlevel = "res://Pantallas/main_menu.tscn"
var scoreA = 5000
var scoreB = 2500

func _on_magic_fruit_body_entered(body: Node2D) -> void:
	body.finishedLevel(nextlevel, scoreA, scoreB)


func _on_game_over_1_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)

extends Label

var scr := 0

var score := 0
func _ready() -> void:
	text = str(scr)
	var scoretotal = get_tree().get_nodes_in_group("flechaFuego") + get_tree().get_nodes_in_group("frutas") + get_tree().get_nodes_in_group("flechaHielo") + get_tree().get_nodes_in_group("flechaElectro") + get_tree().get_nodes_in_group("enemigos")
	for score in scoretotal:
		if score.is_in_group("flechaFuego"):
			score.connect("signalScore", update_score)
		if score.is_in_group("frutas"):
			score.connect("signalScore", update_score)
		if score.is_in_group("flechaHielo"):
			score.connect("signalScore", update_score)
		if score.is_in_group("flechaElectro"):
			score.connect("signalScore", update_score)
		if score.is_in_group("enemigos"):
			score.connect("signalScoreEnemy", update_score)

func update_score(updateScore):
	scr += updateScore
	text = str(scr)

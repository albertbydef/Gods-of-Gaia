extends Label

#Connexió als nodes flechaHieloColeccionabe que el player recolleix

func _ready() -> void:
	text = str(Global.flechas_hielo)
	var iarrow = get_tree().get_nodes_in_group("flechaHielo")
	for flecha in iarrow:
		flecha.connect("signalIceArrow", sumar_iceArrow)

func sumar_iceArrow(arrow):
	Global.flechas_hielo += arrow
	text = str(Global.flechas_hielo)

func _on_player_ice_shot(arrow) -> void:
	Global.flechas_hielo -= arrow
	text = str(Global.flechas_hielo)

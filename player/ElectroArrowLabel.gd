extends Label

#Connexió als nodes flechaElectroColeccionabe que el player recolleix

func _ready() -> void:
	text = str(Global.flechas_electro)
	var earrow = get_tree().get_nodes_in_group("flechaElectro")
	for flecha in earrow:
		flecha.connect("signalElectroArrow", sumar_electroArrow)

func sumar_electroArrow(arrow):
	Global.flechas_electro += arrow
	text = str(Global.flechas_electro)

func _on_player_electro_shot(arrow) -> void:
	Global.flechas_electro -= arrow
	text = str(Global.flechas_electro)

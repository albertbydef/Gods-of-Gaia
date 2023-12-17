extends Label
#Connexió als nodes flechaFuegoColeccionabe que el layer recolleix

func _ready() -> void:
	text = str(Global.flechas_fuego)
	var farrow = get_tree().get_nodes_in_group("flechaFuego")
	for flecha in farrow:
		flecha.connect("signalFireArrow", sumar_fireArrow)
			
	

func sumar_fireArrow(arrow):
	Global.flechas_fuego += arrow
	text = str(Global.flechas_fuego)

func _on_player_fire_shot(arrow) -> void:
	Global.flechas_fuego -= arrow
	text = str(Global.flechas_fuego)

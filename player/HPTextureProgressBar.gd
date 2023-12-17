extends TextureProgressBar
signal signalHurt
signal signalDead

func _ready() -> void:
	max_value = Global.maxHealth
	value = Global.health
	#Connexió fruites
	var fruit = get_tree().get_nodes_in_group("frutas")
	for fruita in fruit:
		fruita.connect("signalHealth", restore_health)
	#Connexió Enemics
	var enemies = get_tree().get_nodes_in_group("enemigos")
	for enemic in enemies:
		enemic.connect("signalDamage", damage_player)

#Funció que restaura vida
func restore_health(restoreHealth):
	value += restoreHealth
#Funció que lleva vida
func damage_player(damage):
	value -= damage
	if value <= 0:
		emit_signal("signalDead")
	else:
		
		emit_signal("signalHurt")

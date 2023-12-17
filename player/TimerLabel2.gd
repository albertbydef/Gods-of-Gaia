extends Label

var time : float = 0
#Cronometre
func _process(delta: float) -> void:
	time += delta
	var timesec = "%d" % [time]
	text = timesec

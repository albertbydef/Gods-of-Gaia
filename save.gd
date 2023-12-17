extends Node

const SAVEFILE ="user://SAVEFILE.save"
var game_data = {
	"FLECHASHIELO" = 0,
	"FLECHASFUEGO" = 0,
	"FLECHASELECTRO" = 0,
	"HPMAX" = 100,
	"HP" = 100,
	"LEVEL1" = false,
	"LEVEL2" = true,
	"LEVEL3" = true,
	"LEVEL4" = true,
	"LEVEL5" = true,
	"LEVEL6" = true,
	"LEVEL7" = true,
	"LEVEL8" = true
	}
	

func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null

func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
	file = null

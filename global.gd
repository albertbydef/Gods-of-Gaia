extends Node

var scorelvl1
var frutas
var health := 100
var maxHealth := 100
var flechas_fuego := 0
var flechas_hielo := 0
var flechas_electro := 0

#Desactivació nivells:
var lvl1 := false
var lvl2 := true
var lvl3 := true
var lvl4 := true
var lvl5 := true
var lvl6 := true
var lvl7 := true
var lvl8 := true

func load_data():
	health = Save.game_data.HP
	maxHealth = Save.game_data.HPMAX
	flechas_fuego = Save.game_data.FLECHASFUEGO
	flechas_hielo = Save.game_data.FLECHASHIELO
	flechas_electro = Save.game_data.FLECHASELECTRO
	lvl1 = Save.game_data.LEVEL1
	lvl2 = Save.game_data.LEVEL2
	lvl3 = Save.game_data.LEVEL3
	lvl4 = Save.game_data.LEVEL4
	lvl5 = Save.game_data.LEVEL5
	lvl6 = Save.game_data.LEVEL6
	lvl7 = Save.game_data.LEVEL7
	lvl8 = Save.game_data.LEVEL8

func save_data():
	Save.game_data.HP = health
	Save.game_data.HPMAX = maxHealth
	Save.game_data.FLECHASFUEGO = flechas_fuego
	Save.game_data.FLECHASHIELO = flechas_hielo
	Save.game_data.FLECHASELECTRO = flechas_electro
	Save.game_data.LEVEL1 = lvl1
	Save.game_data.LEVEL2 = lvl2
	Save.game_data.LEVEL3 = lvl3
	Save.game_data.LEVEL4 = lvl4
	Save.game_data.LEVEL5 = lvl5
	Save.game_data.LEVEL6 = lvl6
	Save.game_data.LEVEL7 = lvl7
	Save.game_data.LEVEL8 = lvl8

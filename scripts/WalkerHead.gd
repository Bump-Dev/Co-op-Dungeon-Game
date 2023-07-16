extends Node2D

@onready var tileMap := $"../TileMap"

const MAP_SIZE := 128
const WALKER_UNIT = preload("res://scenes/WalkerUnit.tscn")
const WALKER_UNITS := 10

var player_spawned:bool

func _ready():
	var coords:Array
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			coords.append(Vector2(x-MAP_SIZE/2,y-MAP_SIZE/2))
	tileMap.set_cells_terrain_connect(0,coords,0,0)

	for walker in WALKER_UNITS:
		var w = WALKER_UNIT.instantiate()
		w.global_position = global_position
		add_child(w)
		w.calculate_path()

func _input(event):
	if event.is_action_pressed("ui_focus_next"):
		get_tree().reload_current_scene()

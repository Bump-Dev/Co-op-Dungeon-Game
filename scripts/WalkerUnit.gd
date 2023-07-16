extends Node2D

@onready var Head = get_parent()

enum DIRS {LEFT,RIGHT,UP,DOWN}

const TILE_SIZE := 32
const PLAYER = preload("res://scenes/Player.tscn")

var chance_to_spawn_player := 0.005
var chance_to_walk_straight := 0.01
var straight_walk_amt := 5
var is_straight_walker:bool
var path_length := 300

func calculate_path():
	is_straight_walker = randi() % 2
	var path_steps := []
	for i in path_length:
		var step := randi() % DIRS.size()
		var prev_dir := -1
		path_steps.append(step)
	
		if prev_dir != -1:
			if step == prev_dir:
				if step < 3:
					step += 1
				else:
					step -= 1 # basically not same direciton
		prev_dir = step
	
		if randf() < chance_to_walk_straight:
			for j in straight_walk_amt:
				path_steps.append(step)
	
	var location:Vector2 = get_parent().global_position
	var tm:TileMap = get_parent().tileMap
	
	for dir in path_steps:		
		var modifier_direction:Vector2
		match dir:
			0:
				modifier_direction = Vector2.LEFT * TILE_SIZE
			1:
				modifier_direction = Vector2.RIGHT * TILE_SIZE
			2:
				modifier_direction = Vector2.UP * TILE_SIZE
			3:
				modifier_direction = Vector2.DOWN * TILE_SIZE
		location += modifier_direction
		var map_coords := tm.local_to_map(location)
		tm.set_cells_terrain_connect(0,[map_coords],0,1)
		
		if !Head.player_spawned:
			if randf() < chance_to_spawn_player:
				Head.player_spawned = true
				var p = PLAYER.instantiate()
				Head.get_parent().get_node("TileMap").add_child(p)
				p.global_position = location

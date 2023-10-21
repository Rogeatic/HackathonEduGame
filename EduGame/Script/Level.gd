extends Node2D

# Node references
@onready var tilemap = $TileMap
@onready var player = $Player  

# Dimension values
const initial_width = 51
const initial_height = 41
var map_width = initial_width
var map_height = initial_height 
var map_offset = 0

var num_enemies = 10
var rng = RandomNumberGenerator.new()

# Tilemap constants
const BACKGROUND_TILE_ID = 0
const UNBREAKABLE_TILE_ID = 2
const BACKGROUND_TILE_LAYER = 0
const UNBREAKABLE_TILE_LAYER = 2

var visited = {}
var stack = []

var start_position = Vector2i(2, 2)
var end_position = Vector2i(2, 2)

func _ready():
	rng.randomize()
	generate_map()

func spawn_enemies():
	# Load the enemy scene
	var enemy_scene = preload("res://Scenes/enemy.tscn")  # Replace with your actual enemy scene path
	# Get all background tiles
	var background_tiles = get_background_tiles()
	# Shuffle the list of tiles to make the spawning locations random
	background_tiles = shuffle_array(background_tiles)
	# Determine the number of enemies to spawn
	var enemies_to_spawn = min(num_enemies, background_tiles.size())
	
	# Spawn the enemies
	for i in range(enemies_to_spawn):
		var enemy_instance = enemy_scene.instance()
		enemy_instance.position = background_tiles[i]  # Centering the enemy within the tile cell
		add_child(enemy_instance)
		enemy_instance.z_index = 1

# Map Generation
func generate_map():
	generate_full_walls()
	carve_maze(start_position)
	generate_background()

func generate_full_walls():
	for x in range(map_width):
		for y in range(map_height):
			tilemap.set_cell(UNBREAKABLE_TILE_LAYER, Vector2i(x, y + map_offset), UNBREAKABLE_TILE_ID, Vector2i(0, 0), 0)

func carve_maze(position):
	visited[position] = true
	end_position = position  # Update the end position as you carve
	var directions = [Vector2i(0, -2), Vector2i(2, 0), Vector2i(0, 2), Vector2i(-2, 0)] # North, East, South, West
	directions = shuffle_array(directions)
	
	for dir in directions:
		var next_position = position + dir
		if is_valid_cell(next_position) and next_position not in visited:
			var mid_position = position + dir/2
			tilemap.set_cell(UNBREAKABLE_TILE_LAYER, mid_position + Vector2i(0, map_offset), -1, Vector2i(0, 0), 0)
			tilemap.set_cell(UNBREAKABLE_TILE_LAYER, next_position + Vector2i(0, map_offset), -1, Vector2i(0, 0), 0)
			stack.append(position)
			carve_maze(next_position)
		elif stack:
			carve_maze(stack.pop_front())

func is_valid_cell(position):
	return position.x > 0 and position.x < map_width and position.y > 0 and position.y < map_height

func generate_background():
	for x in range(map_width):
		for y in range(map_height):
			var cell_coords = Vector2i(x, y + map_offset)
			if is_cell_empty(UNBREAKABLE_TILE_LAYER, cell_coords):
				tilemap.set_cell(BACKGROUND_TILE_LAYER, cell_coords, BACKGROUND_TILE_ID, Vector2i(0, 0), 0)

func get_background_tiles():
	var tiles = []
	for x in range(map_width):
		for y in range(map_height):
			var cell_coords = Vector2i(x, y + map_offset)
			if tilemap.get_cell(BACKGROUND_TILE_LAYER, cell_coords.x, cell_coords.y) == BACKGROUND_TILE_ID:
				tiles.append(cell_coords)
	return tiles

func is_cell_empty(layer, coords):
	var data = tilemap.get_cell_tile_data(layer, coords)
	return data == null

func shuffle_array(arr):
	var arr_copy = arr.duplicate()
	for i in range(arr_copy.size() - 1, 0, -1):
		var j = rng.randi() % (i + 1)
		var temp = arr_copy[i]
		arr_copy[i] = arr_copy[j]
		arr_copy[j] = temp
	return arr_copy




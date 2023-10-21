extends TileMap

# Assuming 0 is a wall and 1 is a path in your TileSet
enum TileType {
	WALL = 0,
	PATH = 1
}

var maze_width = 21
var maze_height = 21
var start_position = Vector2(10, 10)  # Center for a 21x21 maze

var stack = []
var visited_cells = []

func _ready():
	randomize()  # For random maze generation each time
	initialize_maze()
	generate_maze(start_position)

func initialize_maze():
	for x in range(maze_width):
		for y in range(maze_height):
			set_cellv(Vector2(x, y), TileType.WALL)
	visited_cells.append(start_position)
	set_cellv(start_position, TileType.PATH)

func generate_maze(position):
	var current_position = position
	while visited_cells.size() < (maze_width * maze_height) / 2:  # Only half the cells will be paths
		var neighbors = get_unvisited_neighbors(current_position)
		if neighbors.size() > 0:
			var chosen_neighbor = neighbors[randi() % neighbors.size()]
			carve_path(current_position, chosen_neighbor)
			stack.append(current_position)
			current_position = chosen_neighbor
			visited_cells.append(chosen_neighbor)
			set_cellv(chosen_neighbor, TileType.PATH)
		elif stack.size() > 0:
			current_position = stack.pop_back()

func get_unvisited_neighbors(position):
	var neighbors = []
	var directions = [Vector2(0, 2), Vector2(0, -2), Vector2(2, 0), Vector2(-2, 0)]
	for direction in directions:
		var neighbor_position = position + direction
		if neighbor_position.x >= 0 && neighbor_position.x < maze_width && neighbor_position.y >= 0 && neighbor_position.y < maze_height:
			if neighbor_position not in visited_cells:
				neighbors.append(neighbor_position)
	return neighbors

func carve_path(from_position, to_position):
	var path_position = (from_position + to_position) / 2
	set_cellv(path_position, TileType.PATH)

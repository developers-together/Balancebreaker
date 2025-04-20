extends Node2D

@export var roomWidth := 10  # in tiles
@export var roomHeight := 8  # in tiles
@export var MAX_ROOMS := 10

# Each cell in the layout grid can be empty or have a room
const GRID_SIZE := 10  # 10x10 layout grid to place rooms
var layout_grid = []
var rooms = []

@onready var tilemap := $TileMapLayer
@onready var camera := $Camera2D
@onready var player := $Player

# Define your tile IDs
const TILE_FLOOR := 0
const TILE_WALL := 1
const TILE_DOOR := 2

class Room:
	var gridX: int
	var gridY: int
	var x: int
	var y: int
	var width: int
	var height: int
	
	func _init(gridX: int, gridY: int, width: int, height: int):
		self.gridX = gridX
		self.gridY = gridY
		self.width = width
		self.height = height
		self.x = gridX * (width + 2)
		self.y = gridY * (height + 2)
		
func _ready():
	randomize()
	_generate_layout()
	_draw_rooms()
	_place_doors()

func _generate_layout():
	layout_grid = []
	for y in range(GRID_SIZE):
		layout_grid.append([])
		for x in range(GRID_SIZE):
			layout_grid[y].append(null)

	# Start from the center
	var start_x = GRID_SIZE / 2
	var start_y = GRID_SIZE / 2
	var start_room = Room.new(start_x, start_y, roomWidth, roomHeight)
	var start_position = Vector2i(start_room.x + roomWidth / 2, start_room.y + roomHeight / 2) * tilemap.tile_set.tile_size
	camera.position = start_position
	player.position = start_position
	layout_grid[start_y][start_x] = start_room
	rooms.append(start_room)

	var directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

	while rooms.size() < MAX_ROOMS:
		var base_room = rooms[randi() % rooms.size()]
		var dir = directions[randi() % directions.size()]
		var new_x = base_room.gridX + int(dir.x)
		var new_y = base_room.gridY + int(dir.y)

		# Bounds check
		if new_x < 0 or new_x >= GRID_SIZE or new_y < 0 or new_y >= GRID_SIZE:
			continue

		# Skip if there's already a room
		if layout_grid[new_y][new_x] != null:
			continue

		var new_room = Room.new(new_x, new_y, roomWidth, roomHeight)
		layout_grid[new_y][new_x] = new_room
		rooms.append(new_room)

func _create_room_area(room: Room):
	var area := Area2D.new()
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.extents = Vector2i(room.width / 2, room.height / 2) * tilemap.tile_set.tile_size
	collision.shape = shape
	collision.position = shape.extents
	area.position = tilemap.map_to_local(Vector2(room.x, room.y))
	area.add_child(collision)
	area.connect("body_entered", Callable(self, "_on_room_entered").bind(room))
	add_child(area)

func _on_room_entered(body, room):
	if body.name == "Player":
		var center = Vector2(room.x + room.width / 2, room.y + room.height / 2)
		camera.position = tilemap.map_to_local(center)

func _draw_rooms():
	for room in rooms:
		var x0 = room.x
		var y0 = room.y
		var x1 = x0 + room.width
		var y1 = y0 + room.height

		for y in range(y0 - 1, y1 + 1):
			for x in range(x0 - 1, x1 + 1):
				if x == x0 - 1 or x == x1 or y == y0 - 1 or y == y1:
					tilemap.set_cell(Vector2i(x, y), 2, Vector2i(2, 0), 0)
				else:
					tilemap.set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
		_create_room_area(room)

func _place_doors():
	for room in rooms:
		var neighbors = [
			Vector2i(0, -1),  # Up
			Vector2i(0, 1),   # Down
			Vector2i(-1, 0),  # Left
			Vector2i(1, 0)    # Right
		]

		for dir in neighbors:
			var nx = room.gridX + dir.x
			var ny = room.gridY + dir.y
			if nx < 0 or nx >= GRID_SIZE or ny < 0 or ny >= GRID_SIZE:
				continue
			var neighbor = layout_grid[ny][nx]
			if neighbor == null:
				continue

			if dir.x == -1:  # Left
				var y_start = room.y + room.height / 2 - 1
				for i in range(3):
					var door_pos = Vector2i(room.x - 1, y_start + i)
					tilemap.set_cell(door_pos, 0, Vector2i(3, 13), 0)

			elif dir.x == 1:  # Right
				var y_start = room.y + room.height / 2 - 1
				for i in range(3):
					var door_pos = Vector2i(room.x + room.width, y_start + i)
					tilemap.set_cell(door_pos, 0, Vector2i(3, 13), 0)

			elif dir.y == -1:  # Up
				var x_start = room.x + room.width / 2 - 1
				for i in range(3):
					var door_pos = Vector2i(x_start + i, room.y - 1)
					tilemap.set_cell(door_pos, 0, Vector2i(3, 13), 0)

			elif dir.y == 1:  # Down
				var x_start = room.x + room.width / 2 - 1
				for i in range(3):
					var door_pos = Vector2i(x_start + i, room.y + room.height)
					tilemap.set_cell(door_pos, 0, Vector2i(3, 13), 0)

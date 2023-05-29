extends Node2D
var grid = {}

var cs = 20
var nbcol : int
var nblig : int
var explored = 0
var screen_size :Vector2

# Options
var seed = 1
var bLines = false

func get_directions(pLig,pCol) -> Array:
	var free_dirs = []
	if pLig > 2 :
		if grid[pLig-2][pCol] == "wall" :
			free_dirs.append("up")
	if pCol < nbcol - 2 :
		if grid[pLig][pCol+2] == "wall" :
			free_dirs.append("right")
	if pLig < nblig - 2 :
		if grid[pLig+2][pCol] == "wall" :
			free_dirs.append("down")
	if pCol > 2 :
		if grid[pLig][pCol-2] == "wall" :
			free_dirs.append("left")
	return free_dirs

func dig_wall(pLig,pCol)->void:
	grid[pLig][pCol] = "floor"

func explore(pLig,pCol) -> void:
	dig_wall(pLig,pCol)
	explored = explored + 1
	while explored < (nblig*nbcol)/2  :
		var dirs = get_directions(pLig,pCol)
		if dirs.size() != 0 :
			var r = randi()%dirs.size()
			var d = dirs[r]
			if d == "up" :
				dig_wall(pLig-1,pCol)
				explore(pLig-2, pCol)
			elif d == "right" :
				dig_wall(pLig,pCol+1)
				explore(pLig, pCol+2)
			elif d == "down" :
				dig_wall(pLig+1,pCol)
				explore(pLig+2, pCol)           
			elif d == "left" :
				dig_wall(pLig,pCol-1)
				explore(pLig, pCol-2)            
		else:
			break

func init() -> void:
	# Fix the seed for demo purpose
	seed(seed)
	# Initialize globals
	explored = 0
	# Create/Reset all the tables
	grid = {}
	# Fit to screen size	
	nbcol = 20
	nblig = 20
	
	# Fill with walls
	for l in range(nblig):
		grid[l] = {}
		for c in range(nbcol) :
			grid[l][c] = "wall"
	# Explore from the upper-left corner
	explore(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size
	init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	for l in range(nblig) :
		for c in range(nbcol) :
			var cell = grid[l][c]
			if cell != "wall" :
				draw_rect(Rect2(cs*c,cs*l,cs,cs),Color8(0,50,0),true)
			else :
				draw_rect(Rect2(cs*c,cs*l,cs,cs),Color8(150,150,150),true)
			
			if bLines :
				pass#draw_rect(Rect2(cs*c,cs*l,cs*c,cs*nblig),Color8(50,50,50),true)
		if bLines :
			draw_rect(Rect2(0,cs*l,cs*nbcol,cs*l),Color8(50,50,50),true)

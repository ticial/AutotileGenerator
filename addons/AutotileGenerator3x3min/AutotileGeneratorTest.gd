extends Node2D


var brush = 0

func _ready():
	$AutotileGenerator.hide()
	var tile_set:TileSet = $AutotileGenerator.fill_tileset(TileSet.new())
	$TileMap.tile_set = tile_set
	for id in tile_set.get_tiles_ids():
		var button = Button.new()
		$Control.add_child(button)
		button.text = tile_set.tile_get_name(id)
		button.icon = AtlasTexture.new()
		button.icon.atlas = tile_set.tile_get_texture(id)
		button.icon.region = Rect2(tile_set.tile_get_region(id).position,tile_set.autotile_get_size(id))
		button.connect("pressed",self,"set_brush",[id])


func _unhandled_input(event):
	if Input.is_action_pressed("mouse_left"):
		var mouse_point = $TileMap.world_to_map(get_global_mouse_position())
		$TileMap.set_cellv(mouse_point,brush)
		$TileMap.update_bitmask_area(mouse_point)
	
	if Input.is_action_pressed("mouse_right"):
		var mouse_point = $TileMap.world_to_map(get_global_mouse_position())
		$TileMap.set_cellv(mouse_point,-1)
		$TileMap.update_bitmask_area(mouse_point)


func set_brush(id):
	brush = id


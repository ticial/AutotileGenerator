tool
extends Node2D


export(TileSet) var tile_set:TileSet setget set_tileset 
export var create_image:= false
export var image_path:= "TileSet.png"

func set_tileset(_tile_set:TileSet) -> void:
	tile_set = _tile_set
	if !tile_set:
		return
	if !get_children():
		return
	
	var sprites = []
	var tileset_image_offsets = []
	var texture_size = Vector2()
	var texture_offset = Vector2()
	
	for node in get_children():
		if node is Sprite:
			sprites.append(node)
			tileset_image_offsets.append(Vector2(0,texture_size.y))
			var tile_size = node.region_rect.size.y
			var output_tex_width = tile_size * 12
			if output_tex_width > texture_size.x:
				texture_size.x = output_tex_width
			texture_size.y += tile_size * 4
	
	var tileset_image := Image.new()
	tileset_image.create(texture_size.x, texture_size.y, false, Image.FORMAT_RGBA8)
	
	for i in range(sprites.size()):
		blit_tileset_image(sprites[i], tileset_image, tileset_image_offsets[i])
	
	var tileset_texture:Texture
	
	if create_image and image_path:
		tileset_image.save_png(image_path)
		if ResourceLoader.exists(image_path):
			tileset_texture = load(image_path)
	
	if !tileset_texture:
		tileset_texture = ImageTexture.new()
		tileset_texture.create_from_image(tileset_image,2)
	
	for i in range(sprites.size()):
		create_autotile(tile_set, sprites[i].name, tileset_texture, tileset_image_offsets[i])


func blit_tileset_image(sprite:Sprite, tileset_image:Image, tileset_image_offset:Vector2):
	var tiles: Image = sprite.texture.get_data()
	
	var tile_size = sprite.region_rect.size.x / 5
	var region_tex_offset = sprite.region_rect.position
	var half_tile_size = tile_size / 2
		
	var tile_blits := {
		Rect2(0, 0, half_tile_size, half_tile_size): [
			Vector2(0, 0),
			Vector2(0, tile_size * 3),
			Vector2(tile_size, 0),
			Vector2(tile_size, tile_size * 3),
			Vector2(tile_size * 8, 0),
		],
		Rect2(0, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(0, half_tile_size),
			
			Vector2(0, tile_size * 2 + half_tile_size),
#			Vector2(0, tile_size * 3 + half_tile_size),
			Vector2(tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 8, tile_size * 3 + half_tile_size),
		],
		Rect2(half_tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(half_tile_size, 0),
			Vector2(half_tile_size, tile_size * 3),
			Vector2(tile_size * 3 + half_tile_size, 0),
			Vector2(tile_size * 3 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 11 + half_tile_size, 0),
		],
		Rect2(half_tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(half_tile_size, half_tile_size),
			
			Vector2(half_tile_size, tile_size * 2 + half_tile_size),
#			Vector2(half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 3 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 3 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 11 + half_tile_size, tile_size * 3 + half_tile_size),
		],
		Rect2(tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(0, tile_size),
			Vector2(0, tile_size * 2),
			Vector2(tile_size, tile_size),
			Vector2(tile_size, tile_size * 2),
			Vector2(tile_size * 4, tile_size),
			Vector2(tile_size * 4, tile_size * 2),
			Vector2(tile_size * 8, tile_size),
			Vector2(tile_size * 8, tile_size * 3),
		],
		Rect2(tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(0, tile_size * 3 + half_tile_size),
#			Vector2(0, half_tile_size),
			Vector2(0, tile_size + half_tile_size),
			Vector2(tile_size, half_tile_size),
			Vector2(tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 4, tile_size + half_tile_size),
			Vector2(tile_size * 4, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 8, half_tile_size),
			Vector2(tile_size * 8, tile_size + half_tile_size),
		],
		Rect2(tile_size + half_tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(half_tile_size, tile_size),
			Vector2(half_tile_size, tile_size * 2),
			Vector2(tile_size * 3 + half_tile_size, tile_size),
			Vector2(tile_size * 3 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 7 + half_tile_size, tile_size),
			Vector2(tile_size * 7 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 11 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 11 + half_tile_size, tile_size * 3),
		],
		Rect2(tile_size + half_tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(half_tile_size, tile_size * 3 + half_tile_size),
#			Vector2(half_tile_size, half_tile_size),
			Vector2(half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 3 + half_tile_size, half_tile_size),
			Vector2(tile_size * 3 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 7 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 7 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 11 + half_tile_size, half_tile_size),
			Vector2(tile_size * 11 + half_tile_size, tile_size * 2 + half_tile_size),
		],
		Rect2(tile_size * 2, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size * 2, 0),
			Vector2(tile_size * 2, tile_size * 3),
			Vector2(tile_size * 3, 0),
			Vector2(tile_size * 3, tile_size * 3),
			Vector2(tile_size * 5, 0),
			Vector2(tile_size * 6, 0),
			Vector2(tile_size * 10, 0),
			Vector2(tile_size * 11, 0),
		],
		Rect2(tile_size * 2, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size * 2, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 2, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 3, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 3, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 5, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 6, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 9, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 11, tile_size * 3 + half_tile_size),
		],
		Rect2(tile_size * 2 + half_tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size + half_tile_size, 0),
			Vector2(tile_size + half_tile_size, tile_size * 3),
			Vector2(tile_size * 2 + half_tile_size, 0),
			Vector2(tile_size * 2 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 5 + half_tile_size, 0),
			Vector2(tile_size * 6 + half_tile_size, 0),
			Vector2(tile_size * 8 + half_tile_size, 0),
			Vector2(tile_size * 10 + half_tile_size, 0),
		],
		Rect2(tile_size * 2 + half_tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 2 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 2 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 5 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 6 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 8 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 9 + half_tile_size, tile_size * 3 + half_tile_size),
		],
		Rect2(tile_size * 3, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size * 2, tile_size),
			Vector2(tile_size * 2, tile_size * 2),
			Vector2(tile_size * 3, tile_size),
			Vector2(tile_size * 3, tile_size * 2),
			Vector2(tile_size * 4, tile_size * 3),
			Vector2(tile_size * 5, tile_size),
			Vector2(tile_size * 5, tile_size * 3),
			Vector2(tile_size * 7, 0),
			Vector2(tile_size * 7, tile_size),
			Vector2(tile_size * 7, tile_size * 3),
			Vector2(tile_size * 8, tile_size * 2),
			Vector2(tile_size * 9, 0),
			Vector2(tile_size * 9, tile_size),
		],
		Rect2(tile_size * 3, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size * 2, half_tile_size),
			Vector2(tile_size * 2, tile_size + half_tile_size),
			Vector2(tile_size * 3, half_tile_size),
			Vector2(tile_size * 3, tile_size + half_tile_size),
			Vector2(tile_size * 4, half_tile_size),
			Vector2(tile_size * 5, half_tile_size),
			Vector2(tile_size * 5, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 7, half_tile_size),
			Vector2(tile_size * 7, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 7, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 8, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 10, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 10, tile_size * 3 + half_tile_size),
		],
		Rect2(tile_size * 3 + half_tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size + half_tile_size, tile_size),
			Vector2(tile_size + half_tile_size, tile_size * 2),
			Vector2(tile_size * 2 + half_tile_size, tile_size),
			Vector2(tile_size * 2 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 4 + half_tile_size, 0),
			Vector2(tile_size * 4 + half_tile_size, tile_size),
			Vector2(tile_size * 4 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 6 + half_tile_size, tile_size),
			Vector2(tile_size * 6 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 7 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 9 + half_tile_size, 0),
			Vector2(tile_size * 10 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 11 + half_tile_size, tile_size)
		],
		Rect2(tile_size * 3 + half_tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size + half_tile_size, half_tile_size),
			Vector2(tile_size + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 2 + half_tile_size, half_tile_size),
			Vector2(tile_size * 2 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 4 + half_tile_size, half_tile_size),
			Vector2(tile_size * 4 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 4 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 6 + half_tile_size, half_tile_size),
			Vector2(tile_size * 6 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 7 + half_tile_size, half_tile_size),
			Vector2(tile_size * 9 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 10 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 11 + half_tile_size, tile_size + half_tile_size),
		],
		Rect2(tile_size * 4, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size * 4, 0),
			Vector2(tile_size * 5, tile_size * 2),
			Vector2(tile_size * 6, tile_size),
			Vector2(tile_size * 6, tile_size * 2),
			Vector2(tile_size * 6, tile_size * 3),
			Vector2(tile_size * 7, tile_size * 2),
			Vector2(tile_size * 9, tile_size * 2),
			Vector2(tile_size * 9, tile_size * 3),
			Vector2(tile_size * 10, tile_size * 2),
			Vector2(tile_size * 10, tile_size * 3),
			Vector2(tile_size * 11, tile_size),
			Vector2(tile_size * 11, tile_size * 2),
			Vector2(tile_size * 11, tile_size * 3),
		],
		Rect2(tile_size * 4, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size * 4, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 5, tile_size + half_tile_size),
			Vector2(tile_size * 6, half_tile_size),
			Vector2(tile_size * 6, tile_size + half_tile_size),
			Vector2(tile_size * 6, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 7, tile_size + half_tile_size),
			Vector2(tile_size * 9, half_tile_size),
			Vector2(tile_size * 9, tile_size + half_tile_size),
			Vector2(tile_size * 9, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 10, half_tile_size),
			Vector2(tile_size * 11, half_tile_size),
			Vector2(tile_size * 11, tile_size + half_tile_size),
			Vector2(tile_size * 11, tile_size * 2 + half_tile_size),
		],
		Rect2(tile_size * 4 + half_tile_size, 0, half_tile_size, half_tile_size): [
			Vector2(tile_size * 4 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 5 + half_tile_size, tile_size),
			Vector2(tile_size * 5 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 5 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 6 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 7 + half_tile_size, 0),
			Vector2(tile_size * 8 + half_tile_size, tile_size),
			Vector2(tile_size * 8 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 8 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 9 + half_tile_size, tile_size),
			Vector2(tile_size * 9 + half_tile_size, tile_size * 2),
			Vector2(tile_size * 9 + half_tile_size, tile_size * 3),
			Vector2(tile_size * 10 + half_tile_size, tile_size * 3),
		],
		Rect2(tile_size * 4 + half_tile_size, half_tile_size, half_tile_size, half_tile_size): [
			Vector2(tile_size * 4 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 5 + half_tile_size, half_tile_size),
			Vector2(tile_size * 5 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 5 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 6 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 7 + half_tile_size, tile_size * 3 + half_tile_size),
			Vector2(tile_size * 8 + half_tile_size, half_tile_size),
			Vector2(tile_size * 8 + half_tile_size, tile_size + half_tile_size),
			Vector2(tile_size * 8 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 9 + half_tile_size, half_tile_size),
			Vector2(tile_size * 9 + half_tile_size, tile_size * 2 + half_tile_size),
			Vector2(tile_size * 10 + half_tile_size, half_tile_size),
			Vector2(tile_size * 10 + half_tile_size, tile_size * 2 + half_tile_size),
		],
	}
	
	for key in tile_blits:
		for dest in tile_blits[key]:
			var src = key
			src.position += region_tex_offset
			dest += tileset_image_offset
			tileset_image.blit_rect(tiles, src, dest)

	
func create_autotile(tile_set:TileSet,tile_name:String, texture:Texture, texture_offset:Vector2):
	var id = tile_set.find_tile_by_name(tile_name)
	if id < 0:
		id = tile_set.get_last_unused_tile_id()
		tile_set.create_tile(id)
	var tile_size: int = texture.get_width() / 12
	tile_set.tile_set_name(id, tile_name)
	tile_set.tile_set_texture(id, texture)
	tile_set.tile_set_region(id, Rect2(texture_offset.x, texture_offset.y, tile_size * 12, tile_size * 4))
	tile_set.tile_set_tile_mode(id, TileSet.AUTO_TILE)
	tile_set.autotile_set_size(id, Vector2(tile_size, tile_size))
	tile_set.autotile_set_bitmask_mode(id, TileSet.BITMASK_3X3_MINIMAL)
	tile_set.autotile_set_bitmask(id, Vector2(0, 0),
		TileSet.BIND_CENTER)
	tile_set.autotile_set_bitmask(id, Vector2(0, 3),
		TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(0, 1),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(0, 2),
		TileSet.BIND_TOP + TileSet.BIND_CENTER)
#	tile_set.autotile_set_bitmask(id, Vector2(0, 3),
#		TileSet.BIND_CENTER)
	tile_set.autotile_set_bitmask(id, Vector2(1, 0),
		TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(1, 1),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(1, 2),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(1, 3),
		TileSet.BIND_CENTER + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(2, 0),
		TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(2, 1),
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(2, 2),
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(2, 3),
		TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(3, 0),
		TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(3, 1),
		TileSet.BIND_TOP + TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(3, 2),
		TileSet.BIND_TOP + TileSet.BIND_LEFT + TileSet.BIND_CENTER)
	tile_set.autotile_set_bitmask(id, Vector2(3, 3),
		TileSet.BIND_LEFT + TileSet.BIND_CENTER)
	tile_set.autotile_set_bitmask(id, Vector2(4, 0),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(4, 1),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(4, 2),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(4, 3),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(5, 0),
		TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(5, 1),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(5, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(5, 3),
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(6, 0),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(6, 1),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(6, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(6, 3),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(7, 0),
		TileSet.BIND_TOPRIGHT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(7, 1),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(7, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(7, 3),
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(8, 0),
		TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(8, 1),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(8, 2),
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(8, 3),
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(9, 0),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(9, 1),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(9, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(9, 3),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(10, 0),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(10, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(10, 3),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(11, 0),
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(11, 1),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT)
	tile_set.autotile_set_bitmask(id, Vector2(11, 2),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM)
	tile_set.autotile_set_bitmask(id, Vector2(11, 3),
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER)

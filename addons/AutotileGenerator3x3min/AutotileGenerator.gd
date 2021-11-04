tool
class_name AutotileGenerator
extends Node2D

class Source:
	const c1_1 = Rect2(0, 0, 0.5, 0.5)
	const c1_2 = Rect2(0, 0.5, 0.5, 0.5)
	const c1_3 = Rect2(0.5, 0, 0.5, 0.5)
	const c1_4 = Rect2(0.5, 0.5, 0.5, 0.5)
	const c2_1 = Rect2(1, 0, 0.5, 0.5)
	const c2_2 = Rect2(1, 0.5, 0.5, 0.5)
	const c2_3 = Rect2(1.5, 0, 0.5, 0.5)
	const c2_4 = Rect2(1.5, 0.5, 0.5, 0.5)
	const c3_1 = Rect2(2, 0, 0.5, 0.5)
	const c3_2 = Rect2(2, 0.5, 0.5, 0.5)
	const c3_3 = Rect2(2.5, 0, 0.5, 0.5)
	const c3_4 = Rect2(2.5, 0.5, 0.5, 0.5)
	const c4_1 = Rect2(3, 0, 0.5, 0.5)
	const c4_2 = Rect2(3, 0.5, 0.5, 0.5)
	const c4_3 = Rect2(3.5, 0, 0.5, 0.5)
	const c4_4 = Rect2(3.5, 0.5, 0.5, 0.5)
	const c5_1 = Rect2(4, 0, 0.5, 0.5)
	const c5_2 = Rect2(4, 0.5, 0.5, 0.5)
	const c5_3 = Rect2(4.5, 0, 0.5, 0.5)
	const c5_4 = Rect2(4.5, 0.5, 0.5, 0.5)
	
const corners = [
	Vector2(0, 0),
	Vector2(0, 0.5),
	Vector2(0.5, 0),
	Vector2(0.5, 0.5),
]

var _tiles_data = {
	Vector2(0,0): [Source.c1_1,Source.c1_2,Source.c1_3,Source.c1_4,
		TileSet.BIND_CENTER],
	Vector2(0,1): [Source.c1_1,Source.c2_2,Source.c1_3,Source.c2_4,
		TileSet.BIND_CENTER + TileSet.BIND_BOTTOM],
	Vector2(0,2): [Source.c2_1,Source.c2_2,Source.c2_3,Source.c2_4,
		TileSet.BIND_CENTER + TileSet.BIND_TOP + TileSet.BIND_BOTTOM],
	Vector2(0,3): [Source.c2_1,Source.c1_2,Source.c2_3,Source.c1_4,
		TileSet.BIND_CENTER + TileSet.BIND_TOP],
	
	Vector2(1,0): [Source.c1_1,Source.c1_2,Source.c3_3,Source.c3_4,
		TileSet.BIND_CENTER + TileSet.BIND_RIGHT],
	Vector2(1,1): [Source.c1_1,Source.c2_2,Source.c3_3,Source.c4_4,
		TileSet.BIND_CENTER + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOM],
	Vector2(1,2): [Source.c2_1,Source.c2_2,Source.c4_3,Source.c4_4,
		TileSet.BIND_CENTER + TileSet.BIND_RIGHT + TileSet.BIND_TOP + TileSet.BIND_BOTTOM],
	Vector2(1,3): [Source.c2_1,Source.c1_2,Source.c4_3,Source.c3_4,
		TileSet.BIND_CENTER + TileSet.BIND_RIGHT + TileSet.BIND_TOP],
	
	Vector2(2,0): [Source.c3_1,Source.c3_2,Source.c3_3,Source.c3_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_RIGHT],
	Vector2(2,1): [Source.c3_1,Source.c4_2,Source.c3_3,Source.c4_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOM],
	Vector2(2,2): [Source.c4_1,Source.c4_2,Source.c4_3,Source.c4_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_RIGHT + TileSet.BIND_TOP + TileSet.BIND_BOTTOM],
	Vector2(2,3): [Source.c4_1,Source.c3_2,Source.c4_3,Source.c3_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_RIGHT + TileSet.BIND_TOP],
	
	Vector2(3,0): [Source.c3_1,Source.c3_2,Source.c1_3,Source.c1_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT],
	Vector2(3,1): [Source.c3_1,Source.c4_2,Source.c1_3,Source.c2_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_BOTTOM],
	Vector2(3,2): [Source.c4_1,Source.c4_2,Source.c2_3,Source.c2_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_BOTTOM],
	Vector2(3,3): [Source.c4_1,Source.c3_2,Source.c2_3,Source.c1_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_TOP],
	
	Vector2(4,0): [Source.c5_1,Source.c4_2,Source.c4_3,Source.c4_4,
		TileSet.BIND_CENTER + TileSet.BIND_LEFT + TileSet.BIND_RIGHT + TileSet.BIND_TOP + TileSet.BIND_BOTTOM + TileSet.BIND_TOPLEFT],
	Vector2(4,1): [Source.c2_1,Source.c2_2,Source.c4_3,Source.c5_4,
		TileSet.BIND_CENTER + TileSet.BIND_TOP + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(4,2): [Source.c2_1,Source.c2_2,Source.c5_3,Source.c4_4,
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],
	Vector2(4,3): [Source.c4_1,Source.c5_2,Source.c4_3,Source.c4_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT],
		
	Vector2(5,0): [Source.c3_1,Source.c4_2,Source.c3_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(5,1): [Source.c4_1,Source.c5_2,Source.c5_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(5,2): [Source.c5_1,Source.c4_2,Source.c5_3,Source.c5_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(5,3): [Source.c4_1,Source.c3_2,Source.c5_3,Source.c3_4,
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],

	Vector2(6,0): [Source.c3_1,Source.c5_2,Source.c3_3,Source.c4_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT],
	Vector2(6,1): [Source.c5_1,Source.c5_2,Source.c4_3,Source.c5_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(6,2): [Source.c5_1,Source.c5_2,Source.c5_3,Source.c4_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],
	Vector2(6,3): [Source.c5_1,Source.c3_2,Source.c4_3,Source.c3_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_RIGHT],

	Vector2(7,0): [Source.c4_1,Source.c4_2,Source.c5_3,Source.c4_4,
		TileSet.BIND_TOPRIGHT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT],
	Vector2(7,1): [Source.c4_1,Source.c5_2,Source.c2_3,Source.c2_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM],
	Vector2(7,2): [Source.c5_1,Source.c4_2,Source.c2_3,Source.c2_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM],
	Vector2(7,3): [Source.c4_1,Source.c4_2,Source.c4_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],

	Vector2(8,0): [Source.c1_1,Source.c2_2,Source.c3_3,Source.c5_4,
		TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(8,1): [Source.c2_1,Source.c2_2,Source.c5_3,Source.c5_4,
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(8,2): [Source.c4_1,Source.c4_2,Source.c5_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(8,3): [Source.c2_1,Source.c1_2,Source.c5_3,Source.c3_4,
		TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],
	
	Vector2(9,0): [Source.c4_1,Source.c5_2,Source.c4_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(9,1): [Source.c4_1,Source.c5_2,Source.c5_3,Source.c4_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],
	Vector2(9,2): [Source.c5_1,Source.c5_2,Source.c5_3,Source.c5_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(9,3): [Source.c5_1,Source.c3_2,Source.c5_3,Source.c3_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],
	
	Vector2(10,0): [Source.c3_1,Source.c5_2,Source.c3_3,Source.c5_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	
	Vector2(10,2): [Source.c5_1,Source.c4_2,Source.c4_3,Source.c5_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT + TileSet.BIND_BOTTOMRIGHT],
	Vector2(10,3): [Source.c5_1,Source.c4_2,Source.c5_3,Source.c4_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_TOPRIGHT + TileSet.BIND_RIGHT],

	Vector2(11,0): [Source.c3_1,Source.c5_2,Source.c1_3,Source.c2_4,
		TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM],
	Vector2(11,1): [Source.c5_1,Source.c5_2,Source.c4_3,Source.c4_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM + TileSet.BIND_RIGHT],
	Vector2(11,2): [Source.c5_1,Source.c5_2,Source.c2_3,Source.c2_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_BOTTOMLEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER + TileSet.BIND_BOTTOM],
	Vector2(11,3): [Source.c5_1,Source.c3_2,Source.c2_3,Source.c1_4,
		TileSet.BIND_TOPLEFT + TileSet.BIND_LEFT + TileSet.BIND_TOP + TileSet.BIND_CENTER],
}

var _sprites = []
var _texture_offsets = []


func create_tileset_texture(image_path:String = '') -> Texture:
	if !get_children():
		return null
	
	_sprites.clear()
	_texture_offsets.clear()
	
	var texture_size = Vector2()
	
	for node in get_children():
		if node is Sprite:
			_sprites.append(node)
			_texture_offsets.append(Vector2(0,texture_size.y))
			if !node.region_enabled:
				node.region_enabled = true
				node.region_rect.size = node.texture.get_size()
			var tile_size = node.region_rect.size.y
			var texture_width = tile_size * 12
			if texture_width > texture_size.x:
				texture_size.x = texture_width
			texture_size.y += tile_size * 4
	
	var tileset_image := Image.new()
	tileset_image.create(texture_size.x, texture_size.y, false, Image.FORMAT_RGBA8)
	
	for i in range(_sprites.size()):
		_blit_tileset_image(_sprites[i], tileset_image, _texture_offsets[i])
	
	var tileset_texture:Texture
	
	if image_path:
		tileset_image.save_png(image_path)
#		emit_signal("saved_image")
		print("saved image: ",image_path)
	else:
		tileset_texture = ImageTexture.new()
		tileset_texture.create_from_image(tileset_image,2)
		
	return tileset_texture


func fill_tileset(tile_set:TileSet, tileset_texture:Texture = create_tileset_texture()) -> TileSet:
	for i in range(_sprites.size()):
		_create_autotile(tile_set, _sprites[i].name, tileset_texture, _texture_offsets[i])
		
	return tile_set


func _blit_tileset_image(sprite:Sprite, tileset_image:Image, texture_offset:Vector2):
	var sprite_image: Image = sprite.texture.get_data()
	var tile_size = sprite.region_rect.size.x / 5
	var region_tex_offset = sprite.region_rect.position
	var rect_size = Vector2(tile_size/2,tile_size/2)
	
	for i in range(_tiles_data.size()):
		var dest = _tiles_data.keys()[i] * tile_size + texture_offset
		var data = _tiles_data.values()[i]
		for j in range(4):
			var src = data[j]
			src.position = src.position * tile_size + region_tex_offset
			src.size = rect_size
			tileset_image.blit_rect(sprite_image, src, dest + corners[j] * tile_size)

	
func _create_autotile(tile_set:TileSet,tile_name:String, texture:Texture, texture_offset:Vector2) -> void:
	var id = tile_set.find_tile_by_name(tile_name)
	if id < 0:
		id = tile_set.get_last_unused_tile_id()
		tile_set.create_tile(id)
	var tile_size = texture.get_width() / 12
	tile_set.tile_set_name(id, tile_name)
	tile_set.tile_set_texture(id, texture)
	tile_set.tile_set_region(id, Rect2(texture_offset.x, texture_offset.y, tile_size * 12, tile_size * 4))
	tile_set.tile_set_tile_mode(id, TileSet.AUTO_TILE)
	tile_set.autotile_set_size(id, Vector2(tile_size, tile_size))
	tile_set.autotile_set_bitmask_mode(id, TileSet.BITMASK_3X3_MINIMAL)
	
	for i in range(_tiles_data.size()):
		tile_set.autotile_set_bitmask(id, _tiles_data.keys()[i], _tiles_data.values()[i][4])


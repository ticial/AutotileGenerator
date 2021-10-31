tool
extends Control

var _which_folder = "input"
var generator
var plugin
var dialog

func _ready():
	dialog = FileDialog.new()
	dialog.rect_size = Vector2(800, 400)
	dialog.window_title = "Select a Path"
	add_child(dialog)
	dialog.connect("file_selected", self, "_on_file_selected")


func setup(_generator, _plugin):
	generator = _generator
	plugin = _plugin
#	if generator.is_connected("saved_image",self,"scan_filesystem")


func scan_filesystem():
	plugin.get_editor_interface().get_resource_filesystem().scan()

func _on_Folder_pressed(which: String) -> void:
	_which_folder = which
	match which:
		"output_image":
			dialog.mode = EditorFileDialog.MODE_SAVE_FILE
			dialog.clear_filters()
			dialog.add_filter("*.bmp, *.dds, *.exr, *.hdr, *.jpg, *.jpeg, *.png, *.tga, *.svg, *.svgz, *.webp; Images")
			dialog
			set_meta("line_edit", $VBox/OutputImage/LineEdit)
		"output_tileset":
			dialog.mode = EditorFileDialog.MODE_SAVE_FILE
			dialog.clear_filters()
			dialog.add_filter("*.tres, *.res; Resource File")
			set_meta("line_edit", $VBox/OutputTileSet/LineEdit)
	dialog.popup_centered()


func _on_file_selected(file: String) -> void:
	get_meta("line_edit").text = file


func _on_GenImage_pressed():
	generator.create_tileset_texture($VBox/OutputImage/LineEdit.text)
	scan_filesystem()


func _on_GenTileSet_pressed():
	var tile_set
	var texture
	var tile_set_path = $VBox/OutputTileSet/LineEdit.text
	var image_path = $VBox/OutputImage/LineEdit.text
	if ResourceLoader.exists(tile_set_path):
		tile_set = ResourceLoader.load(tile_set_path)
	else:
		tile_set = TileSet.new()
	if !ResourceLoader.exists(image_path):
		texture = generator.create_tileset_texture(image_path)
		scan_filesystem()
		return
	texture = ResourceLoader.load(image_path)
	
	generator.fill_tileset(tile_set, texture)
	ResourceSaver.save(tile_set_path,tile_set)
	print("saved tileset: ",tile_set_path)
	scan_filesystem()

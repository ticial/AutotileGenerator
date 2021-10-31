tool
extends EditorPlugin

var icon = load("res://addons/AutotileGenerator3x3min/icon.png")

var edi
var interface
var control_added = false

func _enter_tree():
	var plugin = EditorPlugin.new()
	edi = plugin.get_editor_interface()
	plugin.queue_free()
	interface = preload("./Interface.tscn").instance()
	add_custom_type("AutotileGenerator","Node2D",preload("./AutotileGenerator.gd"),icon)
	

func _exit_tree():
	remove_custom_type("AutotileGenerator")
	remove_control_from_docks(interface)


func _process(delta):
	if !edi:
		return
	var nodes = edi.get_selection().get_selected_nodes()
	
	if nodes != null && nodes.size() > 0:
		var node = nodes[0]
		if node is AutotileGenerator:
			if !control_added:
				control_added = true
				add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, interface)
				interface.setup(node, self)
				print(interface)
		else:
			if control_added:
				remove_control_from_docks(interface)
				control_added = false

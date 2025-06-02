@tool
extends EditorPlugin

func _enter_tree():
	add_tool_menu_item("Print Scene Structures", Callable(self, "_on_print_scene_structures"))
	add_tool_menu_item("Print Node Settings", Callable(self, "_on_print_node_settings"))
	add_tool_menu_item("Print Project Info", Callable(self, "_on_print_project_info"))

func _exit_tree():
	remove_tool_menu_item("Print Scene Structures")
	remove_tool_menu_item("Print Node Settings")
	remove_tool_menu_item("Print Project Info")

func _on_print_scene_structures():
	var scenes: Array = []
	_gather_scenes("res://", scenes)
	var file := FileAccess.open("res://scene_structures.txt", FileAccess.WRITE)
	for path in scenes:
		file.store_line("=== %s ===" % path)
		var packed = ResourceLoader.load(path)
		if packed is PackedScene:
			_print_tree(packed.instantiate(), "", file)
	file.close()
	print("✅ Wrote res://scene_structures.txt")

func _on_print_node_settings():
	var scenes: Array = []
	_gather_scenes("res://", scenes)
	var file := FileAccess.open("res://node_settings.txt", FileAccess.WRITE)
	for path in scenes:
		file.store_line("=== %s ===" % path)
		var packed = ResourceLoader.load(path)
		if packed is PackedScene:
			_print_node_settings(packed.instantiate(), "", file)
	file.close()
	print("✅ Wrote res://node_settings.txt")

func _on_print_project_info():
	var file := FileAccess.open("res://project_info.txt", FileAccess.WRITE)
	# Godot version
	var ver = Engine.get_version_info()
	file.store_line("Godot Version: %s.%s.%s %s" % [ver["major"], ver["minor"], ver["patch"], ver.get("status", "")])
	# Project settings
	var keys = [
		"application/config/name",
		"application/config/version",
		"application/config/description",
		"application/run/main_scene"
	]
	for key in keys:
		var val = ProjectSettings.get_setting(key, "<unset>")
		file.store_line("%s: %s" % [key, str(val)])
	file.close()
	print("✅ Wrote res://project_info.txt")

func _gather_scenes(dir_path: String, arr: Array) -> void:
	var da = DirAccess.open(dir_path)
	if da == null:
		return
	da.list_dir_begin()
	while true:
		var name = da.get_next()
		if name == "":
			break
		if da.current_is_dir():
			if not name.begins_with("."):
				_gather_scenes(dir_path + "/" + name, arr)
		elif name.to_lower().ends_with(".tscn"):
			arr.append(dir_path + "/" + name)
	da.list_dir_end()

func _print_tree(node: Node, indent: String, file: FileAccess) -> void:
	file.store_line(indent + node.name + " : " + node.get_class())
	for child in node.get_children():
		if child is Node:
			_print_tree(child, indent + "  ", file)

func _print_node_settings(node: Node, indent: String, file: FileAccess) -> void:
	file.store_line(indent + "Node: %s (%s)" % [node.name, node.get_class()])
	for prop in node.get_property_list():
		var pname = prop.name
		if pname.begins_with("__"):
			continue
		var value = node.get(pname)
		file.store_line(indent + "  %s: %s" % [pname, str(value)])
	for child in node.get_children():
		if child is Node:
			_print_node_settings(child, indent + "  ", file)

@tool
extends EditorPlugin


const MainPanel = preload("res://addons/gates-exporter-plugin/main_panel.tscn")

var main_panel_instance: Control


func _enter_tree():
	main_panel_instance = MainPanel.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, main_panel_instance)


func _exit_tree():
	if main_panel_instance:
		remove_control_from_docks(main_panel_instance)
		main_panel_instance.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible

func _get_plugin_name():
	return "Gates Exporter"


func _get_plugin_icon():
	# Must return some kind of Texture for the icon.
	return get_editor_interface().get_base_control().get_theme_icon("Node", "EditorIcons")

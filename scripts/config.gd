@tool
extends Control

const CONFIG_PATH = "res://addons/gates-exporter-plugin/config.cfg"
var config

func _ready():
	config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	
	if err != OK:
		push_error("ERROR: Could not read config file.")
		return

	%export_edit.set_text(config.get_value("config", "export_directory"))
	%icon_edit.set_text(config.get_value("config", "screenshot"))


func save_config():
	config.save(CONFIG_PATH)

func _on_export_edit_focus_exited():
	save_config()

func _on_icon_edit_focus_exited():
	save_config()

func _on_export_edit_text_changed(new_text):
	config.set_value("config", "export_directory", new_text)
	
func _on_icon_edit_text_changed(new_text):
	config.set_value("config", "screenshot", new_text)


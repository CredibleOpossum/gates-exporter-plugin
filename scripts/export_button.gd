@tool
extends Button

func _on_button_down():
	
	var config = self.get_parent().config
	var export_directory = config.get_value("config", "export_directory")
	if export_directory == null:
		push_error("ERROR: export_directory key does not exist, does config.cfg exist?")
	export_directory += "/"
	var screenshot_path = config.get_value("config", "screenshot")
	if screenshot_path == null:
		push_error("ERROR: screenshot key does not exist, does config.cfg exist?")
	
	var path = OS.get_executable_path()
	var project_path = ProjectSettings.globalize_path("res://")
	var template_path = "res://addons/gates-exporter-plugin/template/"
	var zip_destination = export_directory + "project.zip"
	var dir = DirAccess.make_dir_absolute(export_directory)
	var exit_code = OS.execute(path, ["--headless", "--path", project_path, "--export-pack", "gates", zip_destination])
	if !FileAccess.file_exists(zip_destination):
		push_error("ERROR: failed to build zip, does the \"gates\" export template exist?")
		OS.move_to_trash(export_directory)
		return
	DirAccess.copy_absolute(template_path + ".gdignore", export_directory + ".gdignore") # Stops import of assets inside dir
	DirAccess.copy_absolute(screenshot_path, export_directory + "icon.png")
	DirAccess.copy_absolute(template_path + "world.gate", export_directory + "world.gate")
	

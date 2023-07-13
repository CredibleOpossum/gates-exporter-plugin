@tool
extends Button

func _on_button_down():
	var path = OS.get_executable_path()
	var project_path = ProjectSettings.globalize_path("res://")
	var template_path = "res://addons/gates-exporter-plugin/template/"
	var export_path = project_path + "/export/project.zip"
	OS.move_to_trash(project_path + "/export/")
	var dir = DirAccess.open("res://")
	dir.make_dir("export")
	var exit_code = OS.execute(path, ["--headless", "--path", project_path, "--export-pack", "gates", export_path])
	if !FileAccess.file_exists(export_path):
		push_error("ERROR: failed to build zip, does the \"gates\" export template exist?")
	DirAccess.copy_absolute(template_path + ".gdignore", "res://export/.gdignore") # Stops import of assets inside dir
	DirAccess.copy_absolute(template_path + "icon.png", "res://export/icon.png")
	DirAccess.copy_absolute(template_path + "world.gate", "res://export/world.gate")
	

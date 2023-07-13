@tool
extends Button

func _on_button_down():
	var path = OS.get_executable_path()
	var project_path = ProjectSettings.globalize_path("res://")
	var template_path = "res://addons/GatesExporter/template/"
	var dir = DirAccess.open("res://")
	dir.make_dir("export")
	OS.execute(path, ["--headless", "--path", project_path, "--export-pack", "gates", project_path + "/export/project.zip"])
	DirAccess.copy_absolute(template_path + ".gdignore", "res://export/.gdignore") # Stops import of assets inside dir
	DirAccess.copy_absolute(template_path + "icon.png", "res://export/icon.png")
	DirAccess.copy_absolute(template_path + "world.gate", "res://export/world.gate")
	

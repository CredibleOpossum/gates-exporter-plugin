@tool
extends Button

signal selected
signal path_changed(path: String)

@export var line_edit: LineEdit
@export var file_dialog: FileDialog


func _ready() -> void:
	pressed.connect(show_dialog)
	
	file_dialog.dir_selected.connect(on_selected)
	file_dialog.file_selected.connect(on_selected)
	file_dialog.files_selected.connect(on_selected)


func show_dialog() -> void:
	file_dialog.visible = true


func on_selected(path: String) -> void:
	line_edit.text = path
	path_changed.emit(path)
	selected.emit()
	print("choosen " + path)

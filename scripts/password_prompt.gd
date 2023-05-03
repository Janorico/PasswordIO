extends Control


const SETUP_SCENE: PackedScene = preload("res://scenes/setup.tscn")
const DATA_FILE_PATH: String = "user://data"
onready var line_edit: LineEdit = $GUI/CenterContainer/VBoxContainer/HBoxContainer/LineEdit
onready var error_dialog: AcceptDialog = $ErrorDialog


func _ready():
	if not File.new().file_exists(DATA_FILE_PATH):
		# warning-ignore:return_value_discarded
		get_tree().change_scene_to(SETUP_SCENE)


func check() -> void:
	var config: ConfigFile = ConfigFile.new()
	var master_pass: String = line_edit.text
	var result: int = config.load_encrypted_pass(DATA_FILE_PATH, master_pass)
	if result == OK:
		# Config file data to password array
		var passwords: Array = []
		for section in config.get_sections():
			passwords.append(Password.new(
				config.get_value(section, "display_name", ""),
				config.get_value(section, "username", ""),
				config.get_value(section, "password", "")
			))
		# Instance main scene
		var main = preload("res://scenes/main.tscn").instance()
		# Setup main scene
		main.master_pass = master_pass
		main.passwords = passwords
		# Change scene
		get_parent().add_child(main)
		get_tree().current_scene = main
		queue_free()
	else:
		error_dialog.dialog_text = "Error: %s" % result
		error_dialog.popup_centered()


func _on_line_edit_text_entered(_new_text: String) -> void:
	check()

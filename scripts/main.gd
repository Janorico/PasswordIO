extends Control


onready var passwords_list: ItemList = $VisibleGUI/VBoxContainer/PasswordsList
onready var edit_password_dialog: ConfirmationDialog = $EditPasswordDialog
var master_pass: String = ""
var passwords: Array = []
var edit_index: int = -1


func _ready() -> void:
	update_list()


func changed() -> void:
	write_data()
	update_list()


func update_list() -> void:
	passwords_list.clear()
	for password in passwords:
		passwords_list.add_item(password.display_name)


func write_data() -> void:
	var config: ConfigFile = ConfigFile.new()
	var count: int = -1
	var section: String
	for password in passwords:
		count += 1
		section = "Data%d" % count
		config.set_value(section, "display_name", password.display_name)
		config.set_value(section, "username", password.username)
		config.set_value(section, "password", password.password)
	# warning-ignore:return_value_discarded
	config.save_encrypted_pass("user://data", master_pass)


func _on_refresh() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/password_prompt.tscn")


func _on_add(display_name, username, password) -> void:
	passwords.append(Password.new(display_name, username, password))
	changed()


func _on_edit() -> void:
	var selected_passwords: PoolIntArray = passwords_list.get_selected_items()
	if selected_passwords.size() > 0:
		edit_index = selected_passwords[0]
		var password: Password = passwords[edit_index]
		edit_password_dialog.popup_dialog(password.display_name, password.username, password.password)


func _on_edit_confirmed(display_name, username, password) -> void:
	if edit_index > -1:
		passwords[edit_index] = Password.new(display_name, username, password)
		changed()


func _on_remove() -> void:
	var selected_passwords: PoolIntArray = passwords_list.get_selected_items()
	if selected_passwords.size() > 0:
		passwords.remove(selected_passwords[0])
		changed()


func _on_rich_meta_clicked(meta) -> void:
	# warning-ignore:return_value_discarded
	OS.shell_open(meta)

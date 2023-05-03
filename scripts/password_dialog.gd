extends ConfirmationDialog


signal password_confirmed(display_name, username, password)

onready var name_line_edit: LineEdit = $GridContainer/NameLineEdit
onready var username_line_edit: LineEdit = $GridContainer/UsernameLineEdit
onready var password_line_edit: LineEdit = $GridContainer/PasswordLineEdit


func popup_dialog(name_text: String = "", username_text: String = "", password_text: String = "") -> void:
	name_line_edit.text = name_text
	username_line_edit.text = username_text
	password_line_edit.text = password_text
	popup_centered()


func _on_confirmed():
	emit_signal("password_confirmed", name_line_edit.text, username_line_edit.text, password_line_edit.text)

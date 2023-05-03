extends Control


onready var password_line_edit: LineEdit = $GUI/Page2/VBoxContainer/GridContainer/PasswordLineEdit
onready var confirm_password_line_edit: LineEdit = $GUI/Page2/VBoxContainer/GridContainer/ConfirmPasswordLineEdit
onready var password_dialog: AcceptDialog = $PasswordDialog
onready var animation_player: AnimationPlayer = $AnimationPlayer
var password: String


func _setup_password():
	var temp_password = password_line_edit.text
	if temp_password == confirm_password_line_edit.text:
		password = temp_password
		animation_player.play("page_3")
	else:
		password_dialog.popup_centered()


func _get_started():
		# Instance main scene
		var main = preload("res://scenes/main.tscn").instance()
		# Setup main scene
		main.master_pass = password
		main.write_data()
		# Change scene
		get_parent().add_child(main)
		get_tree().current_scene = main
		queue_free()

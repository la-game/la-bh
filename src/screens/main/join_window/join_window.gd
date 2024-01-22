extends Window


signal connected

@export var ip_edit: LineEdit

@export var port_edit: LineEdit

@export var notification_dialog: AcceptDialog


func _on_about_to_popup() -> void:
	ip_edit.text = "127.0.0.1"
	port_edit.text = "9921"


func _on_close_requested() -> void:
	hide()


func _on_port_edit_text_changed(new_text: String) -> void:
	var numbers = RegexFacade.only_numbers(new_text)
	
	if new_text != numbers:
		port_edit.text = numbers


func _on_join_pressed() -> void:
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
	
	if not ip_edit.text.is_valid_ip_address():
		notification_dialog.dialog_text = "Invalid IP Address."
		return notification_dialog.popup_centered()
	
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip_edit.text, int(port_edit.text))
	
	match error:
		ERR_CANT_CREATE:
			notification_dialog.dialog_text = "Unkown error, try restarting."
			return notification_dialog.popup_centered()
		ERR_ALREADY_IN_USE:
			notification_dialog.dialog_text = "Connection in use, try restarting or changing port."
			return notification_dialog.popup_centered()
	
	multiplayer.multiplayer_peer = peer
	
	hide()
	connected.emit()


func _on_cancel_pressed() -> void:
	hide()

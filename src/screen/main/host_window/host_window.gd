extends Window


signal hosting

@export var port_edit: LineEdit

@export var notification_dialog: AcceptDialog


func _on_about_to_popup() -> void:
	port_edit.text = "9921"


func _on_close_requested() -> void:
	hide()


func _on_port_edit_text_changed(new_text: String) -> void:
	var numbers = RegexFacade.only_numbers(new_text)
	
	if new_text != numbers:
		port_edit.text = numbers


func _on_host_pressed() -> void:
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
	
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(int(port_edit.text), 32)
	
	match error:
		ERR_CANT_CREATE:
			notification_dialog.dialog_text = "Unkown error, try restarting."
			return notification_dialog.popup_centered()
		ERR_ALREADY_IN_USE:
			notification_dialog.dialog_text = "Connection in use, try restarting or changing port."
			return notification_dialog.popup_centered()
	
	multiplayer.multiplayer_peer = peer
	
	hosting.emit()


func _on_cancel_pressed() -> void:
	hide()

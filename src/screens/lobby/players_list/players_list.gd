extends VBoxContainer


@export var others: VBoxContainer

@export var name_edit: LineEdit


func _ready() -> void:
	for peer in multiplayer.get_peers():
		add_player(peer)
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	name_edit.text = str(multiplayer.get_unique_id())


func add_player(peer: int) -> void:
	var label: RichTextLabel = RichTextLabel.new()
	label.text = "%s[i]#%s[/i]" % [str(peer), str(peer)]
	label.fit_content = true
	label.bbcode_enabled = true
	label.set_meta("id", peer)
	others.add_child(label)
	update_player_name.rpc(name_edit.text)


func remove_player(peer: int) -> void:
	for child in others.get_children():
		if child.get_meta("id") == peer:
			child.queue_free()
			break


@rpc("any_peer", "call_remote", "reliable")
func update_player_name(new_name: String) -> void:
	var peer = multiplayer.get_remote_sender_id()
	
	for child in others.get_children():
		if child.get_meta("id") == peer:
			(child as RichTextLabel).text = "%s[i]#%s[/i]" % [new_name, str(peer)]
			break


func _on_name_edit_text_changed(new_text: String) -> void:
	var valid_text = RegexFacade.only_alpha(new_text)
	
	# Avoid reseting cursor position to 0 every time the text change.
	if new_text != valid_text:
		name_edit.text = valid_text
	
	update_player_name.rpc(name_edit.text)

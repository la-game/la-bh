class_name RegexFacade
extends RefCounted


static func only_numbers(text: String) -> String:
	var regex = RegEx.new()
	
	regex.compile("[^0-9]")
	
	return regex.sub(text, "", true)


static func only_alpha(text: String) -> String:
	var regex = RegEx.new()
	
	regex.compile("[^0-9a-zA-Z]")
	
	return regex.sub(text, "", true)

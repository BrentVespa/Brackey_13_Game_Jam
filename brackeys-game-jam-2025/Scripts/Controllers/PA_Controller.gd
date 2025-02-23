extends Node


func _worldEventReference():
	var PA = get_tree().get_first_node_in_group("PA").get_child(0)
	match EventBus.WorldState:
		0:
			EventBus._failState()
		1:
			print("Cutsene Playing")
		2:
			PA.text = "System Booting, beep beep beep, life signs detected, backup system booting, boop boop beep."
			PA.get_parent().show()
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Scanning Sectors for Danger"
			PA.get_parent().show()
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().show()
			PA.text = "Hostile Found 5 [Sljadjaojdsj] away"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().hide()
		3:
			PA.text = "Scanning Sectors for Danger"
			PA.get_parent().show()
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Hostile Found 4 [Sljadjaojdsj] away"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().hide()
		4:
			PA.text = "Scanning Sectors for Danger"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Hostile Found 2 [Zlfajkf] away"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().hide()
		5:
			PA.text = "Scanning Sectors for Danger"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Hostile Found 1 [OiyfdaASKLDHasjadf] away"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().hide()
		6:
			PA.text = "Scanning Sectors for Danger"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Hostiles Cannot Be Found"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.text = "Recalculating"
			await get_tree().create_timer(EventBus.textTime * 5).timeout
			PA.text = "Hostiles Found 5 [akdfhalkjdhfak] away"
			await get_tree().create_timer(EventBus.textTime).timeout
			PA.get_parent().hide()

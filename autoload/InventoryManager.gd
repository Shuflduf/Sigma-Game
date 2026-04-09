#brain of inventory
#access - InventoryManager.add_item(item_data)

extends Node

const maxSlots = 16
const weight: float = 100.0 #if we are going to limit inventory capacity by weight

signal inventoryUpdated()           
signal itemAdded(item: ItemData, slot_index: int)
signal itemRemove(item: ItemData, slot_index: int)
signal itemUse(item: ItemData)
signal itemEquip(item: ItemData)
signal itemUnequip(item: ItemData)
signal inventoryFull()

var slots: Array[Dictionary] = []               #equippable items
var equipped: Dictionary = {
	"hand": null,
	"head": null,
	"legs": null,
	"face": null
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initializeSlots()
	
func _initializeSlots() -> void:
	slots.clear()
	for i in maxSlots:
		slots.append({"item": null, "quantity": 0})

func addItem(item: ItemData, quantity: int = 1) -> bool:
	if item == null:
		push_warning("Tried to add an invalid item")
		return false
	
	if item.stackable:
		for i in slots.size():
			var slot = slots[i]
			if slot["item"] != null and slot["item"].id == item.id:
				var space_in_slot = item.max_stack_size - slot["quantity"]
				if space_in_slot > 0:
					var to_add = min(quantity, space_in_slot)
					slots[i]["quantity"] += to_add
					quantity -= to_add
					emit_signal("item_added", item, i)
					emit_signal("inventory_changed")
					if quantity <= 0:
						return true

	while quantity > 0:
		var empty = findEmptySlot()
		if empty == -1:
			emit_signal("inventory_full")
			return false
		var to_add = min(quantity, item.max_stack_size if item.stackable else 1)
		slots[empty] = { "item": item, "quantity": to_add }
		quantity -= to_add
		emit_signal("item_added", item, empty)
		emit_signal("inventory_changed")

	return true

func removeItemAt(slotIndex: int, quantity: int = 1) -> bool:
	if not validSlot(slotIndex):
		return false
	var slot = slots[slotIndex]
	if slot["item"] == null:
		return false

	var item = slot["item"]
	var remove = min(quantity, slot["quantity"])
	slots[slotIndex]["quantity"] -= remove
	
	if slots[slotIndex]["quantity"] <= 0:
		emit_signal("item removed", item, slotIndex)
		slots[slotIndex] = { "item": null, "quantity": 0 }

	emit_signal("inventory_changed")
	return true
	
func removeItemByID(itemID: String, quantity: int = 1) -> bool:
	for i in slots.size():
		if slots[i]["item"] != null and slots[i]["item"].id == itemID:
			return removeItemAt(i, quantity)
	return false
	
func swapSlots(fromIndex: int, toIndex: int) -> void:
	if not validSlot(fromIndex) or not validSlot(toIndex):
		return
	var temp = slots[fromIndex].duplicate()
	slots[fromIndex] = slots[toIndex].duplicate()
	slots[toIndex] = temp
	emit_signal("inventory changed")
	
func useItem(slotIndex: int, targetNode: Node = null) -> void:
	if not validSlot(slotIndex):
		return
	var item = slots[slotIndex]["item"]
	if item == null or not item.usable:
		return

	emit_signal("item used", item)

	#Add more
	#Example: heal the player
	if item.item_type == ItemData.itemType.CONSUMABLE and item.heal_amount > 0:
		if targetNode and targetNode.has_method("heal"):
			targetNode.heal(item.heal_amount)
	# ──────────────────────────────────────────────────────────────────────────

	if item.consumed_on_use:
		removeItemAt(slotIndex, 1)
	else:
		emit_signal("inventory changed")
		
func equipItem(slotIndex: int) -> void:
	if not validSlot(slotIndex):
		return
	var item = slots[slotIndex]["item"]
	if item == null or not item.equippable:
		return

	var equipSlot = item.equipSlot
	if not equipped.has(equipSlot):
		push_warning("InventoryManager: Unknown slot: " + equipSlot)
		return

	# Unequip current item in that slot
	if equipped[equipSlot] != null:
		unequipSlot(equipSlot)

	equipped[equipSlot] = item
	emit_signal("item equipped", item)
	emit_signal("inventory changed")
	
func unequipSlot(equipSlot: String) -> void:
	if not equipped.has(equipSlot) or equipped[equipSlot] == null:
		return
	var item = equipped[equipSlot]
	equipped[equipSlot] = null
	emit_signal("item unequipped", item)
	emit_signal("inventory changed")
	
func hasItem(itemID: String, quantity: int = 1) -> bool:
	var count = 0
	for slot in slots:
		if slot["item"] != null and slot["item"].id == itemID:
			count += slot["quantity"]
			if count >= quantity:
				return true
	return false
	
func getItemCount(itemID: String) -> int:
	var count = 0
	for slot in slots:
		if slot["item"] != null and slot["item"].id == itemID:
			count += slot["quantity"]
	return count
	
func emptySlot(index: int) -> bool:
	return validSlot(index) and slots[index]["item"] == null

func getEquipped(equipSlot: String) -> ItemData:
	return equipped.get(equipSlot, null)

#Add the items to the registry with their paths here
const SAVE_PATH = "user://inventory_save.json"

#var ItemRegistry: Dictionary = {
	#
#}

func saveInventory() -> void:
	var data = []
	for slot in slots:
		if slot["item"] != null:
			data.append({ "id": slot["item"].id, "qty": slot["quantity"] })
		else:
			data.append({ "id": "", "qty": 0 })
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		
func load_inventory() -> void:
	# Uncomment and fill registry above before using this.
	pass
	
func findEmptySlot() -> int:
	for i in slots.size():
		if slots[i]["item"] == null:
			return i
	return -1

func validSlot(index: int) -> bool:
	return index >= 0 and index < slots.size()

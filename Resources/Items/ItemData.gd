#use .tres files for each item. This is a resource script

class_name ItemData
extends Resource

@export var id: String = ""                   # ID: "AK47"
@export var displayName: String = "AK47"     # Shown in UI
@export var description: String = ""          
@export var icon: Texture2D = null

enum itemType {WEAPON, CONSUMABLE, TOOL, MISC, KEY} #key is like an item needed to proceed 
@export var items: itemType

@export_group("Stats")
@export var dmg: int = 0
@export var def: int = 0
@export var heal: int = 0
@export var value: int = 0        #money?

@export_group("World")
@export var scene: PackedScene = null  #make the scene of the item lying in the world

@export_group("Equipment")
@export var equippable: bool = false

@export_group("Consumable")
@export var usable: bool = false
@export var animation: String = ""
@export var consumed: bool = false

#adding item:
#right click blank space near files > New resource > ItemData

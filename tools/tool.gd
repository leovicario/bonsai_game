class_name Tool
extends Resource

enum ActionType { WATER, TRIM, PICKUP, NONE }

@export var tool_name: String = ""
@export var icon: Texture2D
@export var action_type: ActionType = ActionType.NONE

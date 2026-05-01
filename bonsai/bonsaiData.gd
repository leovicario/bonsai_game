extends Resource
class_name bonsaiData

enum Stage { SEEDLING, YOUNG, MATURE }

@export var sprite: Texture2D
@export var species: String = "Bonsai"
@export_range(0, 100, 1) var sun: float = 50
@export_range(-20.0, 45.0, 0.1) var temperature: float = 15.0
@export_range(0, 100, 1) var water: float = 50
@export_range(0, 100, 1) var health: float = 100
@export var stage: Stage = Stage.SEEDLING
@export_range(0,100,1) var growth: float = 0

@export var data: bonsaiData

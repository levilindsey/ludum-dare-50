class_name LevelSession
extends SurfacerLevelSession
# NOTE: Don't store references to nodes that should be destroyed with the
#       level, because this session-state will persist after the level is
#       destroyed.


const START_ENERGY := 1000


var total_energy := START_ENERGY
var current_energy := START_ENERGY


func reset(id: String) -> void:
    .reset(id)
    total_energy = START_ENERGY
    current_energy = START_ENERGY

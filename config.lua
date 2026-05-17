Config = {}

-- Framework : 'esx' | 'qb' | 'qbox'
Config.Framework = 'qb'
-- ESXMode : 'old' | 'new'  (ignoré si Framework != 'esx')
Config.ESXMode   = 'new'

Config.BikeModels = {
    'bmx',
    'cruiser',
    'fixter',
    'scorcher',
    'tribike',
    'tribike2',
    'tribike3'
}

Config.Animations = {
    Dict = 'mini@repair',
    Name = 'fixing_a_ped',
    Duration = {
        Spawn  = 1000,
        Pickup = 1500
    }
}

Config.Target = {
    Name  = 'pickup_bike',
    Icon  = 'fas fa-bicycle',
    Label = 'Ramasser le vélo'
}

Config.Delays = {
    VehicleStabilization = 500,
    EntityLoadCheck      = 0
}

Config.Messages = {
    InventoryFull = "Vous n'avez pas assez de place dans votre inventaire.",
    BikeRespawned = "Votre inventaire est plein. Le vélo a été replacé."
}

Config.Respawn = {
    Distance = 1.0
}

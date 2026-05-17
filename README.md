# 22_bikes

An interactive bike system for FiveM, compatible with ESX (old/new), QBCore and QBox.

## Features

- Spawn bikes from inventory items
- Pick up bikes and store them back in inventory via ox_target
- Automatic respawn if inventory is full
- Configurable bike models and animations
- ESX (old/new), QBCore and QBox support out of the box

## Dependencies

- [ox_inventory](https://github.com/overextended/ox_inventory)
- [ox_target](https://github.com/overextended/ox_target)
- **ESX**: [es_extended](https://github.com/esx-framework/esx_core) — or **QBCore/QBox**: [qb-core](https://github.com/qbcore-framework/qb-core)

## Installation

1. Place the `22_bikes` folder in your `resources/` directory
2. Add `ensure 22_bikes` to your `server.cfg`
3. Import bike items into ox_inventory (see `items/items.txt`)
4. Configure `config.lua`

## Configuration

### Framework

```lua
-- 'esx' | 'qb' | 'qbox'
Config.Framework = 'qb'
-- 'old' | 'new'  (ignored if Framework ~= 'esx')
Config.ESXMode   = 'new'
```

### Bike Models

```lua
Config.BikeModels = {
    'bmx',
    'cruiser',
    'fixter',
    'scorcher',
    'tribike',
    'tribike2',
    'tribike3'
}
```

### Animations

```lua
Config.Animations = {
    Dict = 'mini@repair',
    Name = 'fixing_a_ped',
    Duration = {
        Spawn  = 1000,  -- ms before spawn
        Pickup = 1500   -- ms before storing
    }
}
```

### Messages

```lua
Config.Messages = {
    InventoryFull = "You don't have enough space in your inventory.",
    BikeRespawned = "Your inventory is full. The bike has been placed back."
}
```

## Usage

| Action | How |
|--------|-----|
| Spawn a bike | Use the bike item from your inventory |
| Store a bike | Target the bike with ox_target → *Pick up bike* |
| Inventory full | The bike is automatically placed back in front of the player |

## File Structure

```
22_bikes/
├── fxmanifest.lua
├── config.lua
├── bridge/
│   ├── client.lua   ← framework abstraction (ESX/QB/QBox)
│   └── server.lua
├── client/
│   └── client.lua
├── server/
│   └── server.lua
└── items/
    ├── items.txt
    └── img/
```

## Credits

**22scripts, xLaugh**

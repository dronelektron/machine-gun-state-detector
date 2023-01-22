# Machine gun state detector

Allows you to detect machine gun deploying/undeploying

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/machine-gun-state-detector/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "gamedata" folders to "addons/sourcemod" folder of your server

### API

Called when the machine gun's state has changed

* client - Index of the client whose machine gun state has changed
* isDeployed - Is the machine gun deployed or undeployed

```
forward void OnMachineGunStateChanged(int client, bool isDeployed);
```

### Usage example

```
#include <sourcemod>

#define MACHINE_GUN_STATE_DETECTOR "machine-gun-state-detector"

public Plugin myinfo = {
    name = "MG state notifier",
    author = "Dron-elektron",
    description = "Prints a message to the player when the state of the machine gun has changed",
    version = "",
    url = ""
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(MACHINE_GUN_STATE_DETECTOR)) {
        SetFailState("Library '%s' is not found", MACHINE_GUN_STATE_DETECTOR);
    }
}

public void OnMachineGunStateChanged(int client, bool isDeployed) {
    PrintToChat(client, "Machine gun deployed - %s", isDeployed ? "yes" : "no");
}

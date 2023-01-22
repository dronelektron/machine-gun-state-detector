#include <sourcemod>
#include <dhooks>

#include "mgsd/dynamic-hook"

#include "modules/api.sp"
#include "modules/dynamic-hook.sp"

public Plugin myinfo = {
    name = "Machine gun state detector",
    author = "Dron-elektron",
    description = "Allows you to detect machine gun deploying/undeploying",
    version = "1.0.0",
    url = "https://github.com/dronelektron/machine-gun-state-detector"
};

public APLRes AskPluginLoad2(Handle plugin, bool late, char[] error, int errorMax) {
    RegPluginLibrary("machine-gun-state-detector");

    return APLRes_Success;
}

public void OnPluginStart() {
    Api_Create();
    DynamicHook_Create();
}

public void OnPluginEnd() {
    Api_Destroy();
    DynamicHook_Destroy();
}

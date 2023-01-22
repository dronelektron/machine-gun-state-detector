static Handle g_deployBipod = null;
static Handle g_undeployBipod = null;

void DynamicHook_Create() {
    Handle gameConfig = LoadGameConfigFile(GAME_CONFIG);

    if (gameConfig != null) {
        DynamicHook_CreateDeployBipod(gameConfig);
        DynamicHook_CreateUndeployBipod(gameConfig);
        CloseHandle(gameConfig);
    }
}

void DynamicHook_Destroy() {
    DHookDisableDetour(g_deployBipod, POST_YES, DynamicHook_DeployBipod);
    DHookDisableDetour(g_undeployBipod, POST_YES, DynamicHook_UndeployBipod);

    delete g_deployBipod;
    delete g_undeployBipod;
}

void DynamicHook_CreateDeployBipod(Handle gameConfig) {
    g_deployBipod = DHookCreateFromConf(gameConfig, FUNCTION_DEPLOY_BIPOD);

    if (g_deployBipod == null) {
        SetFailState("Unable to hook '%s' function", FUNCTION_DEPLOY_BIPOD);
    }

    DHookEnableDetour(g_deployBipod, POST_YES, DynamicHook_DeployBipod);
}

void DynamicHook_CreateUndeployBipod(Handle gameConfig) {
    g_undeployBipod = DHookCreateFromConf(gameConfig, FUNCTION_UNDEPLOY_BIPOD);

    if (g_undeployBipod == null) {
        SetFailState("Unable to hook '%s' function", FUNCTION_UNDEPLOY_BIPOD);
    }

    DHookEnableDetour(g_undeployBipod, POST_YES, DynamicHook_UndeployBipod);
}

public MRESReturn DynamicHook_DeployBipod(int weapon) {
    int client = DynamicHook_GetWeaponOwner(weapon);

    Api_OnMachineGunStateChanged(client, DEPLOYED_YES);

    return MRES_Ignored;
}

public MRESReturn DynamicHook_UndeployBipod(int weapon) {
    int client = DynamicHook_GetWeaponOwner(weapon);

    Api_OnMachineGunStateChanged(client, DEPLOYED_NO);

    return MRES_Ignored;
}

static int DynamicHook_GetWeaponOwner(int weapon) {
    return GetEntPropEnt(weapon, Prop_Send, "m_hOwnerEntity");
}

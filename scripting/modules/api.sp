static GlobalForward g_onMachineGunStateChanged = null;

void Api_Create() {
    g_onMachineGunStateChanged = new GlobalForward("OnMachineGunStateChanged", ET_Ignore, Param_Cell, Param_Cell, Param_Cell);
}

void Api_Destroy() {
    delete g_onMachineGunStateChanged;
}

void Api_OnMachineGunStateChanged(int client, int weapon, bool isDeployed) {
    Call_StartForward(g_onMachineGunStateChanged);
    Call_PushCell(client);
    Call_PushCell(weapon);
    Call_PushCell(isDeployed);
    Call_Finish();
}

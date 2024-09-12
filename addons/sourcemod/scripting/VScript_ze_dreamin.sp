#include <sourcemod>
#include <sdktools>
#include <multicolors>

#pragma semicolon 1
#pragma newdecls required

bool g_bDream_V2 = false;
bool g_bDream_V3 = false;

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public Plugin myinfo =
{
	name        = "ze_dreamin VScript",
	author      = "Neon, .Rushaway",
	description = "",
	version     = "2.0.1",
	url         = "https://steamcommunity.com/id/n3ontm"
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void OnPluginStart()
{
	HookEvent("round_start",  OnRoundStart);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void OnMapStart()
{
	g_bDream_V2 = false;
	g_bDream_V3 = false;
	VerifyMap();
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void VerifyMap()
{
	char sCurrentMap[64];
	GetCurrentMap(sCurrentMap, sizeof(sCurrentMap));

	char sMapName[255] = "ze_dreamin_v2";
	if (strncmp(sCurrentMap, sMapName, strlen(sMapName), false) == 0)
		g_bDream_V2 = true;

	sMapName = "ze_dreamin_v3";
	if (strncmp(sCurrentMap, sMapName, strlen(sMapName), false) == 0)
		g_bDream_V3 = true;

	if (!g_bDream_V2 && !g_bDream_V3)
	{
		char sFilename[256];
		GetPluginFilename(INVALID_HANDLE, sFilename, sizeof(sFilename));
		ServerCommand("sm plugins unload %s", sFilename);
	}
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void OnRoundStart(Event hEvent, const char[] sEvent, bool bDontBroadcast)
{
	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("reflect_logic");
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnFalse", st3_hitbox_reflect, false);

	iEntity = FindEntityByTargetName("upline_timer");
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnTimer", upline_maker_upline, false);

	iEntity = FindEntityByTargetName("explo_timer");
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnTimer", explo_maker_setan, false);

	// These entity are only available in ze_dreamin_v3
	if (g_bDream_V3)
	{
		iEntity = FindEntityByTargetName("rtv_laser_timer");
		if (iEntity != INVALID_ENT_REFERENCE)
			HookSingleEntityOutput(iEntity, "OnTimer", rtv_laser_timer, false);

		iEntity = FindEntityByTargetName("rtv_th_timer");
		if (iEntity != INVALID_ENT_REFERENCE)
			HookSingleEntityOutput(iEntity, "OnTimer", rtv_th_timer, false);

		iEntity = FindEntityByTargetName("case_1");
		if (iEntity != INVALID_ENT_REFERENCE)
		{
			HookSingleEntityOutput(iEntity, "OnCase01", sbomb_1_Case01, false);
			HookSingleEntityOutput(iEntity, "OnCase02", sbomb_1_Case02, false);
			HookSingleEntityOutput(iEntity, "OnCase03", sbomb_1_Case03, false);
			HookSingleEntityOutput(iEntity, "OnCase04", sbomb_1_Case04, false);
		}

		iEntity = FindEntityByTargetName("case_2");
		if (iEntity != INVALID_ENT_REFERENCE)
		{
			HookSingleEntityOutput(iEntity, "OnCase01", sbomb_2_Case01, false);
			HookSingleEntityOutput(iEntity, "OnCase02", sbomb_2_Case02, false);
			HookSingleEntityOutput(iEntity, "OnCase03", sbomb_2_Case03, false);
			HookSingleEntityOutput(iEntity, "OnCase04", sbomb_2_Case04, false);
		}

		iEntity = FindEntityByTargetName("case_3");
		if (iEntity != INVALID_ENT_REFERENCE)
		{
			HookSingleEntityOutput(iEntity, "OnCase01", sbomb_3_Case01, false);
			HookSingleEntityOutput(iEntity, "OnCase02", sbomb_3_Case02, false);
			HookSingleEntityOutput(iEntity, "OnCase03", sbomb_3_Case03, false);
			HookSingleEntityOutput(iEntity, "OnCase04", sbomb_3_Case04, false);
		}
	}
 
	iEntity = FindEntityByTargetName("linelaser_random");
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		HookSingleEntityOutput(iEntity, "OnCase01", linelaser_maker_left, false);
		HookSingleEntityOutput(iEntity, "OnCase02", linelaser_maker_right, false);
	}

	iEntity = FindEntityByTargetName("totem_random");
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		HookSingleEntityOutput(iEntity, "OnCase01", push_maker_setrandom, false);
		HookSingleEntityOutput(iEntity, "OnCase02", heal_maker_setrandom, false);
		HookSingleEntityOutput(iEntity, "OnCase03", stable_maker_setrandom, false);
		HookSingleEntityOutput(iEntity, "OnCase04", rotate_maker_setrandom, false);
	}

	iEntity = FindEntityByTargetName("spike_timer");
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnTimer", spike_maker_top, false);

	iEntity = FindEntityByHammerID(389450);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_389450_display, false);

	iEntity = FindEntityByHammerID(385777);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_385777_display, false);

	iEntity = FindEntityByHammerID(385886);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_385886_display, false);

	iEntity = FindEntityByHammerID(386004);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_386004_display, false);

	if (g_bDream_V2)
	{
		iEntity = FindEntityByHammerID(381396);
		if (iEntity != INVALID_ENT_REFERENCE)
			HookSingleEntityOutput(iEntity, "OnPressed", func_button_381396_display, false);
	}

	iEntity = FindEntityByHammerID(381463);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_381463_display, false);

	iEntity = FindEntityByHammerID(381581);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_381581_display, false);

	iEntity = FindEntityByHammerID(381648);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_381648_display, false);

	iEntity = FindEntityByHammerID(378212);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_378212_display, false);

	iEntity = FindEntityByHammerID(375007);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_375007_display, false);

	iEntity = FindEntityByHammerID(241061);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnPressed", func_button_241061_display, false);

	iEntity = FindEntityByHammerID(213033);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_213033_display, false);

	iEntity = FindEntityByHammerID(142829);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_142829_display, false);

	iEntity = FindEntityByHammerID(95608);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_95608_display, false);

	iEntity = FindEntityByHammerID(95733);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_95733_display, false);

	iEntity = FindEntityByHammerID(95823);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_95823_display, false);

	iEntity = FindEntityByHammerID(77927);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnPressed", func_button_77927_display, false);

	iEntity = FindEntityByHammerID(23408);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_23408_display, false);

	iEntity = FindEntityByHammerID(23452);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_23452_display, false);

	iEntity = FindEntityByHammerID(23474);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_23474_display, false);

	iEntity = FindEntityByHammerID(579052);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnStartTouch", trigger_once_579052_display, false);

	iEntity = FindEntityByHammerID(23551);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnBreak", func_breakable_23551_display, false);

	iEntity = FindEntityByHammerID(21950);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnPressed", func_button_21950_display, false);

	iEntity = FindEntityByHammerID(22017);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnPressed", func_button_22017_display, false);

	iEntity = FindEntityByHammerID(3664);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnBreak", func_breakable_3664_display, false);

	iEntity = FindEntityByHammerID(11288);
	if (iEntity != INVALID_ENT_REFERENCE)
		HookSingleEntityOutput(iEntity, "OnHitMin", math_counter_11288_display, false);

	CreateTimer(12.0, Credits, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public Action Credits(Handle timer)
{
	CPrintToChatAll("{pink}[VScripts] {white}Map using VScripts ported by Neon™");
	return Plugin_Stop;
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void st3_hitbox_reflect(const char[] output, int caller, int activator, float delay)
{
	if (!IsValidClient(activator))
		return;

	int iHealth = GetClientHealth(activator);

	if(iHealth > 10)
	{
		SetEntityHealth(activator, iHealth - 10);
	}
	else
	{
		SetEntityHealth(activator, 1);
	}
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void upline_maker_upline(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(-1280.0, 1280.0);
	fOrigin[1] = GetRandomFloat(-1280.0, 1280.0);
	fOrigin[2] = -2780.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("upline_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void explo_maker_setan(const char[] output, int caller, int activator, float delay)
{
	float fAngles[3];
	fAngles[0] = 0.0;
	fAngles[1] = GetRandomFloat(0.0, 359.0);
	fAngles[2] = 0.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("explo_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, NULL_VECTOR, fAngles, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void linelaser_maker_left(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = 0.0;
	fOrigin[1] = GetRandomFloat(-640.0, 640.0);
	fOrigin[2] = -1780.0;

	float fAngles[3];
	fAngles[0] = 0.0;
	fAngles[1] = 0.0;
	fAngles[2] = 0.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("linelaser_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, fAngles, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void linelaser_maker_right(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = 0.0;
	fOrigin[1] = GetRandomFloat(-640.0, 640.0);
	fOrigin[2] = -1820.0;

	float fAngles[3];
	fAngles[0] = 0.0;
	fAngles[1] = 90.0;
	fAngles[2] = 0.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("linelaser_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, fAngles, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void push_maker_setrandom(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(-768.0, 768.0);
	fOrigin[1] = GetRandomFloat(-768.0, 768.0);
	fOrigin[2] = -2720.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("push_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void heal_maker_setrandom(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(-768.0, 768.0);
	fOrigin[1] = GetRandomFloat(-768.0, 768.0);
	fOrigin[2] = -2720.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("heal_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void stable_maker_setrandom(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(-768.0, 768.0);
	fOrigin[1] = GetRandomFloat(-768.0, 768.0);
	fOrigin[2] = -2720.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("stable_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void rotate_maker_setrandom(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(-768.0, 768.0);
	fOrigin[1] = GetRandomFloat(-768.0, 768.0);
	fOrigin[2] = -2720.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("rotate_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void spike_maker_top(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(12090.0, 14363.0);
	fOrigin[1] = GetRandomFloat(1280.0, 3560.0);
	fOrigin[2] = 1500.0;

	int iEntity = INVALID_ENT_REFERENCE;

	iEntity = FindEntityByTargetName("spike_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
		AcceptEntityInput(iEntity, "ForceSpawn");
	}
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void rtv_laser_timer(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(6300.0, 8350.0);
	fOrigin[1] = GetRandomFloat(-1850.0, 220.0);
	fOrigin[2] = -610.0;
 
	float fAngles[3];
	fAngles[0] = 0.0;
	fAngles[1] = GetRandomFloat(0.0, 359.0);
	fAngles[2] = 0.0;
 
	int iEntity = INVALID_ENT_REFERENCE;
 
	iEntity = FindEntityByTargetName("rtv_laser_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		TeleportEntity(iEntity, fOrigin, fAngles, NULL_VECTOR);
		AcceptEntityInput(iEntity, "ForceSpawn");
	}
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void rtv_th_timer(const char[] output, int caller, int activator, float delay)
{
	float fOrigin[3];
	fOrigin[0] = GetRandomFloat(6300.0, 8350.0);
	fOrigin[1] = GetRandomFloat(-1850.0, 220.0);
	fOrigin[2] = -610.0;
 
	int iEntity = INVALID_ENT_REFERENCE;
 
	iEntity = FindEntityByTargetName("rtv_th_maker");
	if (iEntity != INVALID_ENT_REFERENCE)
	{
		TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
		AcceptEntityInput(iEntity, "ForceSpawn");
	}
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_1_Case01(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_1");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_1_Case02(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_1");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, -300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_1_Case03(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_1");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, 300.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_1_Case04(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_1");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, -300.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_2_Case01(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_2");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_2_Case02(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_2");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, -300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_2_Case03(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_2");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, 300.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_2_Case04(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_2");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, -300.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_3_Case01(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_3");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_3_Case02(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_3");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, -300.0, 0.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_3_Case03(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_3");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, 300.0);
}
 
//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void sbomb_3_Case04(const char[] output, int caller, int activator, float delay)
{
	int iEntity = INVALID_ENT_REFERENCE;
	iEntity = FindEntityByTargetName("sbomb_3");
 
	if (iEntity != INVALID_ENT_REFERENCE)
		run(iEntity, 0.0, -300.0);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_389450_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_385777_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_385886_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_386004_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_button_381396_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_381463_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(30);
	else
		Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_381581_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(50);
	else
		Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_381648_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_378212_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(30);
	else
		Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_375007_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(20);
	else
		Display(15);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_button_241061_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_213033_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_142829_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_95608_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_95733_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_95823_display(const char[] output, int caller, int activator, float delay)
{
	if (g_bDream_V2)
		Display(30);
	else
		Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_button_77927_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_23408_display(const char[] output, int caller, int activator, float delay)
{
	Display(35);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_23452_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_23474_display(const char[] output, int caller, int activator, float delay)
{
	Display(25);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void trigger_once_579052_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_breakable_23551_display(const char[] output, int caller, int activator, float delay)
{
	Display(20);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_button_21950_display(const char[] output, int caller, int activator, float delay)
{
	Display(30);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_button_22017_display(const char[] output, int caller, int activator, float delay)
{
	Display(10);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void func_breakable_3664_display(const char[] output, int caller, int activator, float delay)
{
	Display(45);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void math_counter_11288_display(const char[] output, int caller, int activator, float delay)
{
	Display(51);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void Display(int iTimer)
{
	int iRelay = CreateEntityByName("logic_relay");
	DispatchKeyFormat(iRelay, "targetname",     "vscript_countdown_relay");
	DispatchKeyFormat(iRelay, "spawnflags",     "0");
	DispatchKeyFormat(iRelay, "OnSpawn",        "seconds_left,AddOutput,message      seconds left,0,-1");
	DispatchKeyFormat(iRelay, "OnSpawn",        "text_sec,AddOutput,message %d,0,-1", iTimer - 1);

	int iBackup = iTimer;
	for (int j = 0; j <= iTimer; j++)
	{
		iBackup--;
		DispatchKeyFormat(iRelay, "OnSpawn",    "text_sec,AddOutput,message %d,%d,-1", iBackup, j);
		DispatchKeyFormat(iRelay, "OnSpawn",    "seconds_left,Display,,%d,-1", j);
		DispatchKeyFormat(iRelay, "OnSpawn",    "text_sec,Display,,%d,-1", j);
	}

	DispatchKeyFormat(iRelay, "OnSpawn",        "seconds_left,AddOutput,message    ,%d,-1", iTimer + 1);
	DispatchKeyFormat(iRelay, "OnSpawn",        "text_sec,AddOutput,message    ,%d,-1", iTimer + 1);
	DispatchKeyFormat(iRelay, "OnSpawn",        "!self,Kill,,%d,-1", iTimer + 2);
	SpawnAndActivate(iRelay);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public void run(int iEntity, float fX1, float fY1)
{
	float fOrigin[3];
	GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fOrigin);
	fOrigin[0] += fX1;
	fOrigin[1] += fY1;
 
	if (fOrigin[0] > 8300.0 || fOrigin[1] > 150.0 || fOrigin[0] < -1800.0 || fOrigin[1] < -5194.0)
	{
		fOrigin[0] = 7312.0;
		fOrigin[1] = -816.0;
		fOrigin[2] = -634.0;
	}
 
	TeleportEntity(iEntity, fOrigin, NULL_VECTOR, NULL_VECTOR);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public int FindEntityByTargetName(const char[] sTargetnameToFind)
{
	int iEntity = INVALID_ENT_REFERENCE;
	while((iEntity = FindEntityByClassname(iEntity, "*")) != INVALID_ENT_REFERENCE)
	{
		char sTargetname[64];
		GetEntPropString(iEntity, Prop_Data, "m_iName", sTargetname, sizeof(sTargetname));

		if (strcmp(sTargetnameToFind, sTargetname, false) == 0)
		{
			return iEntity;
		}
	}

	PrintToChatAll("[VScripts] Error! Could not find entity: %s", sTargetnameToFind);
	return INVALID_ENT_REFERENCE;
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
public int FindEntityByHammerID(int iHammerID)
{
	int iEntity = INVALID_ENT_REFERENCE;
	while((iEntity = FindEntityByClassname(iEntity, "*")) != INVALID_ENT_REFERENCE)
	{
		if(GetEntProp(iEntity, Prop_Data, "m_iHammerID") == iHammerID)
		{
			return iEntity;
		}
	}

	PrintToChatAll("[VScripts] Error! Could not find entity: #%d", iHammerID);
	return INVALID_ENT_REFERENCE;
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
stock void DispatchKeyFormat(int entity, const char[] key, const char[] value, any ...)
{
	char buffer[1024];
	VFormat(buffer, sizeof(buffer), value, 4);

	DispatchKeyValue(entity, key, buffer);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
stock void SpawnAndActivate(int entity)
{
	DispatchSpawn(entity);
	ActivateEntity(entity);
}

//----------------------------------------------------------------------------------------------------
// Purpose:
//----------------------------------------------------------------------------------------------------
stock bool IsValidClient(int client)
{
	return (client > 0 && client <= MaxClients && IsClientInGame(client) && IsPlayerAlive(client));
}

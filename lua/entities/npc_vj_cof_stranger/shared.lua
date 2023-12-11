ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Stranger"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Cry Of Fear"

if (CLIENT) then
local Name = "Stranger"
local LangName = "npc_vj_cof_stranger"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end

---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
	net.Receive("vj_stranger_dodamage",function(len)
		local selfEntity = net.ReadEntity()
		local selfEntityEnemy = net.ReadEntity()
		if GetConVarNumber("vj_npc_sd_rangeattack") == 0 then selfEntityEnemy:EmitSound("stranger/st_hearbeat.wav") end
		//hook.Add("RenderScreenspaceEffects","vj)stranger_dodamgeeffect",function()
		//	DrawMaterialOverlay( "effects/tp_refract", -0.06 )
		//end)
		//timer.Simple(1,function()
		//hook.Remove("RenderScreenspaceEffects", "stranger_dodamgeeffect") DrawMaterialOverlay( "", 0 ) end)
	end)
end
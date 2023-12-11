AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/stranger/stranger.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_stranger_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.FootStepTimeRun = 0.8 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.8 -- Next foot step sound when it is walking
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 1.45 -- Time until the SNPC spawns its corpse and gets removed
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2500 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 2500 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 1 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "Regular" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Breath = {"stranger/st_voiceloop.wav"}
ENT.SoundTbl_Death = {"stranger/st_death.wav"}

ENT.FootStepSoundLevel = 75
ENT.BreathSoundLevel = 75
//ENT.RangeAttackSoundLevel = 100

-- Custom
ENT.Stranger_DamageDistance = 2500
ENT.Stranger_NextEnemyDamage = 0

util.AddNetworkString("vj_stranger_dodamage")
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(15, 15, 80), Vector(-15, -15, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Stranger_StartDmg()
	net.Start("vj_stranger_dodamage")
	net.WriteEntity(self)
	net.WriteEntity(self:GetEnemy())
	net.Broadcast()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	if self.Dead == true or GetConVarNumber("vj_npc_norange") == 1 then self.NoChaseAfterCertainRange = false return end
	//print(self:GetPos():Distance(self:GetEnemy():GetPos()))
	if self:GetPos():Distance(self:GetEnemy():GetPos()) > self.Stranger_DamageDistance or !self:Visible(self:GetEnemy()) then return end
	if CurTime() > self.Stranger_NextEnemyDamage then
		self:StopMoving()
		self:GetEnemy():TakeDamage(5,self,self)
		if self:GetEnemy():IsPlayer() then self:Stranger_StartDmg() end
	self.Stranger_NextEnemyDamage = CurTime() + 0.5
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
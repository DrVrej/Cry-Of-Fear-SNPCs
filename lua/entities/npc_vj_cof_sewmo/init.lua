AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/sewmo/sewmo.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_sewmo_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 110 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.3 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_sewmo_d_wired")
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Alert = {"sewmo/sewmo_alert10.wav","sewmo/sewmo_alert20.wav","sewmo/sewmo_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"sewmo/sewmo_attack1.wav","sewmo/sewmo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"sewmo/tunga_miss.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"sewmo/tunga_strike1.wav","sewmo/tunga_strike2.wav"}
ENT.SoundTbl_Pain = {"sewmo/sewmo_pain1.wav","sewmo/sewmo_pain2.wav"}
ENT.SoundTbl_Death = {"slower/scream1.wav"}

ENT.FootStepSoundLevel = 75

-- Custom
ENT.Sewmo_WireBroken = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.Sewmo_WireBroken == false && self.Dead == false && (self.StartHealth *.50 > self:Health()) then
		self.Sewmo_WireBroken = true
		self:VJ_ACT_PLAYACTIVITY(ACT_SIGNAL1,true,1,false)
		timer.Simple(0.3,function() if IsValid(self) then
			if self.HasSounds == true then VJ_EmitSound(self,"sewmo/break_free.wav") end end end)
			timer.Simple(1,function() if IsValid(self) then
				self:SetBodygroup(0,1) 
				self:DoChaseAnimation()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if self:GetBodygroup(0) == 0 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.SoundTbl_MeleeAttackMiss = {"sewmo/tunga_miss.wav"}
		self.SoundTbl_MeleeAttackExtra = {"sewmo/tunga_strike1.wav","sewmo/tunga_strike2.wav"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.493
		self.MeleeAttackExtraTimers = {}
	elseif self:GetBodygroup(0) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.SoundTbl_MeleeAttackMiss = {"sewmo/claw_miss1.wav","sewmo/claw_miss2.wav","sewmo/claw_miss3.wav"}
		self.SoundTbl_MeleeAttackExtra = {"sewmo/claw_strike1.wav","sewmo/claw_strike2.wav","sewmo/claw_strike3.wav"}
		self.TimeUntilMeleeAttackDamage = 0.55
		self.NextAnyAttackTime_Melee = 0.593
		self.MeleeAttackExtraTimers = {0.9}
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
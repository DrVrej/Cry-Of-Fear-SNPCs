AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/slower3/slower3.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_slower3_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.9 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_slower3_d_reg")
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIEBACKWARD} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Alert = {"slower3/slower_alert10.wav","slower3/slower_alert20.wav","slower3/slower_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"slower3/slower_attack1.wav","slower3/slower_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"slower/hammer_miss1.wav","slower/hammer_miss2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"slower/hammer_strike1.wav","slower/hammer_strike2.wav","slower/hammer_strike3.wav"}
ENT.SoundTbl_Pain = {"slower3/slower_pain1.wav","slower3/slower_pain2.wav"}
ENT.SoundTbl_Death = {"slower/scream1.wav"}

ENT.AlertSoundLevel = 90
ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(0,math.random(0,2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,4)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.TimeUntilMeleeAttackDamage = 0.7
		self.NextAnyAttackTime_Melee = 0.134
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower3_d_reg")
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
		self.TimeUntilMeleeAttackDamage = 0.85
		self.NextAnyAttackTime_Melee = 0.15
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower3_d_reg")
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack3"}
		self.TimeUntilMeleeAttackDamage = 0.55
		self.NextAnyAttackTime_Melee = 0.3389
		self.MeleeAttackExtraTimers = {0.8}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower3_d_dual")
	elseif randattack == 4 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack5"}
		self.TimeUntilMeleeAttackDamage = 0.53
		self.NextAnyAttackTime_Melee = 0.09
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower3_d_reg")
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
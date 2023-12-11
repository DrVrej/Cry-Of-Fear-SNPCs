AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/upper/upper.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_upper_h")
ENT.HullType = HULL_MEDIUM_TALL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.9 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_upper_d_reg")
ENT.FootStepTimeRun = 0.15 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.15 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Alert = {"upper/Sickscream.wav"}
ENT.SoundTbl_MeleeAttack = {"slower/slower_attack1.wav","slower/slower_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"faceless/fist_miss1.wav","faceless/fist_miss2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"faceless/fist_strike1.wav","faceless/fist_strike2.wav"}
ENT.SoundTbl_Pain = {"slower/slower_pain1.wav","slower/slower_pain2.wav"}
ENT.SoundTbl_Death = {"slower/scream1.wav"}

ENT.FootStepSoundLevel = 75
ENT.AlertSoundLevel = 80

-- Custom
ENT.Slower1_TypeOfBodyGroup = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(18, 18, 90), Vector(-18, -18, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,4)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.TimeUntilMeleeAttackDamage = 0.8
		self.NextAnyAttackTime_Melee = 0.2
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_upper_d_reg")
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack3"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.6
		self.MeleeAttackExtraTimers = {1}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_upper_d_dual")
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack4"}
		self.TimeUntilMeleeAttackDamage = 1.05
		self.NextAnyAttackTime_Melee = 0.274
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_upper_d_slow")
	elseif randattack == 4 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack5"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.262
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_upper_d_reg")
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
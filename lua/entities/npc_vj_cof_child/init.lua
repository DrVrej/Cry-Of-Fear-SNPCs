AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/children/children.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_child_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.7 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_child_d_stab")
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking
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
ENT.SoundTbl_Alert = {"children/child_alert10.wav","children/child_alert20.wav","children/child_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"children/child_attack1.wav","children/child_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"children/child_slash.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"children/child_slice.wav"}
ENT.SoundTbl_Pain = {"children/child_pain1.wav","children/child_pain2.wav"}
ENT.SoundTbl_Death = {"children/child_pain1.wav","children/child_pain2.wav"}

ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,2)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
		self.TimeUntilMeleeAttackDamage = 0.75
		self.NextAnyAttackTime_Melee = 0.25
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_child_d_stab")
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.TimeUntilMeleeAttackDamage = 0.6
		self.NextAnyAttackTime_Melee = 0.4
		self.MeleeAttackExtraTimers = {0.8}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_child_d_dual")
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
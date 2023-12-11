AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/psycho/psycho.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_phsycho_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 42 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 95 -- How far does the damage go?
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_phsycho_d")
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
ENT.SoundTbl_Alert = {"faster/faster_special.wav"}
ENT.SoundTbl_MeleeAttack = {"faceless/faceless_attack1.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"faster/faster_miss.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"faster/faster_hit1.wav","faster/faster_hit2.wav","faster/faster_hit3.wav","faster/faster_hit4.wav"}
ENT.SoundTbl_Pain = {"faster/faster_headhit1.wav","faster/faster_headhit2.wav","faster/faster_headhit3.wav","faster/faster_headhit4.wav"}
ENT.SoundTbl_Death = {"faster/faster_metalfall.wav"}

ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,3)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1_1"}
		self.TimeUntilMeleeAttackDamage = 0.35
		self.NextAnyAttackTime_Melee = 0.19
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1_2"}
		self.TimeUntilMeleeAttackDamage = 0.35
		self.NextAnyAttackTime_Melee = 0.26
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1_3"}
		self.TimeUntilMeleeAttackDamage = 0.35
		self.NextAnyAttackTime_Melee = 0.317
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
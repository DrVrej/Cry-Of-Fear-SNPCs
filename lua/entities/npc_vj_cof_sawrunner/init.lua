AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/sawrunner/sawrunner.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_sawrunner_h")
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 130 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.45 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.217 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_sawrunner_d")
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.3 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Breath = {"boss/sawer/chainsaw_loop.wav"}
ENT.SoundTbl_Alert = {"sawrunner/sawrunnerhello.wav"}
ENT.SoundTbl_MeleeAttack = {"sawrunner/sawrunner_attack1.wav","sawrunner/sawrunner_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"sawrunner/chainsaw_attack_miss.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"sawrunner/chainsaw_attack_hit.wav"}
ENT.SoundTbl_Pain = {"sawrunner/sawrunner_pain1.wav","sawrunner/sawrunner_pain2.wav"}
ENT.SoundTbl_Death = {"sawrunner/sawrunner_pain1.wav","sawrunner/sawrunner_pain2.wav"}

ENT.AlertSoundLevel = 100
ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 80), Vector(-20, -20, 0))
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
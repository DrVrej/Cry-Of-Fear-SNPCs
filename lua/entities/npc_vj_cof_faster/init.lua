AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/faster/faster.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_faster_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.3 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_faster_d")
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.25 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.25 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 6 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"faster/faster_step.wav"}
ENT.SoundTbl_Alert = {"faster/faster_alert1.wav","faster/faster_alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"faster/faster_attack.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"faster/faster_miss.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"faster/faster_hit1.wav","faster/faster_hit2.wav","faster/faster_hit3.wav","faster/faster_hit4.wav"}
ENT.SoundTbl_Pain = {"faster/faster_pain.wav"}
ENT.SoundTbl_Death = {"faster/faster_death.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,3)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1","vjseq_attack2"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.02
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_faster_d")
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack3"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.24
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_faster_d_double")
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack5"}
		self.TimeUntilMeleeAttackDamage = 0.85
		self.NextAnyAttackTime_Melee = 0.293
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_faster_d_jump")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	if self.HasSounds == false then return end
	timer.Simple(1.5,function()
		if IsValid(self) then
			VJ_EmitSound(self,"faster/faster_suicide.wav")
		end
	end)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
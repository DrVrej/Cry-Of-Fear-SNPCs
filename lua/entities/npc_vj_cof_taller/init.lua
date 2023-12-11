AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/taller/taller.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_taller_h")
ENT.HullType = HULL_MEDIUM_TALL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 70 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 180 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_taller_punch")
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 150 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 150 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 350 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 360 -- How far it will push you up | Second in math.random
ENT.FootStepTimeRun = 0.7 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.7 -- Next foot step sound when it is walking
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.NextWorldShakeOnRun = 0.7 -- How much time until the world shakes while it's running
ENT.NextWorldShakeOnWalk = 0.7 -- How much time until the world shakes while it's walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 18 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"taller/taller_step.wav"}
ENT.SoundTbl_Alert = {"taller/taller_alert.wav"}
ENT.SoundTbl_MeleeAttack = {"taller/taller_player_punch.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"taller/taller_swing.wav"}
ENT.SoundTbl_Pain = {"taller/taller_pain.wav"}
ENT.SoundTbl_Death = {"taller/taller_die.wav"}

ENT.AlertSoundLevel = 90
ENT.FootStepSoundLevel = 80
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 30, 170), Vector(-30, -30, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,2)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDistance = 70
		self.MeleeAttackDamageDistance = 150
		self.TimeUntilMeleeAttackDamage = 0.45
		self.NextAnyAttackTime_Melee = 1.217
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_taller_punch")
		self.MeleeAttackKnockBack_Forward1 = 150
		self.MeleeAttackKnockBack_Forward2 = 150
		self.MeleeAttackKnockBack_Up1 = 350
		self.MeleeAttackKnockBack_Up2 = 360
		self.MeleeAttackWorldShakeOnMiss = false
		self.SoundTbl_MeleeAttack = {"taller/taller_player_punch.wav"}
		self.SoundTbl_MeleeAttackMiss = {"taller/taller_swing.wav"}
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDistance = 50
		self.MeleeAttackDamageDistance = 120
		self.TimeUntilMeleeAttackDamage = 1.25
		self.NextAnyAttackTime_Melee = 0.75
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_taller_stomp")
		self.MeleeAttackKnockBack_Forward1 = 50
		self.MeleeAttackKnockBack_Forward2 = 50
		self.MeleeAttackKnockBack_Up1 = 350
		self.MeleeAttackKnockBack_Up2 = 360
		self.MeleeAttackWorldShakeOnMiss = true
		self.MeleeAttackWorldShakeOnMissAmplitude = 5
		self.MeleeAttackWorldShakeOnMissRadius = 800
		self.MeleeAttackWorldShakeOnMissDuration = 0.7
		self.MeleeAttackWorldShakeOnMissFrequency = 100
		self.SoundTbl_MeleeAttack = {"taller/taller_stamp.wav"}
		self.SoundTbl_MeleeAttackMiss = {"taller/taller_player_impact.wav"}
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
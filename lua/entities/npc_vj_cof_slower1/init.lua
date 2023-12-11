AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/slower1/slower.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_slower1_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.9 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_reg")
ENT.FootStepTimeRun = 0.25 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.25 -- Next foot step sound when it is walking
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
ENT.SoundTbl_Alert = {"slower/slower_alert10.wav","slower/slower_alert20.wav","slower/slower_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"slower/slower_attack1.wav","slower/slower_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"slower/hammer_miss1.wav","slower/hammer_miss2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"slower/hammer_strike1.wav","slower/hammer_strike2.wav","slower/hammer_strike3.wav"}
ENT.SoundTbl_Pain = {"slower/slower_pain1.wav","slower/slower_pain2.wav"}
ENT.SoundTbl_Death = {"slower/scream1.wav"}

ENT.FootStepSoundLevel = 75

-- Custom
ENT.Slower1_TypeOfBodyGroup = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local orionisblack = math.random(0,2)
	if orionisblack == 0 then self:SetBodygroup(0,0) self.Slower1_TypeOfBodyGroup = 0
	elseif orionisblack == 1 then self:SetBodygroup(0,1) self.Slower1_TypeOfBodyGroup = 1
	elseif orionisblack == 2 then self:SetBodygroup(0,2) self.Slower1_TypeOfBodyGroup = 2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,5)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.TimeUntilMeleeAttackDamage = 0.8
		self.NextAnyAttackTime_Melee = 0.2
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_reg")
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
		self.TimeUntilMeleeAttackDamage = 0.95
		self.NextAnyAttackTime_Melee = 0.251
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_reg")
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack3"}
		self.TimeUntilMeleeAttackDamage = 0.65
		self.NextAnyAttackTime_Melee = 0.6
		self.MeleeAttackExtraTimers = {1.05}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_dual")
	elseif randattack == 4 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack4"}
		self.TimeUntilMeleeAttackDamage = 1.05
		self.NextAnyAttackTime_Melee = 0.274
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_slow")
	elseif randattack == 5 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack5"}
		self.TimeUntilMeleeAttackDamage = 0.67
		self.NextAnyAttackTime_Melee = 0.242
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_cof_slower1_d_reg")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	local buzzisstupid = math.random(1,3)
	if buzzisstupid == 1 then
		self.AnimTbl_Death = {ACT_DIEVIOLENT}
		timer.Simple(1,function()
			if IsValid(self) then
				self:RunGibOnDeathCode(dmginfo,hitgroup,{CustomDmgTbl={"All"}})
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self.DeathAnimationCodeRan == false then return false end
	
	if self.Slower1_TypeOfBodyGroup == 0 then self:SetBodygroup(0,3) end
	if self.Slower1_TypeOfBodyGroup == 1 then self:SetBodygroup(0,4) end
	if self.Slower1_TypeOfBodyGroup == 2 then self:SetBodygroup(0,5) end
	
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment(0)).Pos)
		bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
		bloodeffect:SetScale(30)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetAttachment(self:LookupAttachment(0)).Pos)
		bloodspray:SetScale(4)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
	end
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/brain_gib.mdl",{Pos=self:GetAttachment(self:LookupAttachment(0)).Pos,Ang=self:GetAngles()+Angle(0,-90,0),Vel=self:GetForward()*math.Rand(20,40)})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos=self:GetAttachment(self:LookupAttachment(0)).Pos,Ang=self:GetAngles()+Angle(0,-90,0),Vel=self:GetRight()*math.Rand(50,50)+self:GetForward()*math.Rand(20,40)})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos=self:GetAttachment(self:LookupAttachment(0)).Pos,Ang=self:GetAngles()+Angle(0,-90,0),Vel=self:GetRight()*math.Rand(-50,-50)+self:GetForward()*math.Rand(20,40)})
	return true,{DeathAnim=true}
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
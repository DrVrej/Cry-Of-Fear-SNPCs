AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/baby/baby.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_baby_h")
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 90 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.4 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.556 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 100//GetConVarNumber("vj_cof_baby_d")
ENT.FootStepTimeRun = 0.25 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.25 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Alert = {"baby/b_alert1.wav","baby/b_alert2.wav","baby/b_alert3.wav"}
ENT.SoundTbl_MeleeAttack = {"baby/b_attack1.wav","baby/b_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"slower/hammer_miss1.wav","slower/hammer_miss2.wav"}
ENT.SoundTbl_Pain = {"baby/b_pain1.wav","baby/b_pain2.wav"}
ENT.SoundTbl_Death = {"baby/b_death1.wav","baby/b_death2.wav"}

ENT.FootStepSoundLevel = 75

-- Custom
ENT.Baby_DeathFromMeleeAttack = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(15, 15, 50), Vector(-15, -15, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
	if self.Dead == true or !IsValid(self:GetEnemy()) then return end
	self:SetGroundEntity(NULL)
	self:SetLocalVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal()*200 + self:GetUp()*40 + self:GetForward()*20)
	self.Baby_DeathFromMeleeAttack = true
	self:TakeDamage(999999999999999,self,self)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	if self.Baby_DeathFromMeleeAttack == false then
		self.AnimTbl_Death = {ACT_DIESIMPLE}
	end
	self:SetBodygroup(0,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
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
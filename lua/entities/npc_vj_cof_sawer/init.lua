AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/sawer/chainsawguy.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_sawer_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 130 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.85 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("vj_cof_sawer_d")
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_COWER} -- Death Animations
ENT.DeathAnimationTime = 2 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Breath = {"boss/sawer/chainsaw_loop.wav"}
ENT.SoundTbl_Alert = {"boss/sawer/sawer_alert10.wav","boss/sawer/sawer_alert20.wav","boss/sawer/sawer_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"boss/sawer/sawer_attack1.wav","boss/sawer/sawer_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"boss/sawer/chainsaw_attack.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"boss/sawer/chainsawed_player.wav"}
ENT.SoundTbl_Pain = {"boss/sawer/sawer_pain1.wav","boss/sawer/sawer_pain2.wav"}
ENT.SoundTbl_Death = {"boss/sawer/eye_open.wav"}

ENT.AlertSoundLevel = 100
ENT.FootStepSoundLevel = 75
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 110), Vector(-20, -20, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack = math.random(1,3)
	if randattack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack1"}
		self.TimeUntilMeleeAttackDamage = 1
		self.NextAnyAttackTime_Melee = 0.667
	elseif randattack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack2"}
		self.TimeUntilMeleeAttackDamage = 0.95
		self.NextAnyAttackTime_Melee = 0.629
	elseif randattack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_attack3"}
		self.TimeUntilMeleeAttackDamage = 1
		self.NextAnyAttackTime_Melee = 0.48
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	timer.Simple(2,function()
		if IsValid(self) then
			self:RunGibOnDeathCode(dmginfo,hitgroup,{CustomDmgTbl={"All"}})
			util.VJ_SphereDamage(self,self,self:GetPos(),100,35,DMG_SLASH,true,true,{Force=50})
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self.DeathAnimationCodeRan == false then return false end
	
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment(0)).Pos)
		bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
		bloodeffect:SetScale(150)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetAttachment(self:LookupAttachment(0)).Pos)
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
	end
	
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/brain_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,60)),Ang=self:GetAngles()+Angle(0,-90,0)})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,55)),Ang=self:GetAngles()+Angle(0,-90,0),Vel=self:GetRight()*math.Rand(150,250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/eye_gib.mdl",{Pos=self:LocalToWorld(Vector(0,3,55)),Ang=self:GetAngles()+Angle(0,-90,0),Vel=self:GetRight()*math.Rand(-150,-250)+self:GetForward()*math.Rand(-200,200)})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/heart_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl",{Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,35))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,30))})
	self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos=self:LocalToWorld(Vector(0,0,30))})
	return true,{DeathAnim=true}
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
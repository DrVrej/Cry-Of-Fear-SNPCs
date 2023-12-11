AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cryoffear/suicider/suicider.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_cof_suicider_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CRY_OF_FEAR"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.AnimTbl_RangeAttack = {ACT_IDLE} -- Range Attack Animations
ENT.RangeAttackAnimationStopMovement = false -- Should it stop moving when performing a range attack?
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 1 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 3 -- How much time until it can use any attack again? | Counted in Seconds
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.2 -- Next foot step sound when it is walking
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = 4 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_cof_common/npc_step1.wav"}
ENT.SoundTbl_Alert = {"slower/slower_alert10.wav","slower/slower_alert20.wav","slower/slower_alert30.wav"}
ENT.SoundTbl_RangeAttack = {"vj_cof_common/suicider_glock_fire.wav"}
ENT.SoundTbl_Pain = {"slower/slower_pain1.wav","slower/slower_pain2.wav"}
ENT.SoundTbl_Death = {"slower/scream1.wav"}

ENT.FootStepSoundLevel = 75
ENT.RangeAttackSoundLevel = 100

-- Custom
ENT.Suicider_DeathSuicide = false
ENT.Suicider_FiredAtLeastOnce = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(15, 15, 80), Vector(-15, -15, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Suicider_DoFireEffects()
	local flash = ents.Create("env_muzzleflash")
	flash:SetPos(self:GetAttachment(self:LookupAttachment(1)).Pos)
	flash:SetKeyValue("scale","1")
	flash:SetKeyValue("angles",tostring(self:GetForward():Angle()))
	flash:Fire("Fire",0,0)

	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "4")
	FireLight1:SetKeyValue("distance", "120")
	FireLight1:SetPos(self:GetAttachment(self:LookupAttachment(1)).Pos)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color", "255 150 60")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.Dead == true then return end
	if !IsValid(self:GetEnemy()) then return end
	local EnemyDistance = self:GetPos():Distance(self:GetEnemy():GetPos())
	/*if GetConVarNumber("vj_npc_nochasingenemy") == 0 then 
	if EnemyDistance >= self.RangeDistance && EnemyDistance <= 100 then
		self.DisableChasingEnemy = true else self.DisableChasingEnemy = false
		end
	end*/
	if EnemyDistance <= 100 && self:GetEnemy():Visible(self) && self.Suicider_FiredAtLeastOnce == true then
		self.Suicider_DeathSuicide = true
		self.Bleeds = false
		self:TakeDamage(999999999999999,self,self)
		self.Bleeds = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local bullet = {}
		bullet.Num = 1
		bullet.Src = self:GetPos()+self:OBBCenter() //self:GetAttachment(self:LookupAttachment(1)).Pos
		bullet.Dir = (self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()+self:GetEnemy():GetUp()*-45) -self:GetPos()
		bullet.Spread = 0.001
		bullet.Tracer = 1
		bullet.TracerName = "Tracer"
		bullet.Force = 5
		bullet.Damage = GetConVarNumber("vj_cof_suicider_d")
		bullet.AmmoType = "SMG1"
	self:FireBullets(bullet)
	self.Suicider_FiredAtLeastOnce = true
	self:Suicider_DoFireEffects()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	if self.Suicider_DeathSuicide == true then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT}
		timer.Simple(0.5,function()
			if IsValid(self) then
				self:Suicider_DoFireEffects()
				self:SetBodygroup(0,1)
				VJ_EmitSound(self,"vj_cof_common/suicider_glock_fire.wav",100)
				self:PlayGibOnDeathSounds(dmginfo,hitgroup)
				if self.HasGibDeathParticles == true then
					local bloodeffect = EffectData()
					bloodeffect:SetOrigin(self:GetAttachment(self:LookupAttachment(0)).Pos)
					bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
					bloodeffect:SetScale(50)
					util.Effect("VJ_Blood1",bloodeffect)
				end
			end
		end)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
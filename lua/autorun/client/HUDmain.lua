--[[
	Copyright © 2022 VanderCat
	
	THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, 
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
	BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
	AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
	SOFTWARE.
]]--

-- YourHUDdebug = true -- uncomment if debugging (or you can just run in console lua_run_cl YourHUDdebug = true)

include("vgui/smallSB_main.lua")
local customdraw = include("includes/modules/customdraw.lua")
local MCVT = include("includes/modules/massvar.lua")
local flux = include("includes/modules/flux.lua")

concommand.Add("testopen", function()
	SmallSB_Main = vgui.Create("SmallSB_Main") 
end)

local hide = {
}

hook.Add ("Tick", "HideHUD", function()
	hide = {
	["CHudHealth"] = !GetConVar("cl_originalhud_hp_enabled"):GetBool(),
	["CHudBattery"] = !GetConVar("cl_originalhud_armor_enabled"):GetBool(),
	["CHudAmmo"] = !GetConVar("cl_originalhud_ammo_enabled"):GetBool(),
	["CHudSecondaryAmmo"] = !GetConVar("cl_originalhud_alt_enabled"):GetBool(),
}
end)
local hp = {
	old = nil,
	cur = nil,
	clr = Color(27,238,37, 0),
	clrdraw = Color(27,238,37, 0),
	diffrence = 0,
	timer = 0,
	trns = Color(0,0,0, 0)
}
hook.Add ("Think", "HUDUpdate", function()
	if GetConVar("cl_yourhud_damage_enabled"):GetBool() then
		local dt = FrameTime()
		local plr = LocalPlayer()
		if (!IsValid(plr)) then return end
		flux.update(dt)
		hp.cur = plr:Health()
		if hp.old == nil then hp.old = hp.cur end
		if plr:Alive() then
			hp.dif = hp.cur-hp.old
		else
			hp.dif = 0
		end
		if hp.dif ~= 0 then
			if hp.dif<0 then
				hp.clr = ColorAlpha(MCVT:MassGetColor("cl_yourhud_damage_"),hp.clr.a)
				hp.trns = ColorAlpha(MCVT:MassGetColor("cl_yourhud_damagetransition_"),0) 
			elseif hp.dif>0 then 
				hp.clr = ColorAlpha(MCVT:MassGetColor("cl_yourhud_heal_"),hp.clr.a)
				hp.trns = ColorAlpha(MCVT:MassGetColor("cl_yourhud_healtransition_"),0) 
			else
				hp.clr = ColorAlpha(MCVT:MassGetColor("cl_yourhud_hp_"),hp.clr.a)
				hp.trns = ColorAlpha(hp.clr,hp.clr.a) 
			end
			hp.diffrence = hp.diffrence+hp.dif
			flux.to(hp.clrdraw, 0.15, {r=hp.clr.r,g=hp.clr.g,b=hp.clr.b,a=255})
			hp.dif = 0
			hp.timer=GetConVar("cl_yourhud_damagetime"):GetFloat()
		end
		hp.timer=hp.timer-dt
		if hp.timer < 0 then
			hp.timer=99999999999999999
			flux.to(hp.clrdraw, 0.2, {r=hp.trns.r,g=hp.trns.g,b=hp.trns.b,a=0}):oncomplete(function() hp.diffrence=0 hp.clrdraw = hp.trns end)
		end
		hp.old = hp.cur
	end
end)

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )

hook.Add( "HUDPaint", "VanderHUDmain", function()
	local plr = LocalPlayer()
	if (!IsValid(plr)) then return end

	if plr:Alive() then
		if GetConVar("cl_yourhud_hp_enabled"):GetBool() then
			local health = {
				number = plr:Health(),
				armor = plr:Armor(),
				color = {
					normal = MCVT:MassGetColor("cl_yourhud_hp_"), 
					low = MCVT:MassGetColor("cl_yourhud_hplow_"),
					armor = MCVT:MassGetColor("cl_yourhud_armor_")
				},
				pos = customdraw.Relative(Vector(
					GetConVar("cl_yourhud_hp_offset_x"):GetInt(),
					GetConVar("cl_yourhud_hp_offset_y"):GetInt()
				))
			}
			health.textSize = customdraw.GetTextSize(health.number,"FontHUD")
			if !((hp.diffrence == 0) and (hp.diffrence == nil)) and GetConVar("cl_yourhud_damage_enabled"):GetBool() then
				hp.diffrenceTextSize = customdraw.GetTextSize(hp.diffrence,"FontHUDsmall")
				customdraw.DrawTextWithShadow(
					hp.diffrence, 
					health.pos - (health.textSize / 2) - Vector(hp.diffrenceTextSize.x + 10, 0 ) + Vector(
						GetConVar("cl_yourhud_damage_offset_x"):GetInt(),
						GetConVar("cl_yourhud_damage_offset_y"):GetInt()
					), 
					hp.clrdraw,
					"FontHUDsmall" ,
					nil,
					Color(0,0,0,hp.clrdraw.a/2)
				)
			end
			if health.armor ~= 0 then
				health.armorTextSize = customdraw.GetTextSize(health.armor,"FontHUDsmall")
				customdraw.DrawTextWithShadow(
					health.armor,
					health.pos - (health.textSize / 2) + Vector(-health.armorTextSize.x-10, health.armorTextSize.y) + Vector(
						GetConVar("cl_yourhud_armor_offset_x"):GetInt(),
						GetConVar("cl_yourhud_armor_offset_y"):GetInt()
					), 
					health.color.armor,
					"FontHUDsmall",
					nil,
					Color(0,0,0,health.color.armor.a/2)
				)
			end

			customdraw.DrawTextWithShadow(
				health.number, 
				health.pos - (health.textSize / 2), 
				customdraw.LerpColor(
					math.Clamp(health.number / 50, 0,1), 
					ColorAlpha(health.color.low, health.color.normal.a), 
					health.color.normal
				),
				"FontHUD",
				nil,
				Color(0,0,0,health.color.normal.a/2)
			)
		end
		local ammo = {
			pos = customdraw.Relative(
				Vector(
					GetConVar("cl_yourhud_ammo_offset_x"):GetInt(),
					GetConVar("cl_yourhud_ammo_offset_y"):GetInt()
				)),
			color = {
				normal = MCVT:MassGetColor("cl_yourhud_ammo_"), 
				low = MCVT:MassGetColor("cl_yourhud_ammolow_"),
				alt = MCVT:MassGetColor("cl_yourhud_alt_"),
				reserve = MCVT:MassGetColor("cl_yourhud_reserve_")
			},
			secondary = {
			}
		}
		pcall(function()
			ammo.number = plr:GetActiveWeapon():Clip1()
			ammo.secondary.number = plr:GetAmmoCount(plr:GetActiveWeapon():GetSecondaryAmmoType())
			ammo.type = plr:GetActiveWeapon():GetPrimaryAmmoType()
			if ammo.type < 1 then
				if plr:GetAmmoCount(plr:GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
					ammo.number = plr:GetAmmoCount(plr:GetActiveWeapon():GetPrimaryAmmoType())
				elseif plr:GetActiveWeapon():Clip1() > 0 then
					ammo.number = plr:GetActiveWeapon():Clip1()
				else
					ammo.number = -1
				end
				ammo.max = ammo.number
				ammo.left = 0
				if (ammo.secondary.number > 0) and (ammo.number < 0) then
					ammo.number = ammo.secondary.number
					ammo.secondary.number = 0
					ammo.max = ammo.number
				end
			else
				ammo.max = plr:GetActiveWeapon():GetMaxClip1()
				ammo.left = plr:GetAmmoCount(plr:GetActiveWeapon():GetPrimaryAmmoType())
				if (ammo.left > 0) and (ammo.number < 0) then
					ammo.number = ammo.left
					ammo.left = 0
					ammo.max = ammo.number
				end
			end


			ammo.textSize = customdraw.GetTextSize(ammo.number,"FontHUD")
			ammo.lefttextSize = customdraw.GetTextSize(ammo.left,"FontHUDsmall")
			ammo.secondary.textSize = customdraw.GetTextSize(ammo.secondary.number,"FontHUDsmall")
			if ammo.number ~= -1 and GetConVar("cl_yourhud_ammo_enabled"):GetBool() then
				customdraw.DrawTextWithShadow(
					ammo.number, 
					ammo.pos - (ammo.textSize / 2), 
					customdraw.LerpColor(
						ammo.number / (ammo.max / 2), 
						ammo.color.low, 
						ammo.color.normal
					),
					"FontHUD",
					nil,
					Color(0,0,0,ammo.color.normal.a/2)
				)
			end
			if ammo.left ~= 0 and GetConVar("cl_yourhud_ammoreserve_enabled"):GetBool() then
				customdraw.DrawTextWithShadow(
					ammo.left,
					ammo.pos + (ammo.textSize / 2) - Vector(-10, ammo.lefttextSize.y) + Vector(
						GetConVar("cl_yourhud_reserve_offset_x"):GetInt(),
						GetConVar("cl_yourhud_reserve_offset_y"):GetInt()
					), 
					ammo.color.reserve,
					"FontHUDsmall",
					nil,
					Color(0,0,0,ammo.color.reserve.a/2)
				)
			end
			if ammo.secondary.number > 0 and GetConVar("cl_yourhud_alt_enabled"):GetBool() then
				customdraw.DrawTextWithShadow(
					ammo.secondary.number, 
					ammo.pos + (ammo.textSize / 2) - Vector(-10, ammo.secondary.textSize.y * 2) + Vector(
						GetConVar("cl_yourhud_alt_offset_x"):GetInt(),
						GetConVar("cl_yourhud_alt_offset_y"):GetInt()
					), 
					ammo.color.alt,
					"FontHUDsmall",
					nil,
					Color(0,0,0,ammo.color.alt.a/2)
				)
			end
		end)
	end
end )
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

local customdraw = include("includes/modules/customdraw.lua")

local function HUDDrawTargetID(self)

    local TargetID = {
        hpFont = "FontHUDtargetSmall",
        font = "FontHUDtarget",
        text = "ERROR",
        tr = util.GetPlayerTrace(LocalPlayer()),
        pos = Vector(gui.MousePos())
    }
 
    TargetID.trace = util.TraceLine( TargetID.tr )

    if (TargetID.pos.x == 0 and TargetID.pos.y == 0 ) then
        TargetID.pos = customdraw.Relative(Vector(50,53))
	end

	if ( !TargetID.trace.Hit ) then return end
	if ( !TargetID.trace.HitNonWorld ) then return end

	if ( TargetID.trace.Entity:IsPlayer() ) then
		TargetID.text = TargetID.trace.Entity:Nick()
        TargetID.color = team.GetColor(TargetID.trace.Entity:Team())
	else
        if (!YourHUDdebug) then return end
		TargetID.text = TargetID.trace.Entity:GetClass()
        TargetID.team = Color(128,128,128,255)
	end
    TargetID.textSize = customdraw.GetTextSize(TargetID.text,TargetID.font) 
	
    TargetID.hp = TargetID.trace.Entity:Health()
	TargetID.hpTextSize = customdraw.GetTextSize(TargetID.hp,TargetID.hpFont)

    -- FIXME: fucking rewrite it i hate how it works but fuck it
    local w = TargetID.textSize.x+TargetID.hpTextSize.x+16
    local h = math.min(TargetID.textSize.y,TargetID.hpTextSize.y)
    local x = TargetID.pos.x-w/2
    local y = TargetID.pos.y-math.min(TargetID.textSize.y,TargetID.hpTextSize.y)/2

    local a -- REWRITE
    local b -- REWRITE
    if (TargetID.hpTextSize.y < TargetID.textSize.y) then -- REWRITE
        a =  math.min -- REWRITE
        b =  math.max -- REWRITE
    else -- REWRITE
        a =  math.max -- REWRITE
        b =  math.min -- REWRITE
    end -- REWRITE
    local hppos = Vector(x,y+(h-a(TargetID.textSize.y,TargetID.hpTextSize.y))/2) -- REWRITE
    local pnamepos = Vector(x+TargetID.hpTextSize.x+16,y+(h-b(TargetID.textSize.y,TargetID.hpTextSize.y))/2) -- REWRITE
    -- REWRITE
    -- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE-- REWRITE
    surface.SetDrawColor(0,0,0,128)
    
    --surface.DrawRect(x,y,w,h)
	customdraw.DrawTextWithShadow(TargetID.hp, hppos, team.GetColor(TargetID.team),TargetID.hpFont)
    customdraw.DrawTextWithShadow(TargetID.text, pnamepos, team.GetColor(TargetID.team),TargetID.font)

end

hook.Add( "HUDDrawTargetID", "YourHUDPlayerInfo", function()
    if (GetConVar("cl_yourhud_playerinfo_enabled"):GetBool()) then
        HUDDrawTargetID(self)
    end
    if (!GetConVar("cl_originalhud_playerinfo_enabled"):GetBool()) then
        return false
    end
end )
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

include("includes/modules/customdraw.lua")

function HUDDrawTargetID()

    local TargetID = {
        hpFont = "FontHUDtargetSmall",
        font = "FontHUDtarget",
        text = "ERROR",
        tr = util.GetPlayerTrace(LocalPlayer()),
        pos = Vector(gui.MousePos())
    }

    TargetID.trace = util.TraceLine( TargetID.tr )

    if (TargetID.pos.x == 0 and TargetID.pos.y == 0 ) then
        TargetID.pos = customdraw.Relative(Vector(50,60))
	end

	if ( !TargetID.trace.Hit ) then return end
	if ( !TargetID.trace.HitNonWorld ) then return end

	if ( TargetID.trace.Entity:IsPlayer() ) then
		TargetID.text = TargetID.trace.Entity:Nick()
	else
		text = TargetID.trace.Entity:GetClass()
	end
    TargetID.textSize = customdraw.GetTextSize(TargetID.text,TargetID.font) 
	
    TargetID.hp = TargetID.trace.Entity:Health()
	TargetID.hpTextSize = customdraw.GetTextSize(TargetID.hp,TargetID.hpFont)

    surface.SetDrawColor(255,255,255)
    local x = (TargetID.pos-TargetID.hpTextSize/2- Vector(TargetID.textSize.x/2+TargetID.hpTextSize.x/2+16)/2):Unpack()
    local y = 0
    if TargetID.pos.y-TargetID.hpTextSize.y/2 > TargetID.pos.y-TargetID.textSize.y/2  then 
        y = TargetID.pos.y-TargetID.hpTextSize.y/2 
    else
        y = TargetID.pos.y-TargetID.hpTextSize.y/2 
    end
    local w = (TargetID.textSize+TargetID.hpTextSize+Vector(16)):Unpack()
    local h = 0
    if TargetID.textSize.y > TargetID.hpTextSize.y then 
        h = TargetID.textSize.y
    else
        h = TargetID.hpTextSize.y
    end
    surface.DrawRect(x,y,w,h)

	customdraw.DrawTextWithShadow(TargetID.hp, TargetID.pos-TargetID.hpTextSize/2- Vector(TargetID.textSize.x/2+TargetID.hpTextSize.x/2+16)/2, self:GetTeamColor(TargetID.trace.Entity),TargetID.hpFont)
    customdraw.DrawTextWithShadow(TargetID.text, TargetID.pos - TargetID.textSize/2 +Vector(TargetID.textSize.x/2+TargetID.hpTextSize.x/2+16)/2, self:GetTeamColor(TargetID.trace.Entity),TargetID.font)

end
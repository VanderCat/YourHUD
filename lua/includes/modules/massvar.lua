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

local lol = {}

function lol.MassSet(prefix, vars, postfix)
    postfix = postfix or ""
    for k, v in pairs(vars) do
        local convar = GetConVar(prefix .. k .. postfix)
        if convar ~= nil then
            convar:SetFloat(v)
        end
    end
end

function lol.MassGet(prefix, vars, postfix)
    postfix = postfix or ""
    local values = {}
    for k, v in ipairs(vars) do
        local convar = GetConVar(prefix .. v .. postfix)
        if convar ~= nil then
            values[v] = convar:GetFloat()
        else 
            values[v] = 255
        end
    end
    return values
end

function lol:MassGetColor(prefix,postfix)
    local color = self.MassGet(prefix, {"r","g","b","a"}, postfix)
    return Color(color.r,color.g, color.b, color.a)
end
return lol
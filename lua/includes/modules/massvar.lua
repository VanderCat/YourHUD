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
customdraw = {}

function customdraw.GetTextSize(text, font)
	font = font or "Default"
	surface.SetFont(font)
	return Vector(surface.GetTextSize(text))
end

function customdraw.DrawText(text, pos, clr, font)
	clr = clr or Color(255,255,255,255)
	font = font or "Default"
	local oldColor = surface.GetTextColor()
	surface.SetFont(font)
	surface.SetTextColor(clr:Unpack())
	surface.SetTextPos(pos.x, pos.y)
	surface.DrawText(text)
	surface.SetTextColor(oldColor)
	surface.SetDrawColor(clr:Unpack())
	--surface.DrawOutlinedRect(pos.x,pos.y,customdraw.GetTextSize(text,font).x, customdraw.GetTextSize(text,font).y, 2)
end

function customdraw.DrawTextWithShadow(text, pos, clr, font, shadowOfset, clrShad)
	clrShad = clrShad or Color(0,0,0,128)
	shadowOfset = shadowOfset or Vector(4,4)
	customdraw.DrawText(text, pos + shadowOfset, clrShad, font)
	customdraw.DrawText(text, pos, clr, font)
end

function customdraw.Relative(pos)
	return Vector(pos.x * (ScrW() / 100),pos.y * (ScrH() / 100))
end

function customdraw.LerpColor(factor, from, to)
	return Color(Lerp(factor, from.r,to.r), Lerp(factor, from.g,to.g),Lerp(factor, from.b,to.b),Lerp(factor, from.a or 255,to.a or 255))
end
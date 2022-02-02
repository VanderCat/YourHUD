include("includes/modules/customdraw.lua")

local PLAYER_AVATAR = {

    Init = function(self)
        self.Avatar = vgui.Create( "AvatarImage", self )
        self.Avatar:SetSize(32,32)
        self.Avatar:SetMouseInputEnabled( false )
        self.Avatar:Dock(LEFT)
        self.Avatar:DockMargin(2,2,2,2)
    end,

    Setup = function( self, pl )
		self.Player = pl
		self.Avatar:SetPlayer( pl )
		self:Think( self )
	end,

    Think = function( self )
		if ( !IsValid( self.Player ) ) then
			self:SetZPos( 9999 ) -- Causes a rebuild
			self:Remove()
			return
		end
        if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
		end
		
		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths() ) then
			self.NumDeaths = self.Player:Deaths()
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 2000 + self.Player:EntIndex() )
			return
		end

        self:SetZPos( ( self.NumKills * -50 ) + self.NumDeaths + self.Player:EntIndex() )
	end
}

PLAYER_AVATAR = vgui.RegisterTable( PLAYER_AVATAR)

local PANEL = {
Init = function (self)
    self:SetSize(100,36)
    self:Center()
    self:SetVisible(true)

    local x,y = self:GetSize()

    self.avatarlist = vgui.Create( "DHorizontalScroller", self )
    self.avatarlist:Dock( FILL )
    self.avatarlist:SetOverlap(30)

    self.time = {
        number = system.SteamTime()
    }
    self.time.formated = os.date("%H:%M", self.time.number)
    self.time.formatedSize = customdraw.GetTextSize(self.time.formated)
	self.center = customdraw.Relative(Vector(50,0))
	self.height = 34
end,

Place = function(self,x,y)
    self:SetSize(w,36)
    self.margin.x=x
    self.margin.y=y
end,

Paint = function(self, w,h)
    draw.RoundedBox(0,0,0,w,h,Color(0,0,0,128))
end,

Think = function(self)
    self.time = {
        number = system.SteamTime()
    }
    self.time.formated = os.date("%H:%M", self.time.number)
    self.time.formatedSize = customdraw.GetTextSize(self.time.formated)

		for id, pl in ipairs(player.GetAll()) do
			if ( IsValid( pl.MiniScoreEntry ) ) then continue end
			pl.MiniScoreEntry = vgui.CreateFromTable( PLAYER_AVATAR, pl.MiniScoreEntry )
			pl.MiniScoreEntry:Setup(pl)

			self.avatarlist:AddPanel( pl.MiniScoreEntry )

		end
    local playercount = #player.GetAll()
    local size = (playercount * 34) + 2
    self:SetSize(size, 36)
    local pos = customdraw.Relative(Vector(50,0))
    -
    Vector(size/2-GetConVar("cl_yourhud_playerlist_offset_left")
    :GetInt(), 
    -GetConVar("cl_yourhud_playerlist_offset_top")
    :GetInt())
    self:SetPos(pos:Unpack())
end
}
vgui.Register("SmallSB_Main", PANEL)
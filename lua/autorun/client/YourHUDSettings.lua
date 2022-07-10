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

local MassConVarTools = include("includes/modules/massvar.lua")

local fonts = {}

if file.Exists("yourhud/fonts.json", "DATA" ) then
    fonts = util.JSONToTable(file.Read("yourhud/fonts.json"))
else
    fonts = {
        available={
            {
                DisplayName="Default",
                font="Coolvetica Rg",
                size=128
            },
            {
                DisplayName="Default Min",
                font="Coolvetica Rg",
                size=64
            },
            {
                DisplayName="Default Small",
                font="Coolvetica Rg",
                size=32
            }
        },
        selected={
            FontHUD=1,
            FontHUDsmall=2,
            FontHUDtarget=3,
            FontHUDtargetSmall=2
        }
    }
    file.CreateDir("yourhud")
    file.Write("yourhud/fonts.json", util.TableToJSON(fonts))
end

for k,v in pairs(fonts.selected) do
    surface.CreateFont(k, fonts.available[v])
end

--  PLAYERLIST
--      ENABLE
        CreateClientConVar("cl_yourhud_playerlist_enabled", "1", true, nil, nil, 0, 1)
--      OFFSET
--          TOP
            CreateClientConVar("cl_yourhud_playerlist_offset_top", "8", true)
--          LEFT
            CreateClientConVar("cl_yourhud_playerlist_offset_left", "0", true)


--  ORIGINAL HUD
    CreateClientConVar("cl_originalhud_hp_enabled", "0", true, nil, nil, 0, 1)
    CreateClientConVar("cl_originalhud_ammo_enabled", "0", true, nil, nil, 0, 1)
    CreateClientConVar("cl_originalhud_armor_enabled", "0", true, nil, nil, 0, 1)
    CreateClientConVar("cl_originalhud_alt_enabled", "0", true, nil, nil, 0, 1)
    CreateClientConVar("cl_originalhud_playerinfo_enabled", "0", true, nil, nil, 0, 1)

--  VANDERHUD
--      ENABLE/DISABLE
--          LEFT
            CreateClientConVar("cl_yourhud_hp_enabled", "1", true, nil, nil, 0, 1)
            CreateClientConVar("cl_yourhud_armor_enabled", "1", true, nil, nil, 0, 1)
            CreateClientConVar("cl_yourhud_damage_enabled", "1", true, nil, nil, 0, 1)
--          RIGHT
            CreateClientConVar("cl_yourhud_ammo_enabled", "1", true, nil, nil, 0, 1)
            CreateClientConVar("cl_yourhud_alt_enabled", "1", true, nil, nil, 0, 1)
            CreateClientConVar("cl_yourhud_ammoreserve_enabled", "1", true, nil, nil, 0, 1)
--          CENTER
            CreateClientConVar("cl_yourhud_playerinfo_enabled", "1", true, nil, nil, 0, 1)
--      DAMAGE INDICATOR TIME
        CreateClientConVar("cl_yourhud_damagetime", "1", true)
--      OFFSET
--          HP
            CreateClientConVar("cl_yourhud_hp_offset_x", "35", true)
            CreateClientConVar("cl_yourhud_hp_offset_y", "60", true)
--              DAMAGE
                CreateClientConVar("cl_yourhud_damage_offset_x", "0", true)
                CreateClientConVar("cl_yourhud_damage_offset_y", "0", true)
--              ARMOR
                CreateClientConVar("cl_yourhud_armor_offset_x", "0", true)
                CreateClientConVar("cl_yourhud_armor_offset_y", "0", true)
--          AMMO
            CreateClientConVar("cl_yourhud_ammo_offset_x", "65", true)
            CreateClientConVar("cl_yourhud_ammo_offset_y", "60", true)
--              RESERVE
                CreateClientConVar("cl_yourhud_reserve_offset_x", "0", true)
                CreateClientConVar("cl_yourhud_reserve_offset_y", "0", true)
--              SECONDARY
                CreateClientConVar("cl_yourhud_alt_offset_x", "0", true)
                CreateClientConVar("cl_yourhud_alt_offset_y", "0", true)
--      COLORS
--          HP
            CreateClientConVar("cl_yourhud_hp_r", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_hp_g", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_hp_b", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_hp_a", "255", true, nil, nil, 0, 255)

            CreateClientConVar("cl_yourhud_hplow_r", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_hplow_g", "0", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_hplow_b", "0", true, nil, nil, 0, 255)
--              DAMAGE
                CreateClientConVar("cl_yourhud_damage_r", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_damage_g", "0", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_damage_b", "0", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_damage_a", "255", true, nil, nil, 0, 255)

                CreateClientConVar("cl_yourhud_damagetransition_r", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_damagetransition_g", "0", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_damagetransition_b", "0", true, nil, nil, 0, 255)

                CreateClientConVar("cl_yourhud_heal_r", "27", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_heal_g", "238", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_heal_b", "37", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_heal_a", "255", true, nil, nil, 0, 255)

                CreateClientConVar("cl_yourhud_healtransition_r", "27", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_healtransition_g", "238", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_healtransition_b", "37", true, nil, nil, 0, 255)
--              ARMOR
                CreateClientConVar("cl_yourhud_armor_r", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_armor_g", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_armor_b", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_armor_a", "255", true, nil, nil, 0, 255)
--          AMMO
            CreateClientConVar("cl_yourhud_ammo_r", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_ammo_g", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_ammo_b", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_ammo_a", "255", true, nil, nil, 0, 255)

            CreateClientConVar("cl_yourhud_ammolow_r", "255", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_ammolow_g", "0", true, nil, nil, 0, 255)
            CreateClientConVar("cl_yourhud_ammolow_b", "0", true, nil, nil, 0, 255)
--              RESERVE
                CreateClientConVar("cl_yourhud_reserve_r", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_reserve_g", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_reserve_b", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_reserve_a", "255", true, nil, nil, 0, 255)
--              SECONDARY
                CreateClientConVar("cl_yourhud_alt_r", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_alt_g", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_alt_b", "255", true, nil, nil, 0, 255)
                CreateClientConVar("cl_yourhud_alt_a", "255", true, nil, nil, 0, 255)

hook.Add( "Think", "YourHUDSettingsThinkHook", function()
    if (!IsValid( LocalPlayer())) then return end
    local isOn = GetConVar("cl_yourhud_playerlist_enabled"):GetBool()
    if IsValid(SmallSB_Main) then
        SmallSB_Main:SetVisible(isOn)
    elseif isOn then
        SmallSB_Main  = vgui.Create("SmallSB_Main",GetHUDPanel())
    end
end)

hook.Add( "AddToolMenuCategories", "YourHUDSettingsCategoriesHook", function()
    spawnmenu.AddToolCategory( "Utilities", "YourHUD", "YourHUD" )
end)

hook.Add( "PopulateToolMenu", "YourHUDSettingsHook", function()
    spawnmenu.AddToolMenuOption( "Utilities", "YourHUD", "PlayerListSettings", "PlayerList Settings", "", "", function( panel )
        panel:ClearControls()
        panel:Help("Change the mini-Playerlist position and disable/enable it")
        panel:CheckBox("Enable Playerlist", "cl_yourhud_playerlist_enabled")
        panel:NumSlider("Offset Top", "cl_yourhud_playerlist_offset_top", 0, ScrH() - 36)
        panel:NumSlider("Offset Left", "cl_yourhud_playerlist_offset_left", -ScrW() / 2, ScrW() / 2)
        end )
    spawnmenu.AddToolMenuOption( "Utilities", "YourHUD", "YourHUDSettings", "Visibility", "", "", function( panel )
        panel:ClearControls()

        panel:Help("Toggle HUD elements visibility")

        panel:Help("Half-Life 2 HUD")
            panel:CheckBox("Enable Health", "cl_originalhud_hp_enabled")
            panel:CheckBox("Enable Armor", "cl_originalhud_armor_enabled")
            panel:CheckBox("Enable Ammo", "cl_originalhud_ammo_enabled")
            panel:CheckBox("Enable Ammo Alt", "cl_originalhud_alt_enabled")

        panel:Help("YourHUD")
            panel:CheckBox("Enable Health", "cl_yourhud_hp_enabled")
            panel:CheckBox("Enable Armor", "cl_yourhud_armor_enabled")
            panel:CheckBox("Enable Ammo", "cl_yourhud_ammo_enabled")
            panel:CheckBox("Enable Ammo Reserve", "cl_yourhud_ammoreserve_enabled")
            panel:CheckBox("Enable Ammo Alt", "cl_yourhud_alt_enabled")

            panel:CheckBox("Enable Damage Indicator", "cl_yourhud_damage_enabled")
            panel:NumberWang("DI Time: ", "cl_yourhud_damagetime", 0.01, 60)
        end )
    spawnmenu.AddToolMenuOption( "Utilities", "YourHUD", "YourHUDOffsets", "Offsets", "", "", function( panel )
        panel:ClearControls()
        local halfH = ScrH() / 2
        local halfW = ScrW() / 2

        panel:Help("Change the HUD elements position")

        panel:Help("Left Side offsets")
            panel:NumSlider("Pos X", "cl_yourhud_hp_offset_x", 0, 100)
            panel:NumSlider("Pos Y", "cl_yourhud_hp_offset_y", 0, 100)

            panel:Help("\tArmor offset")
                panel:NumSlider("Offset X", "cl_yourhud_armor_offset_x", -halfH, halfH)
                panel:NumSlider("Offset Y", "cl_yourhud_armor_offset_y", -halfW, halfW)

            panel:Help("\tDamage offset")
                panel:NumSlider("Offset X", "cl_yourhud_damage_offset_x", -halfH, halfH)
                panel:NumSlider("Offset Y", "cl_yourhud_damage_offset_y", -halfW, halfW)

        panel:Help("Right Side offsets")
            panel:NumSlider("Pos X", "cl_yourhud_ammo_offset_x", 0, 100)
            panel:NumSlider("Pos Y", "cl_yourhud_ammo_offset_y", 0, 100)

            panel:Help("\tAmmo Reserve offset")
                panel:NumSlider("Offset X", "cl_yourhud_reserve_offset_x", -halfH, halfH)
                panel:NumSlider("Offset Y", "cl_yourhud_reserve_offset_y", -halfW, halfW)

            panel:Help("\tAmmo Secondary offset")
                panel:NumSlider("Offset X", "cl_yourhud_alt_offset_x", -halfH, halfH)
                panel:NumSlider("Offset Y", "cl_yourhud_alt_offset_y", -halfW, halfW)
        end )
    spawnmenu.AddToolMenuOption( "Utilities", "YourHUD", "YourHUDColors", "Colors", "", "", function( panel )
        panel:ClearControls()
        panel:Help("Change the HUD Colors")
        local combo = panel:ComboBox("Color of ")
            combo:SetSortItems(false)
            combo:SetValue("[SELECT]")

            combo:AddChoice("HP")
            combo:AddChoice("HP Low")
            combo:AddSpacer()

            combo:AddChoice("Damage Indicator")
            combo:AddChoice("D. Indicator Transition")
            combo:AddChoice("Heal Indicator")
            combo:AddChoice("H. Indicator Transition")
            combo:AddSpacer()

            combo:AddChoice("Ammo")
            combo:AddChoice("Ammo Low")
            combo:AddSpacer()

            combo:AddChoice("Ammo Reserve")
            combo:AddChoice("Ammo Alternative")
            combo:AddChoice("Armor")
        
        local color = vgui.Create( "DColorCombo")
        panel:AddItem(color)
        local prefix = "cl_yourhud_"
        local case = {"hp","hplow","damage","damagetransition","heal","healtransition","ammo","ammolow","reserve","alt","armor", sel=0}
        function combo:OnSelect(i,v)
            case.sel = i
            color:SetColor(MassConVarTools.MassGet(prefix .. case[case.sel] .. "_", {"r","g","b","a"}))
        end
        function color:OnValueChanged(col)
            MassConVarTools.MassSet(prefix .. case[case.sel] .. "_", {r=col.r,g=col.g,b=col.b})
        end
        end )
    spawnmenu.AddToolMenuOption( "Utilities", "YourHUD", "YourHUDFonts", "Fonts", "", "", function( panel )
        panel:ClearControls()
        panel:Help("Change HUD fonts")
        local FontList = vgui.Create("DListView")
            function FontList:RebuildList(fonts)
                self:Clear()
                for k, v in ipairs(fonts.available) do
                    self:AddLine(v.DisplayName,v.font)
                end
            end
            FontList:AddColumn("Name")
            FontList:AddColumn("Font")
            FontList:SetHeight(128)
            FontList:SetMultiSelect(false)
            FontList:RebuildList(fonts)
            panel:AddItem(FontList)
        local applycombo = vgui.Create("DComboBox",btnpanel)
            applycombo:Dock(FILL)
            applycombo:AddChoice("Text Main", "FontHUD", true)
            applycombo:AddChoice("Text Small", "FontHUDsmall")
            applycombo:AddChoice("Text PlayerName", "FontHUDtarget")
            applycombo:AddChoice("Text PlayerHP", "FontHUDtargetSmall")
            panel:AddItem(applycombo)
        local btnpanel = vgui.Create("DPanel")
            local apply = vgui.Create("DButton",btnpanel)
                apply:SetText("Apply")
                apply:Dock(RIGHT)
                function apply.DoClick()
                    local id, data = applycombo:GetSelected()
                    local k, v = FontList:GetSelectedLine()
                    FontList:RebuildList(fonts)
                    fonts.selected[data] = k
                    if fonts.selected == k then fonts.selected[data] = 0
                        local size = 0
                        if data == "FontHUD" then
                            size = 128
                        else
                            size = 64
                        end
                        surface.CreateFont(data, {font = "Coolvetica Rg",size = size})
                    else
                        if (YourHUDdebug) then
                            PrintTable(fonts.available)
                            PrintTable(fonts.selected)
                            print(fonts.selected[data])
                        end
                        surface.CreateFont(data,fonts.available[fonts.selected[data]])
                    end
                    file.Write("yourhud/fonts.json", util.TableToJSON(fonts))
                end
            local remove = vgui.Create("DButton",btnpanel)
                remove:SetText("Remove")
                apply:Dock(RIGHT)
                function remove.DoClick()
                    local id, data = applycombo:GetSelected()
                    local k, v = FontList:GetSelectedLine()
                    if k == nil then fonts.available = {{DisplayName="Default",font="Coolvetica Rg",size=128},{DisplayName="Default Min",font="Coolvetica Rg",size=64}} return end
                    fonts.available[k] = nil
                    if fonts.selected[data] > #fonts.available then 
                        fonts.selected[data] = #fonts.available
                    end
                    FontList:RebuildList(fonts)
                    file.Write("yourhud/fonts.json", util.TableToJSON(fonts))
                end
            panel:AddItem(btnpanel)


        local FontCreator = vgui.Create("DForm")
            panel:AddItem(FontCreator)
            FontCreator:SetName("Add Font")
            local DisplayName = FontCreator:TextEntry("Display name:")
                DisplayName:SetTooltip("Font name in font browser")
            local FontName = FontCreator:TextEntry("Font name:")
                FontName:SetTooltip("The font source.\nThe length is limited to 31 characters maximum.\nWARNING:\nUse the font-name which is shown to you by your operating system Font Viewer, not the file name\nThis also cannot be an already registered font, i.e. you cannot base your font from any of the Default Fonts")
                FontName:SetValue("Arial")
            local size = FontCreator:NumberWang("Size:", nil, 4, 255)
                size:SetTooltip("The font height in pixels")
                size:SetValue(13)
            local weight = FontCreator:NumberWang("Weight:", nil, 0, 1000)
                weight:SetTooltip("The font boldness")
                weight:SetValue(500)
            local blur = FontCreator:NumberWang("Blursize:", nil, 0, 144)
                blur:SetTooltip("The strength of the font blurring")
                blur:SetValue(0)
            local scan = FontCreator:NumberWang("Scanlines:", nil, 0, 255)
                scan:SetTooltip("The \"scanline\" interval Must be > 1 to work.\nThis setting is per blursize per font - so if you create a font using \"Arial\" without scanlines, you cannot create an Arial font using scanlines with the same blursize")
                scan:SetValue(0)
            local aa = FontCreator:CheckBox("Antialiasing")
                aa:SetTooltip("Smooth the font")
                aa:SetValue(true)
            local underline = FontCreator:CheckBox("Underline")
                underline:SetTooltip("Add underline to the font")
                underline:SetValue(false)
            local italic = FontCreator:CheckBox("Italic")
                italic:SetTooltip("Make the font italic")
                italic:SetValue(false)
            local strike = FontCreator:CheckBox("Strikeout")
                strike:SetTooltip("Add a strike through")
                strike:SetValue(false)
            local Save = FontCreator:Button("Save")
                function Save.DoClick()
                    table.insert(fonts.available, {
                        DisplayName = DisplayName:GetValue(),
                        font = FontName:GetValue(),
                        size = size:GetValue(),
                        weight = weight:GetValue(),
                        blursize = blur:GetValue(),
                        scanlines = scan:GetValue(),
                        antialias = aa:GetChecked(),
                        underline = underline:GetChecked(),
                        italic = italic:GetChecked(),
                        strikeout = strike:GetChecked()
                    })
                    FontList:RebuildList(fonts)
                    FontList:SelectItem(FontList:GetLine(fonts.selected))
                    file.Write("yourhud/fonts.json", util.TableToJSON(fonts))
                end
        end)
    print("YourHUD Settings loaded")
end)
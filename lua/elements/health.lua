/*
	modHud, Modular Heads up display
    Copyright (C) 2009  Inspoir
	
    This file is part of modHud.

    modHud is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, version 3 of the License.

    modHud is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with modHud.  If not, see <http://www.gnu.org/licenses/>.
	
	Rev		: 1.00.0
	Desc	: Health Display
*/

local ELEMENT = mhud.New("mHud Health")
local self = LocalPlayer
ELEMENT.x, ELEMENT.y, ELEMENT.entries = 40, ScrH() - 80, {}

/*(
	Desc:	Paints the Health Function
)*/
function ELEMENT.Paint()
	if ( !self():Alive() ) then return end
	
	local s = 0
	mhud.DrawPanel(0, ELEMENT.x, ELEMENT.y, "HEALTH", self():Health())
	
	for i, t in pairs( ELEMENT.entries ) do
		if ( !t.Spawn || !t.Value || CurTime() - t.Spawn > 3 ) then
			ELEMENT.entries[i] = nil
		else
			s = (CurTime() - t.Spawn) * 85 -- I multiply by 85 so it spans 3 seconds, 255 / 85 = 3s
			draw.SimpleText(t.Value, "MHUDFont1", ELEMENT.x, ELEMENT.y - s, Color(255, 255, 255, 255 - s), 3, 1)
		end
	end
end

/*(
	Desc:	Updates ELEMENT.entries with Health gains
)*/
function ELEMENT.Changed( h )
	if ( h > 0 ) then
		-- Add only beneficial HealthChanges
		table.insert(ELEMENT.entries, { Spawn = CurTime(), Value = h })
	end
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_health_paint")
ELEMENT:AddHook("mhud.HealthChanged", ELEMENT.Changed, "mhud_health_changed")
mhud.Register(ELEMENT)

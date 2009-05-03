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

	Rev		: 1
	Desc	: Crosshair
*/

local ELEMENT = mhud.New("mHud Crosshair")
local self, draw = LocalPlayer, CreateClientConVar("crosshair", "1", false, false)

/*(
	Desc:	Paints the Crosshair Function
)*/
function ELEMENT.Paint()
	if ( !self():Alive() || !draw:GetBool() ) then return end
	
	local x, y, c = ScrW() / 2, ScrH() / 2, Color(255, 255, 255, 220)
	
	surface.SetDrawColor(c)
	surface.DrawLine(x - 3, y, x + 4, y)
	surface.DrawLine(x, y, x, y + 4)
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_crosshair_paint")
mhud.Register(ELEMENT)
mhud.Hide("CHudCrosshair")

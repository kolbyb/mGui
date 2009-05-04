/*
	modHud, Modular Heads up display
    Copyright (C) 2009 Inspoir
	
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
	Desc	: Speed Display
*/

local ELEMENT = mhud.New("mHud Speed")
local self = LocalPlayer
local colors = {
	Text	= Color(255, 255, 255, 200),
	Speed	= Color(255, 188, 0, 240)
}
ELEMENT.x, ELEMENT.y = ScrW() / 2, ScrH()

/*(
	Desc:	Paints the Speed Function
)*/
function ELEMENT.Paint()
	if ( !self():Alive() ) then return end
	
	local s, m = Vector(0, 0, 0):Distance(self():GetVelocity()), 2000
	local x, y = ilib.RotatePoint(-40, 0, math.Clamp((s / m), 0, 1) * math.pi)
	
	surface.SetDrawColor(colors.Speed)
		surface.DrawLine(ELEMENT.x, ELEMENT.y, ELEMENT.x + x, ELEMENT.y + y)
	
	draw.SimpleText(math.floor(s / 16.36), "DefaultFixedOutline", ELEMENT.x, ELEMENT.y - 5, colors.Text, 1, 1)
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_speed_paint")
mhud.Register(ELEMENT)

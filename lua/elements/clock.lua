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

	Rev		: 2
	Desc	: Clock Display
*/

local ELEMENT = mhud.New("mHud Clock")
local self = LocalPlayer
ELEMENT.x, ELEMENT.y = ScrW() / 2, 40

/*(
	Desc:	Paints the Clock Function
)*/
function ELEMENT.Paint()
	if ( !self():Alive() ) then return end
	
	mhud.DrawPanel(2, ELEMENT.x, ELEMENT.y, "", os.date("%I:%M:%S %p"), nil, "MHUDFont2")
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_clock_paint")
mhud.Register(ELEMENT)

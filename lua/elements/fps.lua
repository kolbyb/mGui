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
	Desc	: Frames per second display
*/

local ELEMENT = mhud.New("mHud Fps")
local self = LocalPlayer

/*(
	Desc:	Paints the Fps Function
)*/
function ELEMENT.Paint()
	local x, y = ScrW() / 2, ScrH() - 40
	mhud.DrawProgress(5, x, y, 180, 4, math.floor(1 / RealFrameTime()), 300, true)
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_fps_paint")
mhud.Register(ELEMENT)

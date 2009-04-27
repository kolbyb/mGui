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
	Desc	: Ammo Display
*/

local ELEMENT = mhud.New("mHud Ammo")
local self = LocalPlayer
ELEMENT.x, ELEMENT.y = ScrW() - 40, ScrH() - 80

/*(
	Desc:	Paints the Ammo Function
)*/
function ELEMENT.Paint()
	if ( !self():Alive() ) then return end
	
	local w, a = self():GetActiveWeapon()
	if ( !w:IsWeapon() ) then return end
	a = self():GetAmmoCount(w:GetPrimaryAmmoType())
	
	if ( w:Clip1() > -1 || a > 0 ) then
		local v = w:Clip1().."/"..a
		if ( w:Clip1() < 0 ) then v = a end
		
		mhud.DrawPanel(1, ELEMENT.x, ELEMENT.y, "AMMO", v)
	end
end

ELEMENT:AddHook("HUDPaint", ELEMENT.Paint, "mhud_ammo_paint")
mhud.Register(ELEMENT)

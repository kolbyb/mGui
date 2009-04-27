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
	Desc	: Hides the Default HUD
*/

local ELEMENT = mhud.New("mHud Hide")
ELEMENT.draw = {
	CHudAmmo			= false,
	CHudBattery			= false,
	CHudHealth			= false,
	CHudSuitPower		= false,
	CHudSecondaryAmmo	= false
}

/*(
	Desc:	Returns whether a HUD element should draw
)*/
function ELEMENT.Draw( e )
	return ELEMENT.draw[e]
end

ELEMENT:AddHook("HUDShouldDraw", ELEMENT.Draw, "mhud_hide")
mhud.Register(ELEMENT)

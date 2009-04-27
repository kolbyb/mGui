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
	Desc	: modHud Player hooks
*/

local ELEMENT = mhud.New("mHud Player Hooks")
local self, ply = LocalPlayer, { health = 0 }

/*(
	Desc:	Think is where the hooks are called
	Usage:	ELEMENT.AddHook("mhud.HealthChanged", Function ...)
)*/
function ELEMENT.Think()
	if ( ply.health > 0 ) && ( self():Health() > ply.health || self():Health() < ply.health ) then
		hook.Call("mhud.HealthChanged", GAMEMODE, self():Health() - ply.health)
	end
	
	ply.health = self():Health()
end

ELEMENT:AddHook("Think", ELEMENT.Think, "mhud_hooks_player_think")
mhud.Register(ELEMENT)
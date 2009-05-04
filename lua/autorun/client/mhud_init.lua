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
	
	Rev		: 2
	Desc	: Initializes modHud's modules and hooks
*/

surface.CreateFont("frankleinbook", 30, 400, true, false, "MHUDFont1")
surface.CreateFont("frankleinbook", 20, 300, true, false, "MHUDFont2")

print("modHud Loading..")
include("ilib.lua")
include("mhud.lua")
require("ilib")
require("mhud")
print("modHud Loading Hooks..")
for _, h in pairs( file.Find("../lua/hooks/*.lua") ) do include("hooks/" .. h) end
print("\nmodHud Loading Elements..")
for _, e in pairs( file.Find("../lua/elements/*.lua") ) do include("elements/" .. e) end

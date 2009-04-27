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
	Desc	: Inspoir Library
*/

module("ilib", package.seeall)

/*(
	Desc:	Generates a random string with a length ( 1 to 15 )
	Usage:	GenerateString( length )
)*/
function GenerateString( l )
	local l, s = math.Clamp(l, 1, 15), ""
	for i = 0, l do
		s = s .. string.char(math.random(65, 90))
	end
	
	return s
end

/*(
	Desc:	Returns the size of a string
	Usage:	GetStringSize( "FONT", string )
)*/
function GetStringSize( f, s )
	surface.SetFont(f)
	return surface.GetTextSize(s)
end

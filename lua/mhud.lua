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
	
	Rev		: 4
	Desc	: modHud base module
*/

module("mhud", package.seeall)

local mt, _elements, _hooks, _hidden = {}, {}, {}, {}
mt.__index = mt

local LEFT, RIGHT, CENTER, BTLEFT, BTRIGHT, BTCENTER = 0, 1, 2, 3, 4, 5
local colors = {
	Background	= Color(0, 0, 0, 105),
	Text		= Color(255, 188, 0, 240),
	Value		= Color(255, 255, 255, 200)
}

/*(
	Desc:	Creates a new module table to be used with mhud
	Usage:	mhud.New("NAME")
)*/
function New( n )
	if !( type(n) == "string" ) then ErrorNoHalt("mHud Error	: Attempt to register with invalid name type.\n"); return end
	
	local t = { Name = n, Hooks = {} }
	setmetatable(t, mt)

	return t
end

/*(
	Desc:	Hides HUD Elements that might interfere with an mhud element
	Usage:	Register( "CHudElement" OR { "CHudE1", "CHudE2".. } )
)*/
function Hide( e )
	if ( type(e) == "string" ) then
		_hidden[e] = false
	elseif ( type(e) == "table" ) then
		for _, i in pairs( e ) do
			_hidden[i] = false
		end
	end
end

local function __hidehook( e )
	return _hidden[e]
end
hook.Add("HUDShouldDraw", "mhud_hide", __hidehook)

/*(
	Desc:	Function to register a module with mhud
	Usage:	Register( module )
)*/
function Register( m )
	if ( !m || !(type(m.Name) == "string") || !(type(m.Hooks) == "table") ) then 
		ErrorNoHalt("modHud Error	: Attempt to register corrupt module.\n")
		return
	end
	
	_elements[m.Name] = m
	local c = "mhud_"..m.Name
	
	if ( !cookie.GetNumber(c.."_x") || !cookie.GetNumber(c.."_y") ) then
		cookie.Set(c.."_x", ScrW() / 2)
		cookie.Set(c.."_y", ScrH() / 2)
		cookie.Set(c.."_v", false)
	end
	
	/*
		_elements will be used to register the Element to a table;
		Then cookies will be checked / created by the Element name
		
		When the cookie m.Name_visible is true, the Elements hooks
		will be automatically added, and when set to false will be
		removed.
		
		x, y positioning will use cookies m.Name_x / y
	*/
	
	for h, t in pairs( _elements[m.Name].Hooks ) do
		for n, f in pairs( t ) do
			print(string.format("modHud Load	: '%s'[%s]", (m.Name || "nil"), h ))
			_hooks[n] = h; hook.Add(h, n, f)
		end
	end
end

/*(
	Desc:	DEBUG Prints out the Elements Table
)*/
function Debug()
	local s, c
	for _, e in pairs( _elements ) do
		print(e.Name)
		for _, i in pairs( e.Hooks ) do
			c = "mhud_"..e.Name
			s = string.format("  %i, %i, %s", cookie.GetNumber(c.."_x"), cookie.GetNumber(c.."_y"), cookie.GetString(c.."_v"))
			print(s)
			for h, f in pairs( i ) do
				print(".."..h)
			end
		end
	end
end
concommand.Add("mhud_debug", Debug)

local function __align( a, x, y, w, h )
	if ( a == RIGHT ) then
		x = x - w
	elseif ( a == CENTER ) then
		x = x - w / 2
	elseif ( a == BTLEFT ) then
		y = y - h
	elseif ( a == BTRIGHT ) then
		x = x - w
		y = y - h
	elseif ( a == BTCENTER ) then
		x = x - w / 2
		y = y - h
	end
	
	return x, y, w, h
end

/*(
	Desc:	Draws a panel, nf and vf are used for a custom fonts
	Usage:	DrawPanel( alignment, x, y, name, value, opt var1, opt var2 )
)*/
function DrawPanel( a, x, y, n, v, nf, vf )
	local nf, vf = nf || "UiBold", vf || "MHUDFont1"
	local w, h = ilib.GetStringSize(vf, v)
	w = w + 10; if ( #n > 0 ) then w = w + ilib.GetStringSize(nf, n) + 10 end
	
	x, y, w, h = __align(a, x, y, w, h)
	
	draw.RoundedBox(4, x, y, w, h, colors.Background)
	draw.SimpleText(n, nf, x + 10, y + h / 2, colors.Text, 3, 1)
	draw.SimpleText(v, vf, x + w - 5, y + h / 2, colors.Value, 2, 1)
end

/*(
	Desc:	Draws a Progress Bar
	Usage:	DrawProgress( alignment, x, y, width, height, value, maxvalue, text )
)*/
function DrawProgress( a, x, y, w, h, v, mv, t )
	if ( mv < v ) then mv = v end
	
	x, y, w, h = __align(a, x, y, w, h)
	
	surface.SetDrawColor(colors.Background)
		surface.DrawRect(x - 1, y - 1, w + 2, h + 2)
	surface.SetDrawColor(colors.Text)
		surface.DrawRect(x, y, w * v / mv, h)
	
	if ( t ) then
		draw.SimpleText(v, "DefaultFixedOutline", x, y, colors.Value, 3, 1)
	end
end

// Element Meta methods (
	/*(
		Desc:	Adds a hook to be registered to the Hooks table of a module
		Usage:	ELEMENT:AddHook("HOOKNAME", Function)
	)*/
	function mt:AddHook( h, f, n )
		local n = n || ilib.GenerateString(5)
		if ( !self.Hooks[h] ) then
			self.Hooks[h] = {}
		end
		
		self.Hooks[h]["mhud_"..n] = f
	end
	
	/*(
		Desc:	Overrides the default tostring
	)*/
	function mt:__tostring()
		return "Name: "..self.Name
	end
// )
/*
	Rev		: 1
	Desc	: ELEMENT DESCRIPTION
*/

local ELEMENT = mhud.New("ELEMENT NAME")

/*(
	Desc:	Function Description
	Usage:	Function( ... )
)*/
function ELEMENT.Function()

end

ELEMENT:AddHook("HOOKNAME", Function, OPTIONAL "NAME")
mhud.Register(ELEMENT)
-- mhud.Hide("ONE"); mhud.Hide({"ONE", "TWO", "THREE"})

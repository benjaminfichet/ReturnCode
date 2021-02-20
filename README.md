# ReturnCode
**ReturnCode** is a very basic yet powerful Maxscript *class*/*struct*/*object* return-able *object*.
The main benefit of using it is that it helps define a very simple pattern to get the best of *Maxscript's implicit returns* while being able to return data from deep function calls.

The code is about 30 lines /whitespaces included/, pretty simple.

Directly taken from another library (commented):
```lua
	function validateTag tag = (
		ReturnCode.new ((tag.hasAttribute "type") and (tag.hasAttribute "subanim")) \
		err_reason:"Invalid tag: A KitConstraintModel needs at least a type and a subanim path."
	)
	
	function load xml_tag = (
		local ret = validateTag(xml_tag) -- validateTag returns a ReturnCode.
		if ret.ret then (
		
            -- reuse ret, to implicit return "ret"
			ret = anotherFunction() 
			if ret.ret then (
			
			    [...] -- continue pattern
			    
			    
			) -- if _anotherFunction() fails, the returned ret will be _anotherFunction's one.
        )
        -- Always use implicit return to bring informations back!
        -- If __validateTag failed, ret.reason here will be equal to __validateTag's err_reason.
		ret 
	) -- end fn __load 
```




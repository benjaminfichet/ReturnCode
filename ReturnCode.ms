struct ReturnCode (

	-- Variable: ret
    -- public - The main return code, usually a boolean. Can be something else for specific purposes.
	ret = undefined,
	

	-- Variable: data
    -- public - Let's say the return code is set as true, then maybe you want to return some data ? It is it here. 
	data = undefined,

	-- Variable: ret
    -- public - In case the ret code is set to false, then maybe the function did leave a reason for the fail ? It is it here. 
	reason = undefined
)

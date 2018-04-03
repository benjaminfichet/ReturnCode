struct ReturnCode (

	-- Variable: ret
    -- public - The main return code, usually a boolean. Can be something else for specific purposes.
	ret = undefined,
	

	-- Variable: data
    -- public - Let's say the return code is set as true, then maybe you want to return some data ? It is it here. 
	data = undefined,

	-- Variable: ret
    -- public - In case the ret code is set to false, then maybe the function did leave a reason for the fail ? It is it here. 
	reason = undefined,

	-- Instance a new ReturnCode, helps define err_data early in code, err_data is wiped if bool evaluates to true
	fn new bool err_reason:undefined ok_reason:undefined ok_data:undefined err_data:undefined = (
		local ret = ReturnCode ret:(bool)
		if ret.ret then (
			ret.data   = ok_data
			ret.reason = ok_reason
		)
		else (
			ret.data   = err_data
			ret.reason = err_reason
		)
		ret
	),

	on create do ()
)
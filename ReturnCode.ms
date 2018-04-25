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


	-- Instance a new ReturnCode, helps define err_reason early in code, err_reason is wiped if bool evaluates to true
	/*eg.
		local ret = (ReturnCode()).new (aTest()) err_reason:"The aTest failed!"
		-- If aTest() failed, ret.reason will be set to err_reason:, not if not, same for ok_reason, ok_data, err_data
	*/
	fn new bool err_reason:undefined ok_reason:undefined ok_data:undefined err_data:undefined = (
		

		-- Implement: 
		-- if bool is an array, treat each entry as a test
		local multiTests = classof(bool) == Array
		if multiTests then (

			-- Level up err_reason array if needed
			if not (classof(err_reason) == Array) then (err_reason = #(err_reason))
			if (err_reason.count < bool.count) do (
				for i=err_reason.count to bool.count do (
					append err_reason ("Unknown reason, failed at iteration: "+(i as string))
				)
			)

			-- Multi tests, only return err_reason(s)
			local ret     = ReturnCode ret:true
			for i=1 to bool.count do (
				ret.ret = bool[i] 
				if not ret.ret then (
					ret.reason = err_reason[i]
					exit
				)
			)

		)else (
			-- Single test of param bool
			local ret = ReturnCode ret:bool
			if ret.ret then (
				ret.data   = ok_data
				ret.reason = ok_reason
			)
			else (
				ret.data   = err_data
				ret.reason = err_reason
			)
		)

		ret
	),

	on create do ()
)
--ReturnCode.new #(true, true, false) err_reason:#("Fail1")
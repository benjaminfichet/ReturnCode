

/** 
	struct ReturnCode
	Very basic yet powerful return-able objects.
*/
struct ReturnCode (

    -- Variable: ret
    -- public - The main return code, usually a boolean.
	ret = undefined,
	
    -- Variable: data
    -- public - Let's say the return code is true, then maybe you want to return some data. Put it here 
	data = undefined,

    -- Variable: ret
    -- public - In case the ret code is false, then maybe the function left a reason for the fail. Put it here. 
	reason = undefined,

    -- Instances a new ReturnCode, helps define err_reason early in code, err_reason is wiped if bool evaluates to true
	/* 
	eg.:
		local ret = ReturnCode.new (aTestFunction()) err_reason:"The aTestFunction() failed!"
		-- If aTestFunction() failed, ret.reason will be set to err_reason:, ret.data will be err_data, same goes for ok_reason, ok_data
	*/
	fn new bool err_reason:undefined ok_reason:undefined ok_data:undefined err_data:undefined = (
		local ret = ReturnCode ret:(bool)
		if ret.ret then (ret.data = ok_data;  ret.reason = ok_reason;)
		else            (ret.data = err_data; ret.reason = err_reason;)
		ret
	),

	on create do ()
)
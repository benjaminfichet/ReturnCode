# ReturnCode

ReturnCode is a very simple class (read struct), which when used with the simple pattern defined bellow, should allow for simpler, faster, less error prone, code.

Here is the full source code! Yeah, impressive!

```maxscript

/* Class: ReturnCode */
struct ReturnCode (

	-- Variable: ret
    -- The main return code, usually a boolean.
	ret = undefined,
	
	-- Variable: data
    -- Used to bring back data from the called functions. If any data is to be returned the function must store it in here.
	data = undefined,

	-- Variable: reason
    -- Usually used when this.ret is false, allows human reabable informations to flow through the calls, allowing powerful debug. 
	reason = undefined
)

```
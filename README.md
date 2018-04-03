

# ReturnCode
**ReturnCode** is a very simple Maxscript class/*struct* used to carry informations through functions returns in a nice clean structured way. *(I'm looking at you who use multidimmensional arrays to return statecodes+values! ;)*


```maxscript
/* Class: ReturnCode */
struct ReturnCode (

	-- Variable: ret
	-- The main return code, usually a boolean.
	ret = undefined,
	
	-- Variable: data
	-- Used to bring back data from the called functions. 
	-- If any data is to be returned the function must store it in here, and set ret to true to indicate that it did well.
	data = undefined,

	-- Variable: reason
	-- Usually used when this.ret is false, allows human reabable informations to flow through the calls, allowing powerful debug. 
	reason = undefined
)
```
Simple enough..
See dev branch for upcoming goodies!
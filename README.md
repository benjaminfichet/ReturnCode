# ReturnCode
**ReturnCode** is a very simple Maxscript class/*struct* used to carry informations through functions returns in a nice clean structured way. *(I'm looking at you who use multidimmensional arrays to return statecodes+values! ;)*


```maxscript
/* Class: ReturnCode */
struct ReturnCode (

	-- Variable: ret
	-- The main return code, usually a boolean.
	ret = undefined,
	
	-- Variable: data
	-- Usually used to bring back data. 
	data = undefined,

	-- Variable: reason
	-- Use it to bring up debug codes or whatever you need. 
	reason = undefined
)
```
Simple enough..
See dev branch for upcoming goodies!

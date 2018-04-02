

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


## A note on the return operator

**Maxscript's *return operator*** performances are bad, really bad. This is said to be caused by the use of C++ exceptions. 
The recommanded way to bypass the performances hit is to use ***implicit returns*** instead of the regular **return** *ie. carrying and modifiying a return variable through your function, to finally push it on the last line of the function declaration.*

```maxscript
fn implFunction = (
	local myReturn = false
	
	-- ...
	if (something())         then (myReturn = "Avalue")
	if (not somethingElse()) then (myReturn = #AnotherValue)
	-- ...

	myReturn -- last line 
)

fn vanilFunction = (
	local myReturn = false
	
	-- ...
	if (something())         then (return "Avalue")
	if (not somethingElse()) then (return #AnotherValue)
	-- ...

	return myReturn -- last line 
)
```

Please see Benchmark.ms by yourself.
```maxscript
Preparing 2 datasets of 1000000 random entry..ok!
Running Mxs return operator code..        took: 11865 milliseconds to run!
Running implicit return code..            took: 1020  milliseconds to run!
```

Ok fine, but what about **ReturnCode** ?

```maxscript
fn implReturnCodeFunction = (
	local myReturn = ReturnCode ret:false -- or ret:(aCondition())
	
	-- ...
	if (something())         then (myReturn.data = "Avalue")
	if (not somethingElse()) then (myReturn.data = #AnotherValue)

	-- myReturn.ret = true -- or better :(evaluateACondition()) -- set back a meaning ret code
	myReturn -- last line 
)
```
```maxscript
Running implicit return with ReturnCode.. took: 1688  milliseconds to run!
```
The performance boost is still quite interesting even if the returns are high level objects encapsulating a lot of data.



## Why use ReturnCode ? 
Here is a real world documented function using implicit return in conjunction with a ReturnCode.

```maxscript
-- ...

fn publish request = (
	local ret = request.validate() -- The request is a request object of some sort, validating itself,
	                               -- it returns a ReturnCode, assign it to the local ret.

	if ret.ret then (              -- Did the request validate ?
		
		-- This func makes a filename from the request, 
		-- sets ret.ret = true if successful, and store the filename in ret.data. 
		-- In case it failed, the returned ReturnCode from publish() will be the one from _makeFilenameFromrequest().
		-- this is great for debugging purposes. (Where did my code fail ?! Easy, just look at the reason param of the ret.)

		ret = this._makeFilenameFromrequest request
		if ret.ret then (

			-- Looks like the previous code did run without any problem
			-- We can use what is in ret.data.
			local publication = ASUPublication filename:ret.data dir:this.config.dir

			-- Here we directly assign the ret value of the returncode,
			-- since we do it manually, we *must* define a reason if ret.ret is false. 
			ret.ret = (not publication.exists()) and (publication.writable())
			if ret.ret then (

				-- more code..
				/*-- Using the same pattern
					ret = aFunc()
					if ret.ret then (Use ret.data as the function succeeded)
					else            (Use ret.reason to know why the function failed)*/

			-- Here we define the reason for (not publication.exists()) and (publication.writable()) fail.
			)else(ret.reason = "publication file must not exist prior to publishing and dir must be writable")
		)
	)
	ret -- Implicit return the ReturnCode
),

-- ...
```

The key point here is that any function returning a ReturnCode must include a reason if the ret param is set to false.
This allows the ReturnCode(s) to flow through the functions, as deep as they go, while still retaining informations.

Let's say :
```maxscript
myret = publish aRequestObject
```
and that myret.ret is now equal to false.
```maxscript
myret 
>> (ReturnCode ret:false data:undefined reason:"publication file must not exist prior to publishing and dir must be writable")
```
Or maybe..
```maxscript
myret 
>> (ReturnCode ret:false data:undefined reason:"Unable to create a filename for the given request.")
```
etc.


## Conclusions
- Never use Maxscript's **return** operator when an implicit pattern is do-able.
- Even using a high level object (**ReturnCode**) as return is quite faster than vanilla **return**.
- Using *ReturnCode*s allows for easier debugs.
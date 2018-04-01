

# ReturnCode
**ReturnCode** is a very simple Maxscript class/*struct* used to carry informations through functions returns in a nice clean structured way.


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


# A note on the return keyword

## Maxscript
**Maxscript's *return*** performances are bad, really bad. This is said to be caused by the use of C++ exceptions to handle the return operator. 
The recommanded way to bypass the performances hit is to use ***implicit returns*** ie. carrying and modifiying a return variable through your function, to finally push it on the last line of the function declaration.

```maxscript
fn myFunction = (
	local myReturn = false
	-- code, modify myReturn to reflect the end return..
	myReturn
)
```
By using this pattern I am able to gain about ~9/10x boost. Please see Benchmark.ms by yourself. 


## ReturnCode implicit return pattern
Using ***implicit returns*** in conjunction with ***ReturnCode*** allows for nice performances boosts, easier debugging sessions, more pleasant scripting, more stable codebase, easier teamwork, etc.. 

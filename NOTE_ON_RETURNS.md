# A note on the return keyword

## Maxscript
**Maxscript's *return operator*** performances are bad, really bad. This is said to be caused by the use of C++ exceptions it. 
The recommanded way to bypass the performances hit is to use ***implicit returns*** *ie. carrying and modifiying a return variable through your function, to finally push it on the last line of the function declaration.*

```maxscript
fn myFunction = (
	local myReturn = false
	
	-- code, modify myReturn to reflect the end return..
	-- ...

	myReturn -- last line 
)
```
Please see Benchmark.ms by yourself. We got a ~8x perf boost!


## ReturnCode implicit return pattern
Using ***implicit returns*** in conjunction with ***ReturnCode*** allows for nice performances boosts, easier debugging sessions, more pleasant scripting, more stable codebase, easier teamwork, etc.. 

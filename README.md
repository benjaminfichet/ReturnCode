# ReturnCode

**ReturnCode** is a very simple Maxscript class *(read struct)*, which when used in conjuonction with the *pattern* defined bellow,  should allow for *simpler*, *faster*, *easier* to *debug*, code.


###### Full source code
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
*impressive..*

## Pattern




## Motivations
The main motivation 



## Why ?

 - Debugging object/struct oriented Maxscript code can be a hassle.
 - Not using the *return* operator of Maxscript makes your code faster! (*return* uses C++ exceptions)  
 - In constantly evolving productions pipelines having some elementary guidelines helps having a clean codebase.


# Markdown extensions

StackEdit extends the standard Markdown syntax by adding extra **Markdown extensions**, providing you with some nice features.

> **ProTip:** You can disable any **Markdown extension** in the **File properties** dialog.


## SmartyPants

SmartyPants converts ASCII punctuation characters into "smart" typographic punctuation HTML entities. For example:

|                |ASCII                          |HTML                         |
|----------------|-------------------------------|-----------------------------|
|Single backticks|`'Isn't this fun?'`            |'Isn't this fun?'            |
|Quotes          |`"Isn't this fun?"`            |"Isn't this fun?"            |
|Dashes          |`-- is en-dash, --- is em-dash`|-- is en-dash, --- is em-dash|
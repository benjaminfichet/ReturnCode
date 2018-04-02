--- Benchmarking the cost of using the return maxscript operator
--- vs using implicits returns

-- Functions using Maxscript's return operator
-----------------------------------------------
fn mxsreturn_second a b = (
	if a < b  then (return -1)
	if a == b then (return 0)
	if a > b  then (return 1)
)
fn mxsreturn_first a b = (
	if a < b  then (return -1)
	if a == b then (return 0)
	if a > b  then (return (mxsreturn_second a b))
)



-- Functions using implicit return
-----------------------------------------------
fn implicitfunc_second a b = (
	local ret = -1
	if a < b  then (ret = -1) -- We could optimize this further by deleting this line
	if a == b then (ret = 0)
	if a > b  then (ret = 1)
	ret
)
fn implicitfunc_first a b = (
	local ret = -1
	if a < b  then (ret = -1) -- We could optimize this further by deleting this line
	if a == b then (ret = 0)
	if a > b  then (ret = implicitfunc_second a b)
	ret
)



-- Functions using advanced implicit returns
-----------------------------------------------
fn advimplicitfunc_second a b = (
	local ret = ReturnCode ret:true -- We are able to carry more informations
	if a < b  then (ret.data = -1)  -- We could optimize this further by deleting this line
	if a == b then (ret.data = 0)
	if a > b  then (ret.data = 1)
	ret
)
fn advimplicitfunc_first a b = (
	local ret = ReturnCode ret:false -- We are able to carry more informations
	if a < b  then (ret.data = -1)   -- We could optimize this further by deleting this line
	if a == b then (ret.data = 0)
	if a > b  then (ret = advimplicitfunc_second a b)
	ret
)


-- bench
(
	local bench_iterations = 1000000

	format "Preparing 2 datasets of % random entry.." (bench_iterations as string)
	local random_set_a = for i=1 to bench_iterations collect (random 0 bench_iterations)
	local random_set_b = for i=1 to bench_iterations collect (random 0 bench_iterations)
	format "ok!\n\n"



	-- ==========================================================================
	format "Running Mxs Return code.."
	local mxs_ini_time = timeStamp()
	for i=1 to bench_iterations do (
		local a = random_set_a[i]
		local b = random_set_b[i]
		mxsreturn_first a b
	)
	local mxs_end_time = timeStamp()
	local mxs_dur_time = mxs_end_time - mxs_ini_time
	format " took: % milliseconds to run!\n" (mxs_dur_time as string)
	-- ==========================================================================




	-- ==========================================================================
	format "Running impl.ret code.."
	local imp_ini_time = timeStamp()
	for i=1 to bench_iterations do (
		local a = random_set_a[i]
		local b = random_set_b[i]
		implicitfunc_first a b
	)
	local imp_end_time = timeStamp()
	local imp_dur_time = imp_end_time - imp_ini_time
	format " took: % milliseconds to run!\n" (imp_dur_time as string)
	-- ==========================================================================



	-- ==========================================================================
	format "Running ReturnCode code.."
	local advimp_ini_time = timeStamp()
	for i=1 to bench_iterations do (
		local a = random_set_a[i]
		local b = random_set_b[i]
		advimplicitfunc_first a b
	)
	local advimp_end_time = timeStamp()
	local advimp_dur_time = advimp_end_time - advimp_ini_time
	format " took: % milliseconds to run!\n\n" (advimp_dur_time as string)
	-- ==========================================================================






	local ratio = (mxs_dur_time as float) / (imp_dur_time)
	local advratio = (mxs_dur_time as float) / (advimp_dur_time)
	format "Imp.ret pattern is about % times faster than Maxscript's return operator on a % entry test set!\n" (ratio as string) (bench_iterations as string)
	format "ReturnCode pattern is about % times faster than Maxscript's return operator on a % entry test set!\n" (advratio as string) (bench_iterations as string)
)
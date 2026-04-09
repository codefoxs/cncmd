*! version 0.1.1 9Apr2026 CodeFox

/* 主命令区 */
cap program drop cncmd
program define cncmd
syntax anything
local s = "`anything'"
if regexm("`s'", "use|导入"){
    _cncmd_use
}
if regexm("`s'", "merge|合并"){
    _cncmd_merge, get("`s'")
}
if regexm("`s'", "gen|生成|变量"){
    _cncmd_gen
}
if regexm("`s'", "sort|排序"){
    _cncmd_sort
}
if regexm("`s'", "winsor|缩尾"){
    _cncmd_winsor
}
if regexm("`s'", "encode|decode|编码|解码"){
    _cncmd_encode
}
if regexm("`s'", "str|文本"){
    _cncmd_str
}
if regexm("`s'", "reg|回归"){
    _cncmd_reg
}
if regexm("`s'", "sum|描述"){
    _cncmd_sum
}
if regexm("`s'", "out|导出|reg2|corr2|sum2"){
    _cncmd_out
}
if regexm("`s'", "save|保存"){
    _cncmd_save
}
if regexm("`s'", "date|日期"){
    _cncmd_date
}
if regexm("`s'", "placebo|安慰剂|置换|permute"){
    _cncmd_permute
}
if regexm("`s'", "parallel|trend|平行"){
    _cncmd_parallel
}
if regexm("`s'", "dup|去重|重复"){
    _cncmd_dup
}
if regexm("`s'", "by|分组计算"){
    _cncmd_bys
}
if regexm("`s'", "group|分组"){
    _cncmd_group
}
if regexm("`s'", "bdiff|系数差异"){
    _cncmd_bdiff
}
if regexm("`s'", "est"){
    _cncmd_est
}
if regexm("`s'", "iv|工具变量|instrument|IV"){
    _cncmd_iv
}
if regexm("`s'", "psm|PSM|倾向|匹配"){
    _cncmd_psm
}
if regexm("`s'", "replace|替换"){
    _cncmd_replace
}
if regexm("`s'", "mipolate|插值"){
    _cncmd_mipolate
}
else{
    dis as res "Maybe you need {help cncmd:help cncmd}?"
}
end

/* 自定义区域 */
cap program drop _cncmd_use
program define _cncmd_use
dis as res "==================================================="
dis as res `"use `=char(34)'main.dta`=char(34)', clear"'
dis as res "==================================================="
end

cap program drop _cncmd_merge
program define _cncmd_merge
syntax, get(string)
dis as res "==================================================="
local ss = subinstr("`get'", "merge", "", .)
local ss = subinstr("`ss'", "合并", "", .)
if "`ss'" == "m:1" | "`ss'" == "1:1" | "`ss'" == "1:m"{
    dis as res `"merge `ss' stkcd year using `=char(34)'using.dta`=char(34)', nogen keep() keepusing()"'
}
else if "`ss'" == "m:m" | "`get'" == "joinby"{
    dis as res `"joinby stkcd using `=char(34)'using.dta`=char(34)', nogen keep() keepusing()"'
}
else{
    dis as res `"merge 1:1 stkcd year using `=char(34)'using.dta`=char(34)', nogen keep() keepusing()"'
    dis as res `"merge m:1 stkcd year using `=char(34)'using.dta`=char(34)', nogen keep() keepusing()"'
    dis as res `"joinby stkcd using `=char(34)'using.dta`=char(34)', nogen"'
}
dis as res "==================================================="
end

cap program drop _cncmd_gen
program define _cncmd_gen
dis as res "==================================================="
dis as res `"xtset stkcd year"'
dis as res `"gen Size = ln(a001000000)"'
dis as res `"gen Lev = a002000000 / a001000000"'
dis as res `"gen Age = ln(year - ipo_year + 1)"'
dis as res `"gen ROA = b002000000 / a001000000"'
dis as res `"gen Growth = (b001100000 - L.b001100000) / L.b001100000"'
dis as res `"gen TobinQ = f100901a"'
dis as res "==================================================="
end

cap program drop _cncmd_sort
program define _cncmd_sort
dis as res "==================================================="
dis as res `"* 观测排序"'
dis as res `"sort stkcd year"'
dis as res `"// 安装了 gtools 可以尝试 gsort，对于大样本量更快"'
dis as res `"// ssc install gtools"'
dis as res `"gsort stkcd year"'
dis as res `"* 变量排序"'
dis as res `"order stkcd year"'
dis as res "==================================================="
end

cap program drop _cncmd_winsor
program define _cncmd_winsor
dis as res "==================================================="
dis as res `"* ssc install winsor2"'
dis as res `"* 直接替换"'
dis as res `"winsor2 Size Lev Age ROA Growth TobinQ, cut(1, 99) replace"'
dis as res `"* 生成后缀"'
dis as res `"winsor2 Size Lev Age ROA Growth TobinQ, cut(1, 99) suffix(_w)"'
dis as res `"* 分组缩尾"'
dis as res `"winsor2 Size Lev Age ROA Growth TobinQ, cut(1, 99) suffix(_w) by(year)"'
dis as res "==================================================="
end

cap program drop _cncmd_encode
program define _cncmd_encode
dis as res "==================================================="
dis as res `"* encode"'
dis as res `"encode industry, gen(dindustry)"'
dis as res `"encode province, gen(dprovince)"'
dis as res `"encode city, gen(dcity)"'
dis as res `"* decode 不常用"'
dis as res `"decode dindustry, gen(industry)"'
dis as res `"decode dprovince, gen(province)"'
dis as res `"decode dcity, gen(city)"'
dis as res "==================================================="
end

cap program drop _cncmd_str
program define _cncmd_str
dis as res "==================================================="
dis as res `"* 常用文本函数"'
dis as res "gen name1_3 = substr(shortname, 1, 3) // 提取前三个字符"
dis as res `"gen str2 = subinstr(str1, `=char(34)'a`=char(34)', `=char(34)'b`=char(34)', .) // 把 str1 中的 a 替换为 b"'
dis as res `"gen SOE = regexm(equitynature, `=char(34)'国企|央企`=char(34)') // 如果文本 equitynature 中包含“国企”或者“央企”，则 SOE 取值为 1，否则为 0"'
dis as res "==================================================="
end

cap program drop _cncmd_reg
program define _cncmd_reg
dis as res "==================================================="
dis as res `"* 固定效应回归 1"'
dis as res "reghdfe Y X controls, a(stkcd year) cluster(stkcd)"
dis as res `"* 固定效应回归 2"'
dis as res "xtreg Y X controls i.year, fe cluster(stkcd)"
dis as res `"* 简单回归"'
dis as res "reg Y X controls, cluster(stkcd)"
dis as res `"* 高维固定效应回归 + 双重聚类标准误"'
dis as res "reghdfe Y X controls, a(stkcd dindustry#year dcity#year) cluster(stkcd#year)"
dis as res `"* logit"'
dis as res "logit Y X controls i.dindustry i.year, vce(cluster stkcd)"
dis as res `"* 面板 logit"'
dis as res "clogit Y X controls i.year, group(stkcd) vce(cluster stkcd)"
dis as res `"* probit"'
dis as res "probit Y X controls i.dindustry i.year, vce(cluster stkcd)"
dis as res `"* poisson"'
dis as res "poisson Y X controls i.dindustry i.year, vce(cluster stkcd)"
dis as res `"* 面板 poisson"'
dis as res "ppmlhdfe Y X controls, a(stkcd year) cluster(stkcd)"
dis as res `"* tobit"'
dis as res "tobit Y X controls i.dindustry i.year, ll(0) vce(cluster stkcd)"
dis as res "==================================================="
end

cap program drop _cncmd_sum
program define _cncmd_sum
dis as res "==================================================="
dis as res `"* 简单描述统计"'
dis as res "sum Y X controls"
dis as res `"* 详细描述统计"'
dis as res "sum Y X controls, detail"
dis as res "==================================================="
end

cap program drop _cncmd_out
program define _cncmd_out
dis as res "==================================================="
dis as res `"* 描述统计导出"'
dis as res `"sum2docx Y X controls using `=char(34)'Summary.docx`=char(34)', replace ///"'
dis as res `"         stats(N mean(%12.3f) sd(%12.3f) min(%12.3f) p25(%12.3f) median(%12.3f) p75(%12.3f) max(%12.3f)) ///"'
dis as res `"         font(`=char(34)'Times New Roman`=char(34)', 9) ///"'
dis as res `"         margin(top, 3.17cm) margin(bottom, 3.17cm)"'
dis as res `"* 回归导出"'
dis as res `"reg2docx m1 m2 m3 using "Baseline results.docx", replace ///"'
dis as res `"         b(%20.4f) t(%20.4f) ///"'
dis as res `"         scalars(N(%20.0fc) r2_a(%20.4f)) /// "'
dis as res `"         keep(X controls) ///"'
dis as res `"         order(X controls) ///"'
dis as res `"         addfe("Firm=YES" "Year=YES") ///"'
dis as res `"         mtitles() ///"'
dis as res `"         title("Table X Baseline results") ///"'
dis as res `"         font("Times New Roman", 9) ///"'
dis as res `"         margin(top, 3.17cm) margin(bottom, 3.17cm)"'
dis as res `"* 相关系数导出"'
dis as res `"corr2docx Y X controls using "Corr.docx", replace ///"'
dis as res `"         fmt(%12.4f) ///"'
dis as res `"         title("Table X Correlation matrix") ///"'
dis as res `"         font("Times New Roman", 9) ///"'
dis as res `"         margin(top, 3.17cm) margin(bottom, 3.17cm)"'
dis as res "==================================================="
end

cap program drop _cncmd_save
program define _cncmd_save
dis as res "==================================================="
dis as res `"save `=char(34)'main.dta`=char(34)', replace"'
dis as res `"* 其他软件（如 SAS）可能对保存的版本有要求"'
dis as res `"saveold `=char(34)'main-oldv.dta`=char(34)', version(12) replace"'
dis as res "==================================================="
end

cap program drop _cncmd_date
program define _cncmd_date
dis as res "==================================================="
dis as res `"gen date_num = date(date_str, `=char(34)'YMD`=char(34)')"'
dis as res `"format date_num %td"'
dis as res `"gen year = year(date_num)"'
dis as res `"gen month = month(date_num)"'
dis as res `"gen day = day(date_num)"'
dis as res "==================================================="
end

cap program drop _cncmd_permute
program define _cncmd_permute
dis as res "==================================================="
dis as res `"* 安慰剂检验"'
dis as res `"permute X beta=_b[X] t=_b[X]/_se[X], ///"'
dis as res `"        reps(1000) saving(`=char(34)'Permutation.dta`=char(34)', replace) seed(123456): ///"'
dis as res `"        reghdfe Y X controls, a(stkcd year) cluster(stkcd)"'
dis as res `"* 置换检验"'
dis as res `"permute X beta=_b[X] t=_b[X]/_se[X], ///"'
dis as res `"        reps(1000) strata(stkcd) saving(`=char(34)'Permutation.dta`=char(34)', replace) seed(123456): ///"'
dis as res `"        reghdfe Y X controls, a(stkcd year) cluster(stkcd)"'
dis as res "==================================================="
end

cap program drop _cncmd_parallel
program define _cncmd_parallel
dis as res "==================================================="
dis as res `"forvalues i = 1(1)3`=char(123)'"'
dis as res `"    gen After`i' = cond(year - treat_year == `i' & treat_year != ., 1, 0)"'
dis as res `"`=char(125)'"'
dis as res "==================================================="
end

cap program drop _cncmd_dup
program define _cncmd_dup
dis as res "==================================================="
dis as res `"duplicates drop stkcd year, force"'
dis as res `"* 大样本使用 gtools 工具，ssc install gtools"'
dis as res `"gduplicates drop stkcd year, force"'
dis as res "==================================================="
end

cap program drop _cncmd_bys
program define _cncmd_bys
dis as res "==================================================="
dis as res `"* ssc install egenmore 获取更多 egen 函数"'
dis as res `"bys year: egen med = median(X)"'
dis as res `"bys year: egen gvar = xtile(X), nq(2)"'
dis as res `"* 大样本使用 gtools 工具，ssc install gtools"'
dis as res `"egen med = median(X), by(year)"'
dis as res `"egen gvar = xtile(X), nq(2) by(year)"'
dis as res "==================================================="
end

cap program drop _cncmd_group
program define _cncmd_group
dis as res "==================================================="
dis as res `"* 全样本中位数分组"'
dis as res `"egen dX = xtile(X), nq(2)"'
dis as res `"replace dX = dX - 1"'
dis as res `"* 按照年份中位数分组"'
dis as res `"bys year: egen dX = xtile(X), nq(2)"'
dis as res `"replace dX = dX - 1"'
dis as res `"* 系数差异检验"'
dis as res `"bdiff, group(dc) model(reghdfe Y X controls, a(stkcd year) cluster(stkcd)) ///"'
dis as res `"       reps(500) bdec(4) pdec(4) bsample seed(123456)"'
dis as res "==================================================="
end

cap program drop _cncmd_bdiff
program define _cncmd_bdiff
dis as res "==================================================="
dis as res `"* 系数差异检验"'
dis as res `"bdiff, group(dc) model(reghdfe Y X controls, a(stkcd year) cluster(stkcd)) ///"'
dis as res `"       reps(500) bdec(4) pdec(4) bsample seed(123456)"'
dis as res "==================================================="
end

cap program drop _cncmd_est
program define _cncmd_est
dis as res "==================================================="
dis as res `"est store m1"'
dis as res `""'
dis as res `"est store m2"'
dis as res `""'
dis as res `"est store m3"'
dis as res `""'
dis as res `"est store m4"'
dis as res `""'
dis as res `"est store m5"'
dis as res `""'
dis as res `"est store m6"'
dis as res `""'
dis as res `"est store m7"'
dis as res `""'
dis as res `"est store m8"'
dis as res `""'
dis as res `"est store m9"'
dis as res `""'
dis as res `"est store m10"'
dis as res "==================================================="
end

cap program drop _cncmd_iv
program define _cncmd_iv
dis as res "==================================================="
dis as res `"* 固定效应 IV"'
dis as res `"ivreghdfe Y (X=IV) controls, a(stkcd year) cluster(stkcd) first"'
dis as res `"* 普通 IV"'
dis as res `"ivreg2 Y (X=IV) controls, cluster(stkcd) first"'
dis as res "==================================================="
end

cap program drop _cncmd_psm
program define _cncmd_psm
dis as res "==================================================="
dis as res `"psmatch2 treat controls, out(Y) n(1) common cali(0.01) logit ate odds ties noreplacement"'
dis as res "==================================================="
end

cap program drop _cncmd_replace
program define _cncmd_replace
local bt = char(96)
local sq = char(39)
dis as res "==================================================="
dis as res "foreach v of varlist X1 X2 X3" char(123)
dis as res "    replace `bt'v`sq' = 0 if `bt'v`sq' == ."
dis as res char(125)
dis as res "==================================================="
end

cap program drop _cncmd_mipolate
program define _cncmd_mipolate
local bt = char(96)
local sq = char(39)
dis as res "==================================================="
dis as res "* ssc install xtmipolateu 和配套命令"
dis as res "foreach v of varlist X1 X2 X3" char(123)
dis as res "    qui xtmipolateu `bt'v`sq', i(stkcd) t(year) linear"
dis as res char(125)
dis as res "* ssc install xtmipolateu 和配套命令"
dis as res "bys stkcd: replace X = X[_n-1] if _n > 1 & mi(X) & !mi(X[_n-1])"
dis as res "==================================================="
end


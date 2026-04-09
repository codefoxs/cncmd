{smcl}
{* *! version 0.1.1 9Apr2026}{...}
{vieweralsosee "[R] reghdfe" "help reghdfe"}{...}
{vieweralsosee "[R] esttab" "help esttab"}{...}
{vieweralsosee "[R] winsor2" "help winsor2"}{...}
{vieweralsosee "[R] psmatch2" "help psmatch2"}{...}
{vieweralsosee "[R] bdiff" "help bdiff"}{...}
{vieweralsosee "" "--"}{...}
{viewerjumpto "Syntax" "cncmd##syntax"}{...}
{viewerjumpto "Description" "cncmd##description"}{...}
{viewerjumpto "Keywords" "cncmd##keywords"}{...}
{viewerjumpto "Example" "cncmd##example"}{...}
{title:Title}

{p2colset 5 15 15 2}{...}
{p2col :{hi:cncmd} {hline 2}}Chinese command cheatsheet for empirical research (中文命令速查){p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}
{p 8 14 4}{cmd:cncmd} {it:keyword}

{pstd}where {it:keyword} is a Chinese or English keyword that matches one of the supported subcommands listed below.{p_end}

{marker description}{...}
{title:Description}

{pstd}{cmd:cncmd} is a command cheatsheet designed for empirical accounting and finance researchers.
Given a keyword (Chinese or English), it displays commonly used Stata code snippets for the corresponding task.
It is especially useful for beginners or for quickly recalling command syntax during daily research work.{p_end}

{marker keywords}{...}
{title:Supported Keywords}

{pstd}The following table lists all supported keywords and their corresponding tasks.
You may use either the Chinese or English keyword.{p_end}

{synoptset 38 tabbed}{...}
{synopthdr:Keyword}
{synoptline}
{syntab: Data Management}
{synopt: {opt use} | {hi:导入}}Display template for loading data ({cmd:use}){p_end}
{synopt: {opt save} | {hi:保存}}Display template for saving data ({cmd:save}, {cmd:saveold}){p_end}
{synopt: {opt merge} | {hi:合并}}Display template for merging datasets ({cmd:merge}, {cmd:joinby}). Append {it:m:1}, {it:1:1}, {it:1:m}, or {it:m:m} to specify merge type{p_end}
{synopt: {opt sort} | {hi:排序}}Display template for sorting observations and variables ({cmd:sort}, {cmd:gsort}, {cmd:order}){p_end}
{synopt: {opt dup} | {hi:去重} | {hi:重复}}Display template for dropping duplicates ({cmd:duplicates drop}, {cmd:gduplicates drop}){p_end}

{syntab: Variable Operations}
{synopt: {opt gen} | {hi:生成} | {hi:变量}}Display template for generating common control variables ({it:Size}, {it:Lev}, {it:Age}, {it:ROA}, {it:Growth}, {it:TobinQ}){p_end}
{synopt: {opt winsor} | {hi:缩尾}}Display template for winsorizing variables ({cmd:winsor2}){p_end}
{synopt: {opt encode} | {opt decode} | {hi:编码} | {hi:解码}}Display template for encoding/decoding string variables ({cmd:encode}, {cmd:decode}){p_end}
{synopt: {opt str} | {hi:文本}}Display common string functions ({cmd:substr}, {cmd:subinstr}, {cmd:regexm}){p_end}
{synopt: {opt date} | {hi:日期}}Display template for date conversions ({cmd:date()}, {cmd:year()}, {cmd:month()}, {cmd:day()}){p_end}
{synopt: {opt replace} | {hi:替换}}Display template for batch replacing missing values{p_end}
{synopt: {opt mipolate} | {hi:插值}}Display template for interpolating missing values ({cmd:xtmipolateu}){p_end}
{synopt: {opt by} | {hi:分组计算}}Display template for group calculations ({cmd:bys}, {cmd:egen}){p_end}

{syntab: Regression & Estimation}
{synopt: {opt reg} | {hi:回归}}Display templates for various regression models ({cmd:reghdfe}, {cmd:xtreg}, {cmd:reg}, {cmd:logit}, {cmd:clogit}, {cmd:probit}, {cmd:poisson}, {cmd:ppmlhdfe}, {cmd:tobit}){p_end}
{synopt: {opt est}}Display template for storing estimation results ({cmd:est store}){p_end}
{synopt: {opt iv} | {hi:工具变量} | {opt IV} | {opt instrument}}Display template for instrumental variable regressions ({cmd:ivreghdfe}, {cmd:ivreg2}){p_end}
{synopt: {opt psm} | {opt PSM} | {hi:倾向} | {hi:匹配}}Display template for propensity score matching ({cmd:psmatch2}){p_end}
{synopt: {opt group} | {hi:分组}}Display template for median grouping and coefficient difference test ({cmd:xtile}, {cmd:bdiff}){p_end}
{synopt: {opt bdiff} | {hi:系数差异}}Display template for coefficient difference test ({cmd:bdiff}){p_end}

{syntab: Robustness & Diagnostics}
{synopt: {opt placebo} | {hi:安慰剂} | {hi:置换} | {opt permute}}Display template for placebo/permutation tests ({cmd:permute}){p_end}
{synopt: {opt parallel} | {opt trend} | {hi:平行}}Display template for generating parallel trend indicator variables{p_end}

{syntab: Output}
{synopt: {opt sum} | {hi:描述}}Display template for summary statistics ({cmd:sum}, {cmd:sum detail}){p_end}
{synopt: {opt out} | {hi:导出} | {opt reg2} | {opt corr2} | {opt sum2}}Display template for exporting results to Word ({cmd:sum2docx}, {cmd:reg2docx}, {cmd:corr2docx}){p_end}
{synoptline}
{p2colreset}{...}

{marker example}{...}
{title:Example}
{hline}
{pstd}Display data loading template{p_end}
{phang2}{cmd:. cncmd use}{p_end}
{phang2}{cmd:. cncmd 导入}{p_end}

{pstd}Display merge template (default shows all types){p_end}
{phang2}{cmd:. cncmd merge}{p_end}
{phang2}{cmd:. cncmd 合并}{p_end}

{pstd}Display merge template for specific type{p_end}
{phang2}{cmd:. cncmd merge m:1}{p_end}

{pstd}Display regression templates{p_end}
{phang2}{cmd:. cncmd reg}{p_end}
{phang2}{cmd:. cncmd 回归}{p_end}

{pstd}Display winsorizing template{p_end}
{phang2}{cmd:. cncmd winsor}{p_end}
{phang2}{cmd:. cncmd 缩尾}{p_end}

{pstd}Display output/export template{p_end}
{phang2}{cmd:. cncmd out}{p_end}
{phang2}{cmd:. cncmd 导出}{p_end}

{pstd}Display instrumental variable template{p_end}
{phang2}{cmd:. cncmd iv}{p_end}
{phang2}{cmd:. cncmd 工具变量}{p_end}

{pstd}Display placebo test template{p_end}
{phang2}{cmd:. cncmd placebo}{p_end}
{phang2}{cmd:. cncmd 安慰剂}{p_end}

{pstd}If the keyword is not recognized, a hint is displayed{p_end}
{phang2}{cmd:. cncmd hello}{p_end}
{phang2}{res:Maybe you need {help cncmd:help cncmd}?}{p_end}
{hline}

{marker author}{...}
{title:Author}

{pstd}公众号：凯恩斯学计量{p_end}

{phang}{p_end}

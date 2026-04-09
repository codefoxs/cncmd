# cncmd

Stata command cheatsheet for empirical research. Supports Chinese and English keywords. (中文命令速查)

## Install

```stata
* Latest version
cap ado uninstall cncmd
net install cncmd, from("https://raw.githubusercontent.com/codefoxs/cncmd/main/") replace

* Old versions
cap ado uninstall cncmd
net install cncmd, from("https://raw.githubusercontent.com/codefoxs/cncmd/v#.#.#/") replace
```

## Supported Keywords

| Category | Keyword (EN) | Keyword (CN) | Description |
|---|---|---|---|
| Data Management | `use` | `导入` | Load data |
| | `save` | `保存` | Save data |
| | `merge` | `合并` | Merge datasets (supports `m:1`, `1:1`, `1:m`, `m:m`) |
| | `sort` | `排序` | Sort observations and variables |
| | `dup` | `去重` / `重复` | Drop duplicates |
| Variable Operations | `gen` | `生成` / `变量` | Generate common control variables |
| | `winsor` | `缩尾` | Winsorize variables |
| | `encode` / `decode` | `编码` / `解码` | Encode/decode string variables |
| | `str` | `文本` | Common string functions |
| | `date` | `日期` | Date conversions |
| | `replace` | `替换` | Batch replace missing values |
| | `mipolate` | `插值` | Interpolate missing values |
| | `by` | `分组计算` | Group calculations |
| Regression & Estimation | `reg` | `回归` | Regression models (reghdfe, xtreg, logit, probit, etc.) |
| | `est` | — | Store estimation results |
| | `iv` / `IV` / `instrument` | `工具变量` | Instrumental variable regressions |
| | `psm` / `PSM` | `倾向` / `匹配` | Propensity score matching |
| | `group` | `分组` | Median grouping and coefficient difference test |
| | `bdiff` | `系数差异` | Coefficient difference test |
| Robustness & Diagnostics | `placebo` / `permute` | `安慰剂` / `置换` | Placebo/permutation tests |
| | `parallel` / `trend` | `平行` | Parallel trend indicator variables |
| Output | `sum` | `描述` | Summary statistics |
| | `out` / `reg2` / `corr2` / `sum2` | `导出` | Export results to Word |

## Example

### Quick use

```stata
cncmd reg
cncmd 回归
```

### Merge with specific type

```stata
cncmd merge m:1
```

### Export templates

```stata
cncmd out
cncmd 导出
```

### Get help

```stata
help cncmd
```

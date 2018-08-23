clear all
macro drop _all 
set more off

global path "/Users/nadialucas/Dropbox"

*Set working directory
cd "`path'/epic_task_nadia/laura/RawData"

*Convert all txt files into dta files
local files: dir . files "*.txt"

foreach file of local files {
import delimited using `file', clear
save "`path'/epic_task_nadia/laura/IntermediateData/`file'.dta" ,replace
}

clear

*Merge files into single dataset
use "`path'/epic_task_nadia/laura/IntermediateData/demographics.txt.dta"
merge 1:1 fips using "`path'/epic_task_nadia/laura/IntermediateData/house_age1.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "`path'/epic_task_nadia/laura/IntermediateData/house_age2.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "`path'/epic_task_nadia/laura/IntermediateData/house_chars1.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "`path'/epic_task_nadia/laura/IntermediateData/house_chars2.txt.dta"
assert _merge == 3
drop _merge

*Subset first two digits of fips into a new variable
tostring fips, replace format("%11.0f")
gen statefips = substr(fips,1,2) if strlen(fips) > 10
replace statefips = substr(fips,1,1) if statefips == ""
tab statefips

*Save dataset
save "`path'/epic_task_nadia/laura/IntermediateData/superfund_sample.dta"

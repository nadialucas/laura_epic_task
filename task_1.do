clear all
macro drop _all 
set more off

*Set working directory
cd "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/"

*Convert all txt files into dta files
local files: dir . files "*.txt"

foreach file of local files {
import delimited using `file', clear
save `file'.dta ,replace
}

clear

*Merge files into single dataset
use "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/demographics.txt.dta"
merge 1:1 fips using "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/house_age1.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/house_age2.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/house_chars1.txt.dta"
assert _merge == 3
drop _merge
merge 1:1 fips using "/Users/lauraalcocar/Documents/EPIC_Orientation/txt/house_chars2.txt.dta"
assert _merge == 3
drop _merge

*Subset first two digits of fips into a new variable
tostring fips, replace format("%11.0f")
gen statefips = substr(fips,1,2) if strlen(fips) > 10
replace statefips = substr(fips,1,1) if statefips == ""
tab statefips

*Save dataset
save superfund_sample.dta


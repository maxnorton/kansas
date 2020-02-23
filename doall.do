set more off
global ver _v0_2

do usa_00007.do
tempfile acsdata
save `acsdata', replace

import delimited using data/source/nhgis0023_ds215_20155_2015_puma.csv, clear
keep if statea==20
rename adree001 rent
gen monthly_addl_mortgage = adr6e002 - adr6e003
rename adr6e003 monthly_cost
gen annual_mortgage = monthly_addl_mortgage*12
rename puma5a puma
keep county* monthly* annual_mortgage puma

tempfile pumadata
save `pumadata', replace

use `acsdata', clear
merge m:1 puma using `pumadata', keep(1 3)

save kansas$ver, replace

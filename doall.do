global ver _v0_1

do cps_00002.do

save kansas$ver, replace

import delimited using data/source/nhgis0022_ds215_20155_2015_county.csv, clear
keep if statea==20
rename adrem001 rent
gen monthly_addl_mortgage = adr6m002 - adr6m003
rename adr6m003 monthly_cost
gen annual_mortgage = monthly_addl_mortgage*12
keep county* monthly* annual_mortgage

tempfile countydata
save using `countydata', replace

use kansas$ver, clear

merge m:1 

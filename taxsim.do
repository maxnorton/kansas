use data/kansas$ver, clear

keep if statefip==20

* Set all vars required by taxsim32:
* https://users.nber.org/~taxsim/taxsim32/
gen taxsimid = _n
* year set by default
rename statefip state
* For now, treat everyone as single
gen mstat=1
rename age page
* For now, treat all children as dependents
rename nchild depx
rename incwage pwages
gen swages=0
* For now, treat incinvst as interest: tax it at the earned income rate. Also experiment with classifying it as dividends which receive a lower rate.
gen dividends=0
rename incinvst intrec
/* I don't current have any capital gains data
stcg: short term cap ains
ltcg: long term cap gains
otherprop: other property income
nonprop: nonproperty income*/
rename incretir pensions
rename incss gssi
/* Don't currently have any UI data unless it's in public assistance
 ui: unemployment compensation*/
rename incwelfr transfers 
gen rentpaid=rent*12
rename proptx99 proptax
* Don't have data: otheritem (other itemized deductions)
* Don't have data: childcare
* I current only have full mortgage payments, not interest: mortgage (home mortgage interest)
* Don't have data: scorp income
* In future will want a better measure, without farm income
rename incbus00 pbusinc
* pprofinc don't have it

* Match spouses
* gen spouseid = .
* recode marst (1=2) (2=2) (3=2) (4=1) (5=1) (6=1), gen(mstat)
* sage: age of spouse
* swages: wage income of spouse. zero for non-joint returns.
* sbusinc
* sprofinc

keep if taxsimid<90000
taxsim32

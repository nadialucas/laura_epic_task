************* Task 2 - Epic Orientation Data Project ******************
clear all
cd "`path'/epic_task_nadia/laura/IntermediateData"
use "superfund_sample.dta"

reg lnmdvalhs0 npl2000 lnmeanhs8, r
est sto reg1
reg lnmdvalhs0 npl2000 lnmeanhs8 firestoveheat80 noaircond80 nofullkitchen80 ///
zerofullbath80 bedrms0_80occ bedrms1_80occ bedrms2_80occ bedrms3_80occ ///
bedrms4_80occ bedrms5_80occ blt0_1yrs80occ blt2_5yrs80occ blt6_10yrs80occ ///
blt10_20yrs80occ blt20_30yrs80occ blt30_40yrs80occ blt40_yrs80occ detach80occ mobile80occ , r
est sto reg2
reg lnmdvalhs0 npl2000 lnmeanhs8 firestoveheat80 noaircond80 nofullkitchen80 ///
zerofullbath80 bedrms0_80occ bedrms1_80occ bedrms2_80occ bedrms3_80occ ///
bedrms4_80occ bedrms5_80occ blt0_1yrs80occ blt2_5yrs80occ blt6_10yrs80occ ///
blt10_20yrs80occ blt20_30yrs80occ blt30_40yrs80occ blt40_yrs80occ detach80occ mobile80occ ///
pop_den8 shrblk8 shrhsp8 child8 old8 shrfor8 ffh8 smhse8 hsdrop8 no_hs_diploma8 ba_or_better8 ///
unemprt8 povrat8 welfare8 avhhin8 tothsun8 ownocc8 occupied80, r
est sto reg3

reghdfe lnmdvalhs0 npl2000 lnmeanhs8 firestoveheat80 noaircond80 nofullkitchen80 ///
zerofullbath80 bedrms0_80occ bedrms1_80occ bedrms2_80occ bedrms3_80occ ///
bedrms4_80occ bedrms5_80occ blt0_1yrs80occ blt2_5yrs80occ blt6_10yrs80occ ///
blt10_20yrs80occ blt20_30yrs80occ blt30_40yrs80occ blt40_yrs80occ detach80occ mobile80occ ///
pop_den8 shrblk8 shrhsp8 child8 old8 shrfor8 ffh8 smhse8 hsdrop8 no_hs_diploma8 ba_or_better8 ///
unemprt8 povrat8 welfare8 avhhin8 tothsun8 ownocc8 occupied80, absorb(statefips) 
est sto reg4 

#d ;
esttab reg1 reg2 reg3 reg4 using task_2_regression.tex, obslast
label nonumber title("Models of house prices")
mtitle("Model 1" "Model 2" "Model 3" "Model4") b(%9.5f) t(%9.4f)
replace longtable noconstant addnotes("Model 4 uses state fixed effects ") ;
#d cr

/* Comments:
In the first regression, the effect of the NPL status in the year 2000 seems to have a positive effect on the log of median house at a 10% level 
when controlling for house prices in 1980
However, we can see that when more control related to the house were added, this effect seems to be slightly larger and significant at every level 
which leads me to believe that the simplest regression is underestimating the effect. 
This becomes even more obvious when adding controls for demographics but upon analyzing the last regression we can see that by controlling 
for state fixed effects we obtain a statistically significant effect of 0.00085% increase in house prices which is actually lower than what we find in the third regression without controlling for fixed effects. 



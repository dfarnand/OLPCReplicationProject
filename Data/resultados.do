* TECHNOLOGY AND CHILD DEVELOPMENT: EVIDENCE FROM THE ONE LAPTOP PER CHILD PROGRAM
* FORTHCOMING AT THE AMERICAN ECONOMIC JOURNAL: APPLIED ECONOMICS
* THIS DO FILE GENERATES FINAL RESULTS, TABLES AND FIGURES





set more off



* GENERATE THE FOLDER WHERE THE RESULTS OF RUNNING THIS DO FILE WILL BE SAVED
capture ! mkdir resultados






* TABLE 1

* NOTE: PRODUCING THIS TABLE INVOLVES MATCHING THE STUDY SAMPLE WITH THE SCHOOL CENSUS IN PERU. WE DO NOT PROVIDE THE CODE AND DATA TO PRODUCE THIS TABLE
* TO MAINTAIN THE CONFIDENTIALITY OF SCHOOLS, PRINCIPALS, TEACHERS AND STUDENTS PARTICIPATING IN THE STUDY.





 



* TABLE 2 - Student sample size

use "bd_finales\estudiante.dta", clear



postutil clear


postfile table2 second followed sixth using "resultados\table2.dta", replace



local list "lbacadem edad academ"


* local var "lbacadem"
foreach var of local list {


* BASELINE

sum `var' if `var'!=. & grupo=="2"
local n1=r(N)


sum `var' if `var'!=. & grupo=="S"
local n2=r(N)


sum `var' if `var'!=. & grupo=="6"
local n3=r(N)


display "n1=`n1'   n2=`n2'   n3=`n3'"


post table2 (`n1') (`n2') (`n3')


}


postclose table2




use "resultados\table2.dta", clear 
format second followed sixth %6.0f


outsheet using "resultados\table2.xls", replace


erase "resultados\table2.dta"










 
 
* TABLE 3 - Pre-Treatment Balance - Follow Cohort

use "bd_finales\estudiante.dta", clear


postutil clear

postfile table3 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 n using "resultados\table3.dta", replace
local x lbmate lbleng lbacadem extraed bmujer bcastel inicial
foreach var in  `x' {


*Mean treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean control
sum `var' if tratada == 0
local c_m = r(mean) 


*Raw Difference
reg `var' tratada, cluster(codmod)
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum, cluster(codmod)
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local n = e(N)
local d_t2 = abs(`d_m2'/`d_s2')


if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


post table3 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s') ("`star'") (`d_m2') (`d_s2') ("`star2'") (`n') 
}


postclose table3


use "resultados\table3.dta", clear 
format t_m c_m d_m d_s d_m2 d_s2 %6.3f


outsheet using "resultados\table3.xls", replace


erase "resultados\table3.dta"











* TABLE 4 - Balance in Covariates at Follow up - Interviewed Sample 


use "bd_finales\estudiante.dta", clear
postutil clear



* We define the variable mujer (female) onlly for the interviewed sample 
replace mujer = . if edad == .


postfile table4 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 n using "resultados\table4.dta", replace


local x edad mujer castel person herman pprim mprim mcastel tele radio celul luzelec aguapot desague cement juntos cincolib quincemi 


foreach var in `x'{

*Mean treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw difference
reg `var' tratada, cluster(codmod)
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted difference
xi: reg `var' tratada i.stratum, cluster(codmod)
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local n = e(N)
local d_t2 = abs(`d_m2'/`d_s2')


if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


post table4 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s') ("`star'") (`d_m2') (`d_s2') ("`star2'") (`n')
}


postclose table4


use "resultados\table4.dta", clear 
format t_m c_m d_m d_s d_m2 d_s2 %6.3f


outsheet using "resultados\table4.xls", replace


erase "resultados\table4.dta"












* TABLE 5 - Treatment Compliance - Interviewed Sample

use "bd_finales\estudiante.dta", clear


collapse ielap ieluz ieinter tratada stratum, by(codmod)


postfile table5_1 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 n using "resultados\table5_1.dta", replace


local c ielap ieluz ieinter


foreach var in `c'{


*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw Difference
reg `var' tratada
local d_m = _b[tratada]
local d_s = _se[tratada]
local n = e(N)
local d_t = abs(`d_m'/`d_s')



if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local d_t2 = abs(`d_m2'/`d_s2')

if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


post table5_1 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s')  ("`star'") (`d_m2') (`d_s2') ("`star2'") (`n') 
}


postclose table5_1





use "bd_finales\docente.dta", clear


postfile table5_2 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 n using "resultados\table5_2.dta", replace


local c training


foreach var in `c'{


*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw Difference
reg `var' tratada, cluster(codmod)
local d_m = _b[tratada]
local d_s = _se[tratada]
local n = e(N)
local d_t = abs(`d_m'/`d_s')

if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum, cluster(codmod)
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local d_t2 = abs(`d_m2'/`d_s2')

if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


post table5_2 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s') ("`star'") (`d_m2') (`d_s2')  ("`star2'") (`n') 
}


postclose table5_2

						
use "resultados\table5_1.dta", clear
append using "resultados\table5_2.dta"


format t_m c_m d_m d_s d_m2 d_s2  %6.3f


outsheet using "resultados\table5.xls", replace


erase "resultados\table5_1.dta"
erase "resultados\table5_2.dta"









* TABLE 6 - EFFECTS ON COMPUTER ACCES AND USE - INTERVIEWED SAMPLE

use "bd_finales\estudiante.dta", clear


collapse accesoie ratiocom tratada stratum, by(codmod)


postfile table6_1 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 p n using "resultados\table6_1.dta", replace


local ccc accesoie ratiocom


foreach var in `ccc'{


*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw Difference
reg `var' tratada
local d_m = _b[tratada]
local d_s = _se[tratada]
local n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}




*Adjusted Difference
xi: reg `var' tratada i.stratum
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local d_t2 = abs(`d_m2'/`d_s2')

if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


local abs_t = abs(_b[tratada]/_se[tratada])
local p = 2 * ttail(e(df_r), `abs_t')


display "p=`p'"


post table6_1 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s') ("`star'") (`d_m2') (`d_s2')  ("`star2'") (`p') (`n') 




}


postclose table6_1







use "bd_finales\estudiante.dta", clear


postfile table6_2 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 p n using "resultados\table6_2.dta", replace


local ccc compu compacce usocompu usocompe usocompc usocompp usoint compuse


foreach var in `ccc'{

*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


* Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


reg `var' tratada, cluster(codmod)
local d_m = _b[tratada]
local d_s = _se[tratada]
local n = e(N)
local d_t = abs(`d_m'/`d_s')

if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum, cluster(codmod)
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local d_t2 = abs(`d_m2'/`d_s2')

if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local p = 2 * ttail(e(df_r), `abs_t')


display "p=`p'"



post table6_2 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s')  ("`star'") (`d_m2') (`d_s2')  ("`star2'") (`p') (`n')



}


postclose table6_2





use "resultados\table6_1.dta", clear
append using "resultados\table6_2.dta"


format t_m c_m d_m d_s  d_m2 d_s2  %6.3f


outsheet using "resultados\table6.xls", replace


erase "resultados\table6_1.dta"
erase "resultados\table6_2.dta"











* TABLE 7 - LAPTOP USE AND COMPETENCE - TREATMENT GROUP


use "bd_finales\estudiante.dta", clear


postutil clear


postfile table7 str10 variable mean using "resultados\table7.dta", replace


local list "ceroses unases dosses tresses cuatses jorescol usohogar standard games music program other basic ubicar escribir invest libdib cuentos habilap"



local var "ceroses"
foreach var of local list {
sum `var' if tratada==1


local mean=r(mean)
display "mean=`mean'"


post table7 ("`var'") (`mean')
}







* SAVE THE NUMBER OF OBSERVATIONS - LAPTOP USE

sum ceroses if tratada==1
local n1=r(N)
display "n1=`n1'"


post table7 ("n1") (`n1')



* SAVE THE NUMBER OF OBSERVATIONS - LAPTOP COMPETENCE

sum basic if tratada==1
local n2=r(N)
display "n2=`n2'"


post table7 ("n2") (`n2')


postclose table7


use "resultados/table7.dta", clear


outsheet using "resultados/table7.xls", replace


erase "resultados/table7.dta"














* TABLE 8 - EFFECTS ON BEHAVIOR AND NON-COGNITIVE OUTCOMES - INTERVIEWED SAMPLE

use "bd_finales\estudiante.dta", clear


collapse totestud tratada stratum, by(codmod)


postfile table8_1 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 p n  using "resultados\table8_1.dta", replace


local ccc totestud


foreach var in `ccc'{


*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw Difference
reg `var' tratada
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local n = e(N)
local d_t2 = abs(`d_m2'/`d_s2')


if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local p = 2 * ttail(e(df_r), `abs_t')


display "p=`p'"



post table8_1 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s')  ("`star'") (`d_m2') (`d_s2')  ("`star2'") (`p') (`n')

}



postclose table8_1





use "bd_finales\estudiante.dta", clear



* ATTENDANCE (asisten) IS ONLY FOR THE INTERVIWED SAMPLE, SO WE REMOVE THE 2ND GRADE

replace asisten = . if grupo == "2"


postfile table8_2 str10 variable t_m c_m d_m d_s str5 star d_m2 d_s2 str5 star2 p n using "resultados\table8_2.dta", replace


local ccc asisten tareaaye ecmash leyoaye leer behavior motiva autocon noncogni


foreach var in `ccc'{


*Mean Treatment
sum `var' if tratada == 1
local t_m = r(mean)


*Mean Control
sum `var' if tratada == 0
local c_m = r(mean)


*Raw Difference
reg `var' tratada, cluster(codmod)
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


*Adjusted Difference
xi: reg `var' tratada i.stratum, cluster(codmod)
local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local n = e(N)
local d_t2 = abs(`d_m2'/`d_s2')


if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local p = 2 * ttail(e(df_r), `abs_t')


display "p=`p'"



post table8_2 ("`var'") (`t_m') (`c_m') (`d_m') (`d_s')  ("`star'") (`d_m2') (`d_s2') ("`star2'") (`p') (`n')

}


postclose table8_2







use "resultados\table8_1.dta", clear
append using "resultados\table8_2.dta"


format t_m c_m d_m d_s d_m2 d_s2  %6.3f


outsheet using "resultados\table8.xls", replace


erase "resultados\table8_1.dta"
erase "resultados\table8_2.dta"













* TABLE 9 - EFFECTS ON ACADEMIC ACHIEVEMENT AND COGNITIVE SKILLS

use "bd_finales\estudiante.dta", clear



postfile table9 str10 variable a1_m a1_s str5 stara1 d1_m d1_s str5 star1 d1_p d1_n a2_m a2_s str5 stara2 d2_m d2_s str5 star2 d2_p d2_n using "resultados\table9.dta", replace


local outcomes mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `outcomes'{


reg `var' tratada, cluster(codmod)
local a1_m = _b[tratada]
local a1_s = _se[tratada]
local a1_t = abs(`a1_m'/`a1_s')


if `a1_t' > 1.9599 & `a1_t' != . {
local stara1  **
}
else if `a1_t' > 1.6448 & `a1_t' != . {
local stara1  *
}
else {
local stara1 ""
}



xi: reg `var' tratada i.stratum, cluster(codmod)
local d1_m = _b[tratada]
local d1_s = _se[tratada]
local d1_n = e(N)
local d1_t = abs(`d1_m'/`d1_s')


if `d1_t' > 1.9599 & `d1_t' != . {
local star1  **
}
else if `d1_t' > 1.6448 & `d1_t' != . {
local star1  *
}
else {
local star1 ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d1_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d1_p'"









reg `var' tratada if (grupo=="S" | grupo=="6"), cluster(codmod)
local a2_m = _b[tratada]
local a2_s = _se[tratada]
local a2_n = e(N)
local a2_t = abs(`a2_m'/`a2_s')




if `a2_t' > 1.9599 & `a2_t' != . {
local stara2  **
}
else if `a2_t' > 1.6448 & `a2_t' != . {
local stara2  *
}
else {
local stara2 ""
}





xi: reg `var' tratada i.stratum  if (grupo=="S" | grupo=="6"), cluster(codmod)
local d2_m = _b[tratada]
local d2_s = _se[tratada]
local d2_n = e(N)
local d2_t = abs(`d2_m'/`d2_s')


if `d2_t' > 1.9599 & `d2_t' != . {
local star2  **
}
else if `d2_t' > 1.6448 & `d2_t' != . {
local star2  *
}
else {
local star2 ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d2_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d2_p'"



post table9 ("`var'") (`a1_m') (`a1_s') ("`stara1'") (`d1_m') (`d1_s') ("`star1'") (`d1_p') (`d1_n') (`a2_m') (`a2_s') ("`stara2'") (`d2_m') (`d2_s') ("`star2'") (`d2_p') (`d2_n') 

}


postclose table9


use "resultados\table9.dta", clear
format a1_m a1_s d1_m d1_s d1_p a2_m a2_s d2_m d2_s d2_p %6.3f


outsheet using "resultados\table9.xls",replace


erase "resultados\table9.dta"















* TABLE 10 - HETEROGENEOUS EFFECTS ON ACADEMIC ACHIEVEMENT AND COGNITIVE SKILLS
		
* Second grade

use "bd_finales\estudiante.dta", clear


postfile table10_1 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_1.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn 


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if grupo == "2", cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}


local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"


post table10_1 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_1







* Followed sample

use "bd_finales\estudiante.dta", clear


postfile table10_2 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_2.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if grupo == "S", cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_2 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_2






* Sixth grade

use "bd_finales\estudiante.dta", clear


postfile table10_3 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_3.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if grupo == "6", cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_3 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_3










* Female

use "bd_finales\estudiante.dta", clear


postfile table10_4 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_4.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if mujer2 == 1, cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_4 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_4









* Male

use "bd_finales\estudiante.dta", clear


postfile table10_5 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_5.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if mujer2 == 0, cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_5 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_5









* Low Baseline Score (for low baseline score schools)

use "bd_finales\estudiante.dta", clear


postfile table10_6 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_6.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if high == 0, cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_6 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_6









* High Baseline Score (for high baselien score schools)

use "bd_finales\estudiante.dta", clear

postfile table10_7 str10 variable d_m d_s d_p d_n str5 star using "resultados\table10_7.dta", replace


local ccc mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `ccc'{

xi: reg `var' tratada i.stratum if high == 1, cluster(codmod) 
local d_m = _b[tratada]
local d_s = _se[tratada]
local d_n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}



local abs_t = abs(_b[tratada]/_se[tratada])
local d_p = 2 * ttail(e(df_r), `abs_t')


display "p=`d_p'"



post table10_7 ("`var'") (`d_m') (`d_s') (`d_p') (`d_n') ("`star'")
}


postclose table10_7





use "resultados\table10_1.dta", clear
append using "resultados\table10_2.dta"
append using "resultados\table10_3.dta"
append using "resultados\table10_4.dta"
append using "resultados\table10_5.dta"
append using "resultados\table10_6.dta"
append using "resultados\table10_7.dta"


format d_m d_s d_p %6.3f
outsheet using "resultados\table10.xls", replace


erase "resultados\table10_1.dta"
erase "resultados\table10_2.dta"
erase "resultados\table10_3.dta"
erase "resultados\table10_4.dta"
erase "resultados\table10_5.dta"
erase "resultados\table10_6.dta"
erase "resultados\table10_7.dta"











* FIGURE A1 - DISTRIBUTION OF LAPTOP USE BY DAY AND TIME PERIOD


use "bd_finales/estudiante.dta",clear


postutil clear


postfile figurea1 str10 var mean using "resultados/figurea1.dta",replace


local list "sun_0 mon_0 tue_0 wednes_0 thurs_0 fri_0 satur_0 sun_1 mon_1 tues_1 wednes_1 thurs_1 fri_1 satur_1"


*local var "sun_0"
foreach var of local list {


sum `var'
local mean=r(mean)*100
display "mean=`mean'"


post figurea1 ("`var'") (`mean')


}


postclose figurea1


use "resultados/figurea1.dta",clear


outsheet using "resultados/figurea1.xls",replace


erase "resultados/figurea1.dta"











* TABLE A1 - EFFECTS ON SUMMARY MEASURES - ALL SAMPLE

use "bd_finales\estudiante.dta", clear


postutil clear


postfile tablea1 str10 variable d_m d_s str5 star n d_m2 d_s2 str5 star2 n2 using "resultados\tablea1.dta", replace


local ccc compacce compuse behavior noncogni academic cognitiv acadcogn




foreach var in `ccc'{


* Adjusted difference - All sample

xi: reg `var' tratada i.stratum, cluster(codmod)


local d_m = _b[tratada]
local d_s = _se[tratada]
local n = e(N)
local d_t = abs(`d_m'/`d_s')


if `d_t' > 1.9599 & `d_t' != . {
local star  **
}
else if `d_t' > 1.6448 & `d_t' != . {
local star  *
}
else {
local star ""
}





* Adjusted difference - Interviewed sample

xi: reg `var' tratada i.stratum if grupo=="S" | grupo=="6", cluster(codmod)


local d_m2 = _b[tratada]
local d_s2 = _se[tratada]
local n2 = e(N)
local d_t2 = abs(`d_m2'/`d_s2')


if `d_t2' > 1.9599 & `d_t2' != . {
local star2  **
}
else if `d_t2' > 1.6448 & `d_t2' != . {
local star2  *
}
else {
local star2 ""
}


post tablea1 ("`var'") (`d_m') (`d_s') ("`star'") (`n') (`d_m2') (`d_s2') ("`star2'") (`n2')


}


postclose tablea1


use "resultados\tablea1.dta", clear
format d_m d_s d_m2 d_s2  %6.3f


outsheet using "resultados\tablea1.xls", replace


erase "resultados\tablea1.dta"













* TABLE A2 - EFFECTS ON ACADEMIC ACHIEVEMENT AND COGNITIVE SKILLS ROBUSTNESS CHECKS

use "bd_finales\estudiante.dta", clear



postfile tablea2 str10 variable a1_m a1_s str5 stara1 d1_m d1_s str5 star1 d1_n a2_m a2_s str5 stara2 d2_m d2_s str5 star2 d2_n a3_m a3_s str5 stara3 d3_m d3_s str5 star3 d3_n using "resultados\tablea2.dta", replace


local outcomes mate leng academic raven verbal codigos cognitiv acadcogn


foreach var in `outcomes'{


reg `var' tratada, cluster(codmod)
local a1_m = _b[tratada]
local a1_s = _se[tratada]
local a1_t = abs(`a1_m'/`a1_s')


if `a1_t' > 1.9599 & `a1_t' != . {
local stara1  **
}
else if `a1_t' > 1.6448 & `a1_t' != . {
local stara1  *
}
else {
local stara1 ""
}



xi: reg `var' tratada i.stratum, cluster(codmod)
local d1_m = _b[tratada]
local d1_s = _se[tratada]
local d1_n = e(N)
local d1_t = abs(`d1_m'/`d1_s')


if `d1_t' > 1.9599 & `d1_t' != . {
local star1  **
}
else if `d1_t' > 1.6448 & `d1_t' != . {
local star1  *
}
else {
local star1 ""
}



reg `var' tratada fidelity, cluster(codmod)
local a2_m = _b[tratada]
local a2_s = _se[tratada]
local a2_n = e(N)
local a2_t = abs(`a2_m'/`a2_s')


if `a2_t' > 1.9599 & `a2_t' != . {
local stara2  **
}
else if `a2_t' > 1.6448 & `a2_t' != . {
local stara2  *
}
else {
local stara2 ""
}


xi: reg `var' tratada i.stratum fidelity, cluster(codmod)
local d2_m = _b[tratada]
local d2_s = _se[tratada]
local d2_n = e(N)
local d2_t = abs(`d2_m'/`d2_s')


if `d2_t' > 1.9599 & `d2_t' != . {
local star2  **
}
else if `d2_t' > 1.6448 & `d2_t' != . {
local star2  *
}
else {
local star2 ""
}


reg `var' tratada  if fidelity == 1, cluster(codmod)
local a3_m = _b[tratada]
local a3_s = _se[tratada]
local a3_n = e(N)
local a3_t = abs(`a3_m'/`a3_s')


if `a3_t' > 1.9599 & `a3_t' != . {
local stara3  **
}
else if `a3_t' > 1.6448 & `a3_t' != . {
local stara3  *
}
else {
local stara3 ""
}



xi: reg `var' tratada i.stratum if fidelity == 1, cluster(codmod)
local d3_m = _b[tratada]
local d3_s = _se[tratada]
local d3_n = e(N)
local d3_t = abs(`d3_m'/`d3_s')


if `d3_t' > 1.9599 & `d3_t' != . {
local star3  **
}
else if `d3_t' > 1.6448 & `d3_t' != . {
local star3  *
}
else {
local star3 ""
}


post tablea2 ("`var'") (`a1_m') (`a1_s') ("`stara1'") (`d1_m') (`d1_s') ("`star1'") (`d1_n') (`a2_m') (`a2_s') ("`stara2'") (`d2_m') (`d2_s') ("`star2'") (`d2_n') (`a3_m') (`a3_s') ("`stara3'") (`d3_m') (`d3_s') ("`star3'") (`d3_n')
}


postclose tablea2


use "resultados\tablea2.dta", clear
format a1_m a1_s d1_m d1_s a2_m a2_s d2_m d2_s a3_m a3_s d3_m d3_s %6.3f


outsheet using "resultados\tablea2.xls",replace


erase "resultados\tablea2.dta"












* TABLE A3 - PATTERNS OF USE AND LAPTOP COMPETENCE BY SELECTED SUB-GROUPS

use bd_finales\estudiante.dta, clear





postfile tablea3 str10 variable str10 grupo obsg1 mean_g1 str5 star obsg0 mean_g0 using "resultados\tablea3.dta", replace


local outcomes ceroses unases dosses tresses cuatses standard games music program other jorescol basic escribir invest libdib cuentos ubicar habilap


local grupos segundo sexto mujer2 high


local o "standard"
foreach o in `outcomes'{


local g "segundo"
foreach g in `grupos' {

display "outcome=`o'  grupo=`g'"


capture ttest `o' if tratada ==1, by(`g')


local mean_g0 = r(mu_1)
local mean_g1 = r(mu_2)
local t = abs(r(t))


if `t' > 1.9599 & `t' != . {
local star  **
}
else if `t' > 1.6448 & `t' != . {
local star  *
}
else {
local star ""
}


local obsg0 = r(N_1)
local obsg1 = r(N_2) 								

post tablea3 ("`o'") ("`g'") (`obsg1') (`mean_g1') ("`star'") (`obsg0') (`mean_g0') 				
}
}

postclose tablea3


use "resultados\tablea3.dta", clear


format mean_g0 mean_g1 %12.3f


outsheet using "resultados\tablea3.xls", replace


erase "resultados\tablea3.dta"













* OTHER RESULTS




* 1) NUMBER OF TREATMENT AND CONTROL SCHOOLS

use "bd_finales\estudiante.dta", clear


gen aux=1
collapse aux,by(codmod tratada)


tab tratada









* 2) P-VALUE OF EFFECTS ON RAVEN

use "bd_finales\estudiante.dta", clear


xi: reg raven tratada i.stratum, cluster(codmod)


xi: reg raven tratada i.stratum if grupo=="S"| grupo=="6", cluster(codmod)









* 3) P-VALUE OF EFFECTS ON COGNITIVE SKILLS SUMMARY MEASURE

use "bd_finales\estudiante.dta", clear


xi: reg cognitiv tratada i.stratum, cluster(codmod)


xi: reg cognitiv tratada i.stratum if grupo=="S"| grupo=="6", cluster(codmod)







* 4) PREVALENCE OF CORRECT TIMING

use "bd_finales\estudiante.dta", clear


bysort tratada: sum fidelity
tab fidelity



gen aux=1
collapse aux,by(codmod tratada fidelity)


bysort tratada: sum fidelity








* 5) CHARACTERISTICS OF THE POPULATION

use "bd_finales\estudiante.dta", clear

sum pprim mprim aguapot desague cincolib








* 6) FIDELITY

use "bd_finales\estudiante.dta", clear


sum fidelity
sum fidelity if tratada==1
sum fidelity if tratada==0


xi: reg fidelity tratada i.stratum,cluster(codmod)








* 7) ATTRITION (FOR THE FOLLOWED COHORT)

use "bd_finales\estudiante.dta", clear

keep if grupo=="S"


gen attrition=0
replace attrition=1 if lbmate==. & lbleng==.


sum attrition
sum attrition if tratada==1
sum attrition if tratada==0


xi: reg attrition tratada i.stratum,cluster(codmod)


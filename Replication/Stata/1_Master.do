*******************************************************************************
* Codes to replicate the sample in ABBL (2021)
* This version: January 2021
* Questions: jdlight@uchicago.edu
*******************************************************************************

*******************************************************************************
* 1. Set global macros 
*******************************************************************************

*** Globals for loading data and saving output
clear all
set more off
set maxvar 30000
set matsize 11000
macro drop _all

if "${S_OS}" == "Unix" {
	local home: environment HOME
}
else {
	local home: environment USERPROFILE
}


global PROGRAMS = "`home'/repos/abbl-replicate/Replication/Stata"
global OUTPUT = "`home'/run/ABBL/output"
global DATA = "`home'/data/PSID/Stata"
global TEMP = "`home'/run/ABBL/tmp"
global TAXSIM = "${OUTPUT}"

*******************************************************************************
* 2. Create Panel
*******************************************************************************
cd "${PROGRAMS}"
/* do 2_Household_Panel
do 3_Individual_Panel
do 3b_Individual_Panel_Parent_Link */

*******************************************************************************
* 3. Generate Aggregate Variables and Get Residuals for Estimation
*******************************************************************************
set more off
/* do 4_Sample_Selection */
do 5_Aggregate_Measures
do 5_Aggregate_Measures_Parent
do 6_Get_Residuals

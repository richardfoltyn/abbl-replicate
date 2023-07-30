#!/bin/bash

DOWNLOAD_DIR="${HOME}/tmp"
DEST_DIR="${HOME}/data/PSID/Stata"

TEMP=`mktemp -d -t PSIDXXX`
STATA=/opt/stata/17/stata-mp

mkdir -p ${TEMP}

run_stata() {

    DO_FILE_ORIG="$1.do"
    OUTFILE="$1.dta"
    DO_FILE="$1_upd.do"

    # Increate maxvar etc.
    echo "set maxvar 30000" > "${DO_FILE}"

    # Remove path placeholder 
    sed -r -e 's/\[path\]\\//' < ${DO_FILE_ORIG} >> ${DO_FILE}

    # Append command to save to output file
    # uses #delimit ;
    echo -e "\nsave ${OUTFILE}, replace;" >> ${DO_FILE}

    ${STATA} -e do ${DO_FILE}
}

extract_and_run() {
    BASENAME="$1"

    cd ${DOWNLOAD_DIR}

    unzip -o "${BASENAME@L}.zip" -d "${TEMP}"

    cd "${TEMP}"

    run_stata "${BASENAME}"

    mv ${OUTFILE} "${DEST_DIR}"
    
    cd -
}


# BASENAME="IND2019ER"
# extract_and_run "${BASENAME}"

# BASENAME="PID19"
# extract_and_run "${BASENAME}"


# Family files 1999-2017
for ((i = 1999; i <= 2017; i=i+2)); do
    BASENAME="FAM${i}ER"
    extract_and_run "${BASENAME}"
done


# Wealth files 1999-2007
for ((i = 1999; i <= 2007; i=i+2)); do

    BASENAME="WLTH${i}"

    extract_and_run "${BASENAME}"
done

rm -rf "${TEMP}"
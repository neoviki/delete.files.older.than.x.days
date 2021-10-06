PREFIX="t.com"
function decrement_current_date()
{
    N_DAYS="$1"
    DATE=`date --date "-${N_DAYS} days" +'%Y %m %d' 2> /dev/null`
    if [ $? -ne 0 ]; then
        DATE=`date -v-${N_DAYS}d  +'%Y %m %d'`
        if [ $? -ne 0 ]; then
            echo "error: unable to decrement date"
            exit 1
        fi
    fi

    YEAR=`echo $DATE | awk '{ print $1 }' `
    MONNTH=`echo $DATE | awk '{ print $2 }' `
    DAY=`echo $DATE | awk '{ print $3 }' `
    
    #echo "$DAY $MONNTH $YEAR"
}

function generate_test_files(){
    
    for ((i=0;i<30;i++))
    do
        decrement_current_date $i
        echo "creating file with old date ( ${YEAR} ${MONNTH} ${DAY} ) -> ( ${PREFIX}.$i.txt )"
        touch -a -m -t "${YEAR}${MONNTH}${DAY}0130.09" "${PREFIX}.$i.txt"
    done

    for ((i=0;i<30;i++))
    do
        decrement_current_date $i
        echo "creating file with old date ( ${YEAR} ${MONNTH} ${DAY} ) -> ( ${PREFIX}.$i.txt.dummy )"
        touch -a -m -t "${YEAR}${MONNTH}${DAY}0130.09" "${PREFIX}.$i.txt.dummy"
    done

}

function create_sandbox()
{
    cp ../delete_files_older_than_x_days .
    cp ../banner.sh .
}

function verify_delete_1()
{

    for ((i=0;i<30;i++))
    do
        if [ ! -f "${PREFIX}.$i.txt.dummy" ]; then
            echo "verification_failure: dummy files are deleted, it should not be deleted"
            exit 1
        fi
    done

    for ((i=11;i<30;i++))
    do
        if [ -f "${PREFIX}.$i.txt" ]; then
            echo "verification_failure: few files older than 10 days are not deleted"
            exit 1
        fi
    done

    for ((i=0;i<=10;i++))
    do
        if [ ! -f "${PREFIX}.$i.txt" ]; then
            echo "verification_failure: few files not older than 10 days are deleted"
            exit 1
        fi
    done

    echo "verification 1 success"


}

function verify_delete_2()
{

    for ((i=11;i<30;i++))
    do
        if [ -f "${PREFIX}.$i.txt.dummy" ]; then
            echo "verification_failure: few files older than 10 days are not deleted"
            exit 1
        fi
    done

    for ((i=0;i<=10;i++))
    do
        if [ ! -f "${PREFIX}.$i.txt.dummy" ]; then
            echo "verification_failure: few files not older than 10 days are deleted"
            exit 1
        fi
    done

    echo "verification 2 success"


}


create_sandbox
generate_test_files
./delete_files_older_than_x_days 10 '.txt'
verify_delete_1
./delete_files_older_than_x_days 10
verify_delete_2

echo "unit test is successful"
./ut_clean.sh

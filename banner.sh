#!/bin/bash
# Version 1.0
# banner.sh | utility to create information banner 
#
#		Author	: Viki (a) Vignesh Natarajan 
#		Contact	: vikiworks.io
#		Licence : MIT


SYMBOL="#"
PRINT_WIDTH=80

LEFT_PADDING=4
RIGHT_PADDING=4

#Left Offset
LEFT_OFFSET=4

function dec_print_quota()
{
    if [ $PRINT_QUOTA -gt 0 ]; then
        PRINT_QUOTA=`expr $PRINT_QUOTA - 1`
    fi
}

function print_characters()
{
    STR="$@"
    while [ -n "$STR" ]; do
            
        next=${STR#?}
        STR_D="${STR%$next}"


        if [ $PRINT_QUOTA -gt 0 ]; then
            echo -n "$STR_D" 
            dec_print_quota
        fi
        
        STR=$next
    done
}

function print_ncharacter()
{
    CHAR_VAL="$1"
    NCHAR_COUNT=$2

    if [ -z $NCHAR_COUNT ]; then
        return
    fi

    for ((i=0;i<$NCHAR_COUNT;i++))
    do
        if [ $PRINT_QUOTA -gt 0 ]; then
            echo -n "$CHAR_VAL" 
            dec_print_quota
        fi
    done
}

function print_nspace()
{
    SP_COUNT=$1
    if [ -z $SP_COUNT ]; then
        return
    fi

    for ((i=0;i<$SP_COUNT;i++))
    do
        if [ $PRINT_QUOTA -gt 0 ]; then
            echo -n " "
            dec_print_quota
        fi
    done
}

function print_reset()
{
    PRINT_QUOTA=`expr $PRINT_WIDTH - $LEFT_OFFSET - 1 - $LEFT_PADDING - $RIGHT_PADDING - 1`
}

function print_header()
{
    print_reset
    echo
    echo
    echo
    prepend_symbol
    print_ncharacter "$SYMBOL" "$PRINT_QUOTA"
    append_symbol 
    print_reset
}


function print_footer()
{
    print_reset
    prepend_symbol
    print_ncharacter "$SYMBOL" "$PRINT_QUOTA"
    append_symbol 
    echo
    echo
    echo
    echo
    print_reset
}

function prepend()
{
    print_reset
    for ((i=0;i<$LEFT_OFFSET;i++))
    do
        echo -n " "
    done
    echo -n "$SYMBOL"

    for ((i=0;i<$LEFT_PADDING;i++))
    do
        echo -n " "
    done

}

function prepend_symbol()
{
    print_reset
    for ((i=0;i<$LEFT_OFFSET;i++))
    do
        echo -n " "
    done
    echo -n "$SYMBOL"

    for ((i=0;i<$LEFT_PADDING;i++))
    do
        echo -n "$SYMBOL"
    done

}


function append()
{
    print_nspace $PRINT_QUOTA

    for ((i=0;i<$RIGHT_PADDING;i++))
    do
        echo -n " "
    done
    
    echo -n "$SYMBOL"
    echo
    print_reset
}

function append_symbol()
{
    print_ncharacter "$SYMBOL" $PRINT_QUOTA

    for ((i=0;i<$RIGHT_PADDING;i++))
    do
        echo -n "$SYMBOL"
    done
    
    echo -n "$SYMBOL"
    echo
    print_reset
}


function print_empty_line()
{
    print_reset
    prepend
    print_nspace $PRINT_QUOTA
    append
    print_reset
}


function print_left()
{
    print_reset
    L_STR="$@"
    L_STR_LEN=${#L_STR}

    prepend
    print_characters "$L_STR"
    append
    print_reset
}

function print_right()
{
    print_reset
    R_STR="$@"
    R_STR_LEN=${#R_STR}

    prepend
    R_SPACE=`expr $PRINT_QUOTA - $R_STR_LEN - 4`
    print_nspace $R_SPACE
    print_characters "$R_STR"
    append
    print_reset

}

function print_center()
{
    print_reset
    C_STR="$@"
    C_STR_LEN=${#C_STR}

    prepend
    
    C_SPACE=`expr $PRINT_QUOTA - $C_STR_LEN`
    C_SPACE=`expr $C_SPACE / 2`
    
    if [ $C_SPACE -le 0 ]; then
        C_SPACE=2
    fi

    print_nspace $C_SPACE
    print_characters "$C_STR"
    append
    print_reset

}

print_header
print_empty_line
print_empty_line
print_empty_line
print_center 'delete_files_older_than_x_days'
print_empty_line
print_empty_line
print_empty_line
print_left 'Applications:'
print_empty_line
print_left ' 1. Delete files older than X days from current directory '
print_left ' 2. Delete files with extn ".jpg" and X days older'
print_empty_line
print_empty_line
print_empty_line
print_empty_line
print_right 'Designed By : Vignesh Natarajan'
print_right 'Contact     : vikiworks.io     '
print_empty_line
print_empty_line
print_footer


#print_characters "ABC BBC CCC"

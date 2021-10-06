## Bash utility to delete files older than x days

    Delete Files older than x days in the current directoru

## Usage 

    ./delete_files_older_than_x_days <days: number> <file_extension>


## Example
    
    ./delete_files_older_than_x_days 2 ".txt"

    This command delete all files with modified time older than 2 days and with ".txt" from the current directory.

## Note

    Wildcard characters are not supported ( example * )

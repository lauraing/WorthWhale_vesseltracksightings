# convert GPX to CSV (take 1: slow, hard-to-understand version)
#
# frew@ucsb.edu 2019-10-09
#
# all grovel before my mad UNIX skillz

echo 'lat,lon,time'                 # CSV header
cat "$@" |                          # gather input files
    tidy -xml 2>/dev/null |         # convert to one-line-per-XML-tag
    sed -n '
                                    # extract lat,
        s/.*lat="\(.*\)".*/\1,/p
                                    # extract lon,
        s/.*lon="\(.*\)".*/\1,/p
                                    # extract time;
        s/.*time>\(.*\)<.*/\1;/p
    ' |
    tr -d '\012' |                  # collapse into 1 line
    tr ';' '\012' |                 # add line breaks after times
    fgrep ','                       # get rid of lines containing only time

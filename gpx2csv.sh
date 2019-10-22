# convert GPX to CSV (take 3: works even if you aren't Frew ...)
#
# frew@ucsb.edu 2019-10-09
#
# all grovel before my mad UNIX skillz

export HTML_TIDY=                   # disable local "tidy" customizations

cat "$@" |                          # gather input files
    tidy -xml 2>/dev/null |         # convert to one-line-per-XML-tag
    gawk '
        # expecting:
        #
        # <trkpt lat="..." lon="...">
        # <time>...</time>
        # </trkpt>


        BEGIN {
            print "lat,lon,time"    # CSV header

            lat = lon = time = "oops"
        }

        /<trkpt/ {
            lat = $0
            sub(/^.*lat="/, "", lat)
            sub(/".*$/,     "", lat)

            lon = $0
            sub(/^.*lon="/, "", lon)
            sub(/".*$/,     "", lon)

            next
        }

        /<time>/ {                  # time

            time = $0
            sub(/.*<time>/,   "", time)
            sub(/<\/time>.*/, "", time)

            next
        }

        /<\/trkpt>/ {
            printf("%s,%s,%s\n", lat, lon, time)

            lat = lon = time = ""

            next
        }
    '

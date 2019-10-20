# convert GPX to CSV for year 2014
#
#
#
# all grovel before my mad UNIX skillz

cat "$@" |                          # gather input files
    tidy -xml 2>/dev/null |         # convert to one-line-per-XML-tag
    gawk '
        BEGIN {
            print "lat,lon,time"    # CSV header
            in_trk = "F"            # are we processing a track?
        }

        /<trk>/ {                   # begin track
            in_trk = "T"

            next
        }
        
        /<\/trk>/ {                 # end track
            in_trk = "F"

            next
        }

        in_trk == "F" {
            next                    # skip input lines not in tracks
        }

        /lat=/ {                    # latitude
            sub(/.*lat="/, "")
            sub(/".*/, "")
            lat = $0

            next
        }

        /lon=/ {                    # longitude
            sub(/.*lon="/, "")
            sub(/".*/, "")
            lon = $0

            next
        }

        /<time>/ {                  # time
            sub(/.*<time>/, "")
            sub(/<.*/, "")
            time = $0

            printf("%s,%s,%s\n", lat, lon, time)

            lat = ""
            lon = ""
            time = ""

            next
        }
		'
		>2014.csv
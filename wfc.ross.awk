## map of total invoices (including tax)
/HPN-.*Sales/ {if (NF==7) map[$1]=$5; }


/HPN-.*Sales/ {
    if (NF==5) {
        if($1 in map) {
            inv=$1
            date=$3
            total=$5

            ## access next row
            getline;
            nnumber=$5
            gallons=$6
            rate=$9
            pretaxtotal=$11
            adjrate=total/gallons
            print date,inv,nnumber,gallons,rate,pretaxtotal,total,adjrate
        }
    }
}

##END {for (i in map) { print i,map[i]} }

## rows of invoice only without tax / rounding problem
## /100LL/ {if (NF==11) print $5,$6,$9,$11,$11 * 1.04375; }

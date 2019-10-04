@include "iif.lib.awk"

BEGIN {
    FS="\t"
    bill_header()
}

{
    date=$1
    time=$2
    invoice=$3
    airport=$4
    vendor=$5
    tail=$6
    quantity=$7 ## gallons
    price=$8 ## need to round to 5 places
    if(NF==10) {
        pilot=$10
    } else {
        pilot=""
    }
    ##invalid_calc=abs(total - (price * quantity)) >= .005)
    bill(date,time,vendor,invoice,tail,quantity,price,pilot)
}

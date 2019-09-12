@include "iif.lib.awk"
BEGIN { bill_header() }
{
    date=$1
    time=$2
    invoice=$3
    airport=$4
    vendor=$5
    tail=$6
    quantity=$7 ## gallons
    price=$9 ## need to round to 5 places
    ## safe for debugging
    ##total=$10
    ##invalid_calc=abs(total - (price * quantity)) >= .005)
    bill(date,time,vendor,invoice,tail,quantity,price)
}

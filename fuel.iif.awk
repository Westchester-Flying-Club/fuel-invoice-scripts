@include "iif.lib.awk"

{
    bill_header()
    date=$1
    time=$2
    invoice=$3
    airport=$4
    vendor=$5
    tail=$6
    quantity=$7 ## gallons
    price=$9 ## need to round to 5 places
    bill(date,time,vendor,invoice,tail,quantity,price)
}

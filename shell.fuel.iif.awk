@include "iif.lib.awk"

BEGIN {
    FS="\t"
    bill_header()
}

{
    date=$1
    airport=$2
    vendor=$3
    invoice=$4
    tail=$5
    quantity=$6 ## gallons
    total=$7
    price = total / quantity
    memo = airport
    bill2(date,ccaccount,vendor,invoice,tail,quantity,price,memo)
}

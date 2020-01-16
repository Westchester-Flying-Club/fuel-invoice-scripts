@include "iif.lib.awk"

BEGIN {
    FS="\t"
    bill_header()
}

{
    date=$1
    airport=$2
    fbo=$3
    invoice=$4
    tail=$5
    quantity=$6 ## gallons
    total=$7
    price = total / quantity
    memo = fbo " / " airport 
    bill2(date,vendor,invoice,tail,quantity,price,memo)
}

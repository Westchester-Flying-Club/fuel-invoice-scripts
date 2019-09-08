@include "iif.lib.awk"

{
    bill_header()
    date=$1
    time=$2
    invoice=$3
    airport=$4
    vendor=$5
    tail=$6
    gallons=$7
    rate=$9
    account="Fuel:Fuel "  tail
    memo="Invoice: " invoice ", " date" "time
    bill(date,vendor,gallons * rate,account,memo)
}

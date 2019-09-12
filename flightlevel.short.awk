BEGIN { OFS="," }

## for abs
@include "iif.lib.awk"

/Invoice/ {
    invoice=$2
    date=$3
    getline;
    gsub(/\./,":",$1)
    time=$1
}


/1.*Fuel.*100LL/ {
    nnumber=$4
    quantity=$5
    price=$7
    total=$8
    if(abs(total - (price * quantity)) >= .005) {
        print "ERROR, total does not match price * quantity"
    } else {
        print date,time,invoice,"KPOU","FlightLevel",nnumber,quantity,price,total
    }
}

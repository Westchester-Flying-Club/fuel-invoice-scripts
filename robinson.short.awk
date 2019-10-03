BEGIN { OFS="," }

## for abs
@include "iif.lib.awk"


/Invoice/ {
    invoice=$8
}

/[1-9].*Fuel.*AVGAS/ {
    if(NF==8) {
        nnumber=$4
        quantity=$5
        price=$7
        total=$8
    }
    if(NF==9) {
        nnumber=$5
        quantity=$6
        price=$8
        total=$9
    }
    getline;getline;
    date=$2
    time=$4

    if(abs(total - (price * quantity)) >= .005) {
        print "ERROR, total does not match price * quantity"
    } else {
        print date,time,invoice,"KHVN","Robinson",nnumber,quantity,price,total
    }
}

BEGIN { OFS="," }

/Payment, Fuel/ {
    invoice=$1
    date=$3
    total=$7
}

/For.*Gallon/ {
    if(NF==4) {
        nnumber=$2
        gallons=$3
    }
    if(NF==5) {
        nnumber=$3
        gallons=$4
    }
    time=""
    rate=total/gallons
    actualrate=rate
    print date,time,invoice,"KHVN","Robinson",nnumber,gallons,rate,actualrate,total
}

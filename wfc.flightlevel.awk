/VISA\/MASTERCARD/ {
    if(NF==12) {
        inv=$1
        date=$3    
        nnumber=$8
        gallons=$9
        total=$12
        print date,"KPOU",inv,nnumber,gallons,rate,total
    }
}

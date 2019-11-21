BEGIN { OFS="\t" }

/AVGAS.*Gallon/ {
    date=$1
    invoice=$2
    nnumber=$3
    if(NF==8) {
        quantity=$5
        price=$7
        total=$8
    } else if(NF==9) {
        quantity=$6
        price=$8
        total=$9
    }
    time=""
    print date,time,invoice,"KHVN","Robinson",nnumber,quantity,price,total
}

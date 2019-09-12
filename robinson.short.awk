BEGIN { OFS="," }

/Invoice/ {
    invoice=$8

}
/1.*Fuel.*AVGAS/ {
    if(NF==8) {
        nnumber=$4
        gallons=$5
        rate=$7
        total=$8
    }
    if(NF==9) {
        nnumber=$5
        gallons=$6
        rate=$8
        total=$9
    }
    getline;getline;
    date=$2
    time=$4
    actualrate=total/gallons
    print date,time,invoice,"KHVN","Robinson",nnumber,gallons,rate,actualrate,total
}

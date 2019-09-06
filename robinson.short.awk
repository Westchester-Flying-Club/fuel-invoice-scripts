BEGIN { OFS="," }

/Invoice/ {
    if(NF==9) {
        invoice=$8
    }
}
/AVGAS/ {
    if(NF==8) {
        nnumber=$4
        gallons=$5
        rate=$7
        total=$8        
        getline;getline;        
        date=$2
        time=$4
        actualrate=total/gallons
        print date,time,invoice,"KHVN","Robinson",inv,nnumber,gallons,rate,actualrate,total
    }
}

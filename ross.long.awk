BEGIN { OFS="," }

/100LL\*Avgas/ {
    date=$1
    invoice=$2
    nnumber=$3
    if(NF==11) {
        quantity=$8
    } else {
        quantity=$7
    }
    getline;
    total=$NF
    actualrate=total/quantity
    print date,time,"KHPN","Ross",invoice,nnumber,quantity,actualrate,total
}

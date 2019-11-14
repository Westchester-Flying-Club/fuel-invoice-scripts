BEGIN { OFS="\t" }

/100LL\*Avgas/ {
    if(NF==11) {
        offset=1
    } else {
        offset=0
    }

    date=$1
    invoice=$2
    nnumber=$3
    quantity=$(7+offset)
    pretax_total=$(10+offset)
    total=pretax_total *  (1+4.375/100)
    actualrate=total/quantity
    print date,time,"KHPN","Ross Aviation",invoice,nnumber,quantity,actualrate,total
}

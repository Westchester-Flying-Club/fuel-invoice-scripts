BEGIN { OFS="," }
/HPN-.*Sales/ {
    inv=$1
    date=$3
    total=$5
}
/100LL\*Avgas/ {
        nnumber=$5
        gallons=$6
        rate=$9
        actualrate=total/gallons
        print date,time,"KHPN","Ross",inv,nnumber,gallons,rate,actualrate,total
}

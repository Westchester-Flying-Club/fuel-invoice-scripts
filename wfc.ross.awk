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
        pretaxtotal=$11
        adjrate=total/gallons
        print date,"KHPN","Ross",inv,nnumber,gallons,rate,pretaxtotal,total,adjrate
}

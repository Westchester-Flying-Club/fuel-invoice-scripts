BEGIN { OFS="," }

/VISA\/MASTERCARD/ {
    if(NF==12) {
        invoice=$1
        date=$3    
        nnumber=$8
        gallons=$9
        total=$12
        rate=total/gallons
        actualrate=rate
        print date,"","KPOU","FlightLevel",invoice,nnumber,gallons,rate,actualrate,total
    }
}

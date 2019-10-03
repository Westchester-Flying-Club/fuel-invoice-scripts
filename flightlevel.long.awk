BEGIN { OFS="," }

/VISA\/MASTERCARD/ {
    if(NF==12) {
        invoice=$1
        date=$3    
        nnumber=$8
        gallons=$9
        total=$12
        actualrate=total/gallons
        print date,"","KPOU","FlightLevel",invoice,nnumber,gallons,actualrate,total
    }
}

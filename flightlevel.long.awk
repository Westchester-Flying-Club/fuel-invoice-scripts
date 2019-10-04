BEGIN { OFS="\t" }

/VISA\/MASTERCARD/ {
    if(NF==12) {
        invoice=$1
        date=$3    
        nnumber=$8
        gallons=$9
        total=$12
        actualrate=total/gallons
        print date,"","KPOU","Flight Level",invoice,nnumber,gallons,actualrate,total
    }
}

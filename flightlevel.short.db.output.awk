## for abs
@include "iif.lib.awk"

BEGIN { OFS="\t" }

/Invoice/ {
    invoice=$2
    date=$3
    getline;
    gsub(/\./,":",$1)
    time=$1
}


/[1-9].*Fuel.*100LL/ {
    invoice_line=$1
    nnumber=$4
    quantity=$5
    price=$7
    total=$8
    notes=""
    if(abs(total - (price * quantity)) >= .005) {
        print "ERROR, total does not match price * quantity"
    } else {
        print date,time,invoice,invoice_line,"KPOU","Flight Level",nnumber,quantity,price,total,notes,RPTNAME
    }
}

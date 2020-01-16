## for abs
@include "iif.lib.awk"

BEGIN { OFS="\t" }

/Invoice/ {
    invoice=$8
}

/[1-9].*Fuel.*AVGAS/ {
    if(NF==8) {
        invoice_line=$1
        nnumber=$4
        quantity=$5
        price=$7
        total=$8
    }
    if(NF==9) {
        invoice_line=$1
        nnumber=$5
        quantity=$6
        price=$8
        total=$9
    }
    getline;getline;
    date=$2
    time=$4
    notes=""
    if(abs(total - (price * quantity)) >= .005) {
        print "ERROR, total does not match price * quantity"
    } else {
        print date,time,invoice,invoice_line,"KHVN","Robinson Aviation, Inc.",nnumber,quantity,price,total,notes,RPTNAME
    }
}

@include "iif.lib.awk"

BEGIN {
    OFS="\t"
    i=1
}

/Invoice/ {
    invoice=$2
}


/1.*Fuel.*100LL.*West/ {
    nnumber=$6
    quantity=$7
    items[i]["nnumber"] = nnumber
    items[i]["quantity"] = quantity

}

/2.*Fuel.*100LL.*West/ {
    print "ERROR not set up for 2 line invoice"
}

/Delivered/ {
    invoice_date=$2
    time=$4
    items[i]["date"] = date;
    items[i]["time"] = time

    getline;
    if($1!="Subtotal") {
        gsub(/^[ \t]+/, "", $0)
        gsub(/[ \t]+$/,"",$0)
        gsub(/Fuel requested by /,"",$0)
        gsub(/ - Pilot/,"",$0)
        notes=$0
    }
}

/Total Due/ {
    invoice_total=$3
    items[i]["price"] = invoice_total/quantity
    bill_from_array(invoice_date,"Ross Aviation",invoice,invoice_total,notes,items)
}






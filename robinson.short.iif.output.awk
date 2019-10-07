## for abs
@include "iif.lib.awk"

BEGIN {
    OFS="\t"
    i=1
}

/Invoice/ {
    invoice=$8
    invoice_date=$9
}

/[1-9].*Fuel.*AVGAS/ {
    if(NF==8) {
        nnumber=$4
        quantity=$5
        price=$7
        total=$8
    }
    if(NF==9) {
        nnumber=$5
        quantity=$6
        price=$8
        total=$9
    }
    getline;getline;
    date=$2
    time=$4

    items[i]["date"] = date;
    items[i]["time"] = time
    items[i]["nnumber"] = nnumber
    items[i]["quantity"] = quantity
    items[i]["price"] = price
    invoice_total += total
    i++
}

/Subtotal/ {
    printed_inv_total = $2
    if(abs(invoice_total - printed_inv_total) > 0) {
        print "ERROR, invoice total does not add up to spltis",invoice_total,printed_inv_total
    }
}

END {
    bill_from_array(invoice_date,"Robinson Aviation, Inc.",invoice,invoice_total,"",items)
}

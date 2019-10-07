## for abs
@include "iif.lib.awk"

BEGIN {
    OFS="\t"
    i=1
}

/Invoice/ {
    invoice=$2
    date=$3
    getline;
    gsub(/\./,":",$1)
    time=$1
}


/[1-9].*Fuel.*100LL/ {
    nnumber=$4
    quantity=$5
    total=$8
    price=total/quantity

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
    bill_from_array(invoice_date,"Flight Level",invoice,invoice_total,"",items)
}


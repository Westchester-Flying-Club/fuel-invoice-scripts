BEGIN { OFS="," }

## for abs
@include "iif.lib.awk"

/Invoice/ {
    invoice=$2
}


/1.*Fuel.*100LL.*West/ {
    nnumber=$6
    quantity=$7
    price=$11
}

/Delivered/ {
    date=$2
    time=$4
    getline;
    if($1!="Subtotal") {
        notes=$0
    }
}

# /Pilot/ {
#     notes=$0
# }

# /Fuel requested by/ {
#     notes=$0
# }

/Total Due/ {
    total=$3
    price=total/quantity
    print date,time,invoice,"KHPN","Ross",nnumber,quantity,price,total,notes
}






BEGIN { OFS="\t" }

/Invoice/ {
    invoice=$2
}


/[1-9].*Fuel.*100LL.*West/ {
    invoice_line=$1
    nnumber=$6
    quantity=$7
    price=$11
}

/Delivered/ {
    date=$2
    time=$4
    getline;
    if($1!="Subtotal") {
        gsub(/^[ \t]+/, "", $0)
        gsub(/[ \t]+$/,"",$0)
        gsub(/Fuel requested by /,"",$0)
        gsub(/ - Pilot/,"",$0)
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
    print date,time,invoice,invoice_line,"KHPN","Ross Aviation",nnumber,quantity,price,total,notes,RPTNAME
}






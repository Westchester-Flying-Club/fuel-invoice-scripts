## for abs
@include "iif.lib.awk"

BEGIN { OFS="\t" }

/Invoice Date /  { split($3,dateparse,"-"); date=dateparse[2]"/"dateparse[3]"/"dateparse[1] }
/Invoice Number/ { invoice=$8 }
/Tail Number/    { nnumber="N"$3 }

/Avgas/ {
    invoice_line=$1
    time=$3
    quantity=$6
    gsub(/\$/,"",$7);
    price=$7
    gsub(/\$/,"",$8);
    total=$8
    notes=""
    print date,time,invoice,invoice_line,"KDXR","Danbury Aviation",nnumber,quantity,price,total,notes,RPTNAME
}

function abs(x){
    return ((x < 0.0) ? -x : x)
}

function bill_header()
{
    OFS="\t"
    print "!TRNS","TRNSTYPE","DATE","ACCNT","NAME","AMOUNT","DOCNUM","MEMO"
    print "!SPL","TRNSTYPE","DATE","ACCNT","AMOUNT","QNTY","PRICE","INVITEM"
    print "!ENDTRNS"
}

function bill(date,time,vendor,invoice,tail,quantity,price,pilot) {
    OFS="\t"
    amount=quantity * price ## needs to be rounded to 2 places
    account="Aircraft Variable Costs:Fuel:Fuel " tail
    item="Fuel:Fuel " tail
    if(pilot!="") {
        memo=time", "pilot
    } else {
        memo=time
    }

    print "TRNS","BILL",date,"Accounts Payable",vendor,-amount,invoice,memo
    print "SPL","BILL",date,account,amount,quantity,price,item
    print "ENDTRNS"
}


function bill_from_array(date,vendor,invoice,invoice_total,memo,splits) {
    OFS="\t"

    print "TRNS","BILL",date,"Accounts Payable",vendor,-invoice_total,invoice,memo
    for(i in splits) {
        account="Aircraft Variable Costs:Fuel:Fuel " splits[i]["nnumber"]
        amount=splits[i]["quantity"] * splits[i]["price"]
        quantity= splits[i]["quantity"]
        price = splits[i]["price"]
        item="Fuel:Fuel " splits[i]["nnumber"]
        ##memo = splits[i]["time"]
        print "SPL","BILL",date,account,amount,quantity,price,item
    }

    print "ENDTRNS"
}

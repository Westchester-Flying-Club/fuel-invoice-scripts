function abs(x){
    return ((x < 0.0) ? -x : x)
}

function bill_header()
{
    OFS="\t"
    print "!TRNS","TRNSTYPE","DATE","ACCNT","NAME","AMOUNT","DOCNUM","MEMO"
    print "!SPL","TRNSTYPE","DATE","ACCNT",accou"AMOUNT","QNTY","PRICE","INVITEM"
    print "!ENDTRNS"
}

function bill(date,time,vendor,invoice,tail,quantity,price) {
    OFS="\t"
    amount=quantity * price ## needs to be rounded to 2 places
    account="Aircraft Variable Costs:Fuel:Fuel " tail
    item="Fuel:Fuel " tail
    memo="Invoice: " invoice ", " date" "time

    print "TRNS","BILL",date,"Accounts Payable",vendor,-amount,invoice,memo
    print "SPL","BILL",date,account,amount,quantity,price,item
    print "ENDTRNS"
}

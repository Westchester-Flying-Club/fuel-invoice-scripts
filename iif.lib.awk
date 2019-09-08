function bill_header()
{
    OFS="\t"
    print "!TRNS","TRNSID","TRNSTYPE","DATE","ACCNT","NAME","AMOUNT","MEMO"
    print "!SPL","SPLID","TRNSTYPE","DATE","ACCNT","AMOUNT"
    print "!ENDTRNS"
}

function bill(date,vendor,amount,account,memo) {
    OFS="\t"
    print "TRNS","BILL",date,"Accounts Payable",vendor,-amount,memo
    print "SPL","BILL",date,account,amount
    print "ENDTRNS"
}

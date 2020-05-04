function abs(x){
    return ((x < 0.0) ? -x : x)
}

function bill_header()
{
    OFS="\t"
    print "!TRNS","TRNSTYPE","DATE","ACCNT","NAME","AMOUNT","DOCNUM","MEMO"
    print "!SPL","TRNSTYPE","DATE","ACCNT","AMOUNT","QNTY","PRICE","INVITEM","CLASS","DESC"
    print "!ENDTRNS"
}

function tail2type(tail) {
    if(tail == "N17AV" || tail=="N4508X")
        return "PA28"
    else if(tail == "N190FT" || tail == "N787BG")
        return "PA28R"
    else if(tail == "N9003S" || tail == "N275BM")
        return "BE35"
    else if(tail == "N298AM") 
        return"SR20"
    else
	return "Unknown"
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
    class=tail
    print "TRNS","CREDIT CARD",date,"Accounts Payable",vendor,-amount,invoice,memo
    print "SPL","CREDIT CARD",date,account,amount,quantity,price,item,class
    print "ENDTRNS"
}

function bill2(date,ccacount,vendor,invoice,tail,quantity,price,memo) {
    OFS="\t"
    amount=quantity * price ## needs to be rounded to 2 places
    account="Aircraft Variable Costs:Fuel:Fuel " tail
    item="Fuel:Fuel " tail
    if(tail == "N17AV" || tail=="N4508X")
        type = "PA28"
    else if(tail == "N190FT" || tail == "N787BG")
        type = "PA28R"
    else if(tail == "N9003S" || tail == "N275BM")
        type = "BE35"
    else if(tail == "N298AM") 
        type = "SR20"

    class = type ":" tail
    print "TRNS","CREDIT CARD",date,ccacount,vendor,-amount,invoice,memo
    print "SPL","CREDIT CARD",date,account,amount,quantity,price,item,class
    print "ENDTRNS"
}


function bill_from_array(date,vendor,invoice,invoice_total,memo,splits) {
    OFS="\t"

    print "TRNS","CREDIT CARD",date,"Accounts Payable",vendor,-invoice_total,invoice,memo
    for(i in splits) {
        account="Aircraft Variable Costs:Fuel:Fuel " splits[i]["nnumber"]
        amount=splits[i]["quantity"] * splits[i]["price"]
        quantity= splits[i]["quantity"]
        price = splits[i]["price"]
        item="Fuel:Fuel " splits[i]["nnumber"]
        ##memo = splits[i]["time"]
        print "SPL","CREDIT CARD",date,account,amount,quantity,price,item
    }

    print "ENDTRNS"
}

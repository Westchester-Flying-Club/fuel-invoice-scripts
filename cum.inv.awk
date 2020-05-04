@include "iif.lib.awk"

function iif_split(date, account, amount, quantity, price, item, class, desc) {

	print "SPL","CREDIT CARD",date,account,amount,quantity,price,item,class,desc
}	

BEGIN { 
	FPAT = "([^,]+)|(\"[^\"]+\")";
	current_inv="";
	bill_header();
} 
/^"5994"/ {
	for(i=1;i<=NF;i++) {
		## remove double quotes
		gsub("\"","",$i);
	}

	# init
	##if (current_inv=="") current_inv=$10 
	
	## clean amounts
	gsub("\\$","",$16)
	gsub("\\$","",$17)
	
	# re-init
	if($10 != current_inv) {
    		if(NR>2) print "ENDTRNS"
		current_inv = $10
		nnumber = $3
		date = $7
		vendor = $8
		total_amount = $17
		card_account = "Shell Aviation Card"
		location = $9
		invoice = $10
		memo = "Fuel / " nnumber " / " location
		## initial record
		print "TRNS","CREDIT CARD",date,card_account,vendor,-total_amount,invoice,memo

		## splits
		##SPL CREDIT CARD 2020-01-02 Aircraft Variable Costs:Fuel:Fuel N4508X 144.84 28.4 5.1 Fuel:Fuel N4508X PA28:N4508X
		account = "Aircraft Variable Costs:Fuel:Fuel " nnumber
		amount = $16
		quantity = $12
		price = $14 
		class = tail2type(nnumber) ":" nnumber
		item = "Fuel:Fuel " nnumber
		desc = $11

		iif_split(date, account, amount, quantity, price, item, class,desc)
	} else {
		amount = $16
		desc = $11
		if ($12 == "") {
			quantity = 1
		} else {
			quantity = $12
		}
		price = $14 
		iif_split(date, account, amount, quantity, price, item, class,desc)
	}
}

END {
	print "ENDTRNS"
}

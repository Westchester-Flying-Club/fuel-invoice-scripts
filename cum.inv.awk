@include "iif.lib.awk"

function iif_split(date, amount, quantity, price, item, class, memo) {

	print "SPL","CREDIT CARD",date,amount,quantity,price,item,class,memo
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
	}
	## splits
	desc = $11
	## account and itme change if this is a Fee due to a member
	if (desc  ~ /Fee|FEE|non fuel/) {
		class = "Member Fees"
		item = "Misc. Expense:Ramp Fees"
	} else {
		class = tail2type(nnumber) ":" nnumber
		item = "Fuel:Fuel " nnumber
	}
	amount = $16
	quantity = $12
	price = $14 

	if ($12 == "") {
		quantity = 1
	} else {
		quantity = $12
	}
	price = $14 
	iif_split(date, amount, quantity, price, item, class,desc)
}

END {
	print "ENDTRNS"
}

@include "iif.lib.awk"

BEGIN { 
	FPAT = "([^,]+)|(\"[^\"]+\")";
	current_inv="";
	bill_header();
} 

/^"[0-9]{8}"/ {
	for(i=1;i<=NF;i++) {
		## remove double quotes
		gsub("\"","",$i);
	}
	## clean date
	gsub(" 12:00:00 AM","",$2);
	date = $2
	nnumber = $4
	vendor = $3
	total_amount = $11
	card_account = "AVFuel Card"
	location = $7
	amount = $16
	quantity = $15
	price = $14 
	# re-init
	if($1 != current_inv) {
		current_inv = $1
    		if(NR>2) print "ENDTRNS"
		memo = "Fuel / " nnumber " / " location
		## initial record
		print "TRNS","CREDIT CARD",date,card_account,vendor,-total_amount,current_inv,memo
	}
	## splits
	desc = $13
	## account and itme change if this is a Fee due to a member
	if (desc  ~ /Fee|FEE|non fuel|RAMP|PARKING/) {
		class = "Member Fees"
		item = "Misc. Expense:Ramp Fees"
	} else {
		class = tail2type(nnumber) ":" nnumber
		item = "Fuel:Fuel " nnumber
	}
	if (desc ~ /RETAIL TAX/ && quantity == 1) {
		quantity = ""
	}
	iif_split(date, amount, quantity, price, item, class, desc)
	##print date, amount, quantity
	##print date, price, item, class, desc, quantity, amount
	##print amount 
}

END {
	print "ENDTRNS"
}

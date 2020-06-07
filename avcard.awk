@include "iif.lib.awk"

BEGIN {
	OFS="\t"
	bill_header();
}


/[0-9]{2}-[A-Z]{3}-[0-9]{2}/{
	day_start = match($1,/^[0-9]{2}/)
	day = substr($1,day_start, RLENGTH);
	mon_start = match($1,/[A-Z]{3}/)
	mon = substr($1,mon_start, RLENGTH);
	year_start= match($1,/[0-9]{2}$/)
	year = substr($1,year_start, RLENGTH);
	year = "20" year
	##print mon_start, RLENGTH;
	date = month_to_number(mon) "/" day "/" year

	invoice = $2
	
	split($3, nnum_a, "/")
	nnumber = nnum_a[1]

	## vendor not used
	##vendor = $4
	iata = $5
	quantity = $8
	price = $10
	total_amount = $11
	card_account = "World Fuel Card"
	memo = "Fuel / " nnumber " / " iata 
	item = "Fuel:Fuel " nnumber
	class = tail2type(nnumber) ":" nnumber
	print "TRNS","CREDIT CARD",date,card_account,location_to_vendor(iata),-total_amount,invoice,memo
	iif_split(date, total_amount, quantity, price, item, class, desc)
	print "ENDTRNS"
}

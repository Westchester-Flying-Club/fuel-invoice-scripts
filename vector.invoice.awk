BEGIN { OFS="\t" }

/\(K[A-Z][A-Z][A-Z]\)/ {
	#print;
	i = match($0,/\(K[A-Z][A-Z][A-Z]\)/)
	if(i!=0) {
		airport=substr($0,i+1,4);
	}
}

/N17AV/ || /N4508X/ || /N190FT/ || /N787BG/ || /N15644/ || /N298AM/ || /N9003S/ || /N275BM/ {
	tail=$1
	type=$2
	date=$3
	time=$4
	ampm=$5
	activity=$6
	fee=$7
	print airport,date,time,ampm,tail,activity,fee;
}

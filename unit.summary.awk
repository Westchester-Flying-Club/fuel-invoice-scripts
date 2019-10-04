{
    quantity += $(NF-2)
    dollars += $NF
}

END {
    print "gallons",quantity;
    print "dollars",dollars;
    print "average price",dollars/quantity;
}

{
    quantity += $7
    dollars += $9
}

END {
    print "gallons",quantity;
    print "dollars",dollars;
    print "average price",dollars/quantity;
}

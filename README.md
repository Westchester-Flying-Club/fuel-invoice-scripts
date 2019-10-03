# fuel-invoice-scripts

parse fuel invoice pdfs for database input

```console
fuel-invoice-scripts$ ./parse.invoices ~/Downloads/wfc/wfc.invoices
```


parse fuel invoice pdfs to iif file for QB
```console
fuel-invoice-scripts$ ./parse.invoices ~/Downloads/wfc/wfc.invoices|awk -F, -f fuel.iif.awk
```

summary of Ross refulings (from the Monthly consolidated statement)
```console
fuel-invoice-scripts$ pdftotext -layout data/RossLong.201909.pdf -|awk -f ross.long.awk |awk -F, '{q+=$(NF-2);d+=$NF}; END { print "gallons",q; print "dollars",d; print "average price",d/q; }'
```

# fuel-invoice-scripts

parse fuel invoice pdfs for database input

```console
fuel-invoice-scripts$ ./parse.invoices ~/Downloads/wfc/wfc.invoices
```


parse fuel invoice pdfs to iif file for QB
```console
fuel-invoice-scripts$ ./parse.invoices ~/Downloads/wfc/wfc.invoices|awk -F, -f fuel.iif.awk
```

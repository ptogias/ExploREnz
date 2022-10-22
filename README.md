# ExploREnz
Function to parse the XML formatted SQL dump provided by the official ExplorEnz website (https://www.enzyme-database.org) and extracting respective tables locally using R.

The provided XML contains 12 main elements - 6 containing data (even positions; 2,4,6,etc.) and 6 describing respective structures (odd possitions; 1,3,5,etc.). 

The function requires the following packages:
 - `dplyr`
 - `data.table`
 - `xml2`
 
To install them you can run

```
install.packages(c("dplyr", "data.table", "xml2"))
```

How to run

```
library(xml2)
library(pbapply)

# Download zipped XML locally
download_xml("https://www.enzyme-database.org/downloads/enzyme-data.xml.gz", quiet = FALSE)

# Unzip and parse
explorenz <- read_xml("enzyme-data.xml.gz")

# Apply function - Export all tables (even positions)
res <- pbsapply(c(2,4,6,8,10,12), function(x) lapply(x, parse_explorenz, file = explorenz))

# Write tables in an excel file
openxlsx::write.xlsx(res, "explorenz.xlsx")
```

Output

```
> str(res, vec.len = 2)
List of 6
 $ :Classes ‘data.table’ and 'data.frame':	20090 obs. of  5 variables:
  ..$ cite_key   : chr [1:20090] "pigeon-d-1987-6155" "roskoski-r-2004-1155" ...
  ..$ ec_num     : chr [1:20090] "2.7.11.6" "2.7.10.2" ...
  ..$ ref_num    : chr [1:20090] "2" "2" ...
  ..$ acc_no     : chr [1:20090] "16839" "24661" ...
  ..$ last_change: chr [1:20090] "2006-06-02 10:35:12" "2007-06-11 13:46:05" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
 $ :Classes ‘data.table’ and 'data.frame':	402 obs. of  7 variables:
  ..$ id         : chr [1:402] "1" "2" ...
  ..$ class      : chr [1:402] "1" "1" ...
  ..$ subclass   : chr [1:402] "1" "1" ...
  ..$ subsubclass: chr [1:402] "0" "2" ...
  ..$ heading    : chr [1:402] "Acting on the CH-OH group of donors" "With a cytochrome as acceptor" ...
  ..$ note       : chr [1:402] "This subclass contains dehydrogenases that act on primary alcohols, secondary alcohols and hemi-acetals. Sub-su"| __truncated__ "" ...
  ..$ last_change: chr [1:402] "2006-05-18 10:47:54" "2006-05-18 10:47:54" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
 $ :Classes ‘data.table’ and 'data.frame':	8012 obs. of  17 variables:
  ..$ ec_num       : chr [1:8012] "1.1.1.1" "1.1.1.2" ...
  ..$ accepted_name: chr [1:8012] "alcohol dehydrogenase" "alcohol dehydrogenase (NADP+)" ...
  ..$ reaction     : chr [1:8012] "(1) a primary alcohol + NAD+ = an aldehyde + NADH + H+;;(2) a secondary alcohol + NAD+ = a ketone + NADH + H+" "an alcohol + NADP+ = an aldehyde + NADPH + H+" ...
  ..$ other_names  : chr [1:8012] "aldehyde reductase; ADH; alcohol dehydrogenase (NAD); aliphatic alcohol dehydrogenase; ethanol dehydrogenase; N"| __truncated__ "aldehyde reductase (NADPH2); NADP-alcohol dehydrogenase; NADP+-aldehyde reductase; NADP+-dependent aldehyde red"| __truncated__ ...
  ..$ sys_name     : chr [1:8012] "alcohol:NAD+ oxidoreductase" "alcohol:NADP+ oxidoreductase" ...
  ..$ comments     : chr [1:8012] "A zinc protein. Acts on primary or secondary alcohols or hemi-acetals with very broad specificity; however the "| __truncated__ "A zinc protein. Some members of this group oxidize only primary alcohols; others act also on secondary alcohols"| __truncated__ ...
  ..$ links        : chr [1:8012] "BRENDA, EXPASY, GTD, IUBMB, KEGG, PDB, UM-BBD" "BRENDA, EXPASY, IUBMB, KEGG, PDB" ...
  ..$ class        : chr [1:8012] "1" "1" ...
  ..$ subclass     : chr [1:8012] "1" "1" ...
  ..$ subsubclass  : chr [1:8012] "1" "1" ...
  ..$ serial       : chr [1:8012] "1" "2" ...
  ..$ status       : chr [1:8012] "" "" ...
  ..$ diagram      : chr [1:8012] "" "" ...
  ..$ cas_num      : chr [1:8012] "9031-72-5" "9028-12-0" ...
  ..$ glossary     : chr [1:8012] "" "" ...
  ..$ last_change  : chr [1:8012] "2012-02-17 13:19:04" "2013-05-28 14:28:31" ...
  ..$ id           : chr [1:8012] "1" "2" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
 $ :Classes ‘data.table’ and 'data.frame':	8012 obs. of  10 variables:
  ..$ ec_num     : chr [1:8012] "1.1.1.1" "1.1.1.2" ...
  ..$ action     : chr [1:8012] "created" "created" ...
  ..$ note       : chr [1:8012] "" "" ...
  ..$ history    : chr [1:8012] "created 1961, modified 2011" "created 1961" ...
  ..$ class      : chr [1:8012] "1" "1" ...
  ..$ subclass   : chr [1:8012] "1" "1" ...
  ..$ subsubclass: chr [1:8012] "1" "1" ...
  ..$ serial     : chr [1:8012] "1" "2" ...
  ..$ status     : chr [1:8012] "0-0" "0-0" ...
  ..$ last_change: chr [1:8012] "2011-07-11 07:59:46" "2013-07-27 15:02:30" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
 $ :Classes ‘data.table’ and 'data.frame':	8012 obs. of  9 variables:
  ..$ ec_num       : chr [1:8012] "1.1.1.1" "1.1.1.2" ...
  ..$ accepted_name: chr [1:8012] "alcohol dehydrogenase" "alcohol dehydrogenase (NADP<small><sup>+</sup></small>)" ...
  ..$ reaction     : chr [1:8012] "(1) a primary alcohol + NAD<small><sup>+</sup></small> = an aldehyde + NADH + H<small><sup>+</sup></small>;;(2)"| __truncated__ "an alcohol + NADP<small><sup>+</sup></small> = an aldehyde + NADPH + H<small><sup>+</sup></small>" ...
  ..$ other_names  : chr [1:8012] "aldehyde reductase; ADH; alcohol dehydrogenase (NAD); aliphatic alcohol dehydrogenase; ethanol dehydrogenase; N"| __truncated__ "aldehyde reductase (NADPH<small><sub>2</sub></small>); NADP-alcohol dehydrogenase; NADP<small><sup>+</sup></sma"| __truncated__ ...
  ..$ sys_name     : chr [1:8012] "alcohol:NAD<small><sup>+</sup></small> oxidoreductase" "alcohol:NADP<small><sup>+</sup></small> oxidoreductase" ...
  ..$ comments     : chr [1:8012] "A zinc protein. Acts on primary or secondary alcohols or hemi-acetals with very broad specificity; however the "| __truncated__ "A zinc protein. Some members of this group oxidize only primary alcohols; others act also on secondary alcohols"| __truncated__ ...
  ..$ links        : chr [1:8012] "<a href=\"http://www.brenda-enzymes.info/enzyme.php?ecno=1.1.1.1\" target=\"new\">BRENDA</a>, <a href=\"http://"| __truncated__ "<a href=\"http://www.brenda-enzymes.info/enzyme.php?ecno=1.1.1.2\" target=\"new\">BRENDA</a>, <a href=\"http://"| __truncated__ ...
  ..$ glossary     : chr [1:8012] "" "" ...
  ..$ last_change  : chr [1:8012] "2014-09-16 10:07:35" "2014-09-16 10:07:35" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
 $ :Classes ‘data.table’ and 'data.frame':	15797 obs. of  22 variables:
  ..$ cite_key   : chr [1:15797] "robinson-dr-2000-5548" "iwahara-t-1997-439" ...
  ..$ type       : chr [1:15797] "article" "article" ...
  ..$ author     : chr [1:15797] "Robinson, D.R., Wu, Y.M. and Lin, S.F." "Iwahara, T., Fujimoto, J., Wen, D., Cupples, R., Bucay, N., Arakawa, T., Mori, S., Ratzkin, B. and Yamamoto, T." ...
  ..$ title      : chr [1:15797] "The protein tyrosine kinase family of the human genome" "Molecular characterization of ALK, a receptor tyrosine kinase expressed specifically in the nervous system" ...
  ..$ journal    : chr [1:15797] "Oncogene" "Oncogene" ...
  ..$ volume     : chr [1:15797] "19" "14" ...
  ..$ year       : chr [1:15797] "2000" "1997" ...
  ..$ first_page : chr [1:15797] "5548" "439" ...
  ..$ last_page  : chr [1:15797] "5557" "449" ...
  ..$ pubmed_id  : chr [1:15797] "11114734" "9053841" ...
  ..$ language   : chr [1:15797] "" "" ...
  ..$ booktitle  : chr [1:15797] "" "" ...
  ..$ editor     : chr [1:15797] "" "" ...
  ..$ edition    : chr [1:15797] "" "" ...
  ..$ publisher  : chr [1:15797] "" "" ...
  ..$ address    : chr [1:15797] "" "" ...
  ..$ erratum    : chr [1:15797] "" "" ...
  ..$ entry_title: chr [1:15797] "The protein tyrosine kinase family of the human genome" "Molecular characterization of ALK, a receptor tyrosine kinase expressed specifically in the nervous system" ...
  ..$ patent_yr  : chr [1:15797] "0" "0" ...
  ..$ link       : chr [1:15797] "" "" ...
  ..$ doi        : chr [1:15797] "10.1038/sj.onc.1203957" "10.1038/sj.onc.1200849" ...
  ..$ last_change: chr [1:15797] "2018-06-19 14:22:59" "2018-06-19 14:33:15" ...
  ..- attr(*, ".internal.selfref")=<externalptr> 
  
 ```

References

[1] McDonald, A.G., Boyce, S. and Tipton, K.F. ExplorEnz: the primary source of the IUBMB enzyme list. Nucleic Acids Res. 37, D593–D597 (2009). [DOI: 10.1093/nar/gkn582]

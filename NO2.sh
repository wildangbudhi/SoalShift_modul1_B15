# #!/bin/bash

country=$( 
  awk -F',' '
    {
      if(NR>1 && $7==2012) { penjualan[$1]=penjualan[$1]+$10 }
    }
    END{
      n=asorti(penjualan,country)
      print "Negara dengan penjualan(quantity) terbanyak pada tahun 2012 :" > "HasilSoalA.txt"
      print "- Negara : " country[n] > "HasilSoalA.txt"
      print "- Penjualan : " penjualan[country[n]] > "HasilSoalA.txt"
      print country[n]
    }
  ' OFS=',' WA_Sales_Products_2012-14.csv 
) 

readarray -t produkLine < <(
  awk -F',' '
    {
      if(NR>1 && $1==negara && $7==2012) { produkLine[$4]=produkLine[$4]+$10 }
    }
    END{
      n=asorti(produkLine, namaProdukLine)
      print "Tiga product line yang memberikan penjualan(quantity) terbanyak pada negara " negara " : " > "HasilSoalB.txt"
      for (i=0; i<3; i++){
        print "- " namaProdukLine[n-i] "(" produkLine[namaProdukLine[n-i]] ")" > "HasilSoalB.txt"
        print namaProdukLine[n-i]
      }
    }
  ' OFS=',' negara="${country}"  WA_Sales_Products_2012-14.csv
)

for i in 0 1 2
do
  awk -F',' '
    {
        if(NR>1 && $4==produkLine && $1==negara && $7==2012) { produk[$5]=produk[$5]+$10 }
    }
    END{
      n=asorti(produk, namaProduk)
      print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line " produkLine " : " >> "HasilSoalC.txt"
      for (i=0; i<3; i++){
        print "- " namaProduk[n-i] "(" produk[namaProduk[n-i]] ")" >> "HasilSoalC.txt"
      }
    }
  ' OFS=',' produkLine="${produkLine[$i]}" negara="${country}"  WA_Sales_Products_2012-14.csv
done
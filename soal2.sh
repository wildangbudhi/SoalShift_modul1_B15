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

readarray -t produkLine < <(awk -F, '
  {
    if($7 == '2012' && $1==negara) iter[$4]+=$10
  } 
  END{
    for(hasil in iter) {
      print iter[hasil], hasil
    }
  }
' negara="${country}" WA_Sales_Products_2012-14.csv OFS=',' | sort -nr | head -n3 | awk -F, '
  BEGIN{
    print "Tiga product line yang memberikan penjualan(quantity) terbanyak pada negara " negara " : " > "HasilSoalB.txt"
  }
  {
    print "- " $2 > "HasilSoalB.txt"
    print $2
  }')

awk -F, '
  {
    if(($7 == '2012' && $1=="United States")  && ($4==produkLine1 || $4==produkLine2 || $4==produkLine3)) iter[$6]+=$10
  } 
  END{
    for(hasil in iter) {print iter[hasil], hasil
    }
  }' produkLine1="${produkLine[0]}" produkLine2="${produkLine[1]}" produkLine3="${produkLine[2]}" WA_Sales_Products_2012-14.csv OFS=',' | sort -nr | head -n3 | awk -F, '
  BEGIN{
    print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line :" > "HasilSoalC.txt"
  }
  {
    print "- " $2 >> "HasilSoalC.txt"
  }' 

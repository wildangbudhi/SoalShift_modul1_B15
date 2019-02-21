# Laporan Soal Shift Modul 1

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

    Hint: Base64, Hexdump

    ### JAWAB : [soal1.sh](/soal1.sh)
    
    ### PENJELASAN :
    <br> **Script untuk Decrypt :**
    - Extract file "nature.zip" :
      ```sh
      unzip nature.zip -d "./"
      ```
    - Ambil semua nama file dari hasi Ekstraksi zip dalam directory /nature dan letakkan pada variable :
      ```sh
      data=`ls nature`
      ```
    - decode semua file menggunakan base64 dan hexdump reverse semua file :
      ```sh
      for name in ${data[@]}
        do
            echo "Decode :  $name"
            base64 --decode "./nature/$name" | xxd -r > "./hasil/$i.jpeg"
            i=$(($i+1))
        done
      ```
    **Crontab :** 
    ```sh
    14 14 *  2  5   /bin/bash /home/wildangbudhi/soal1.sh
    14 14 14 2  *   /bin/bash /home/wildangbudhi/soal1.sh
    ```
    <br>
2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda dimintauntuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:

    a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
    
    b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
    
    c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

    ### JAWAB : [soal2.sh](/soal2.sh)
    a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
    ```
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
    ```
    **PENJELSAN :**
	- Masukkan hasil output AWK kedalam bash Variable
		```sh
		country=$(--------AWK CODE--------)
		```
    - Pilih data yang bukan merupaka Header dari data dan memiliki Atribute Tahun dengan nilai 2012 lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if(NR>1 && $7==2012) { penjualan[$1]=penjualan[$1]+$10 }
		```
	- Urutkan (sort) Dictionary descending dengan meletakkan key (berisi nama negara) yang pada array 'country' dan mereturnkan jumlah data Dictionary di masukkan ke dalam variabel n. 
		```sh
		n=asorti(penjualan,country)
		```
	- Cetak pada file untuk hasil
		```sh
		print "Negara dengan penjualan(quantity) terbanyak pada tahun 2012 :" > "HasilSoalA.txt"
		print "- Negara : " country[n] > "HasilSoalA.txt"
		print "- Penjualan : " penjualan[country[n]] > "HasilSoalA.txt"
	    ```
	- Print untuk output yang nantinya digunakan untuk variable bash
		```sh
		print country[n]
		```
    b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
    ```
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
    ```
    **PENJELSAN :**
	- Masukkan hasil output AWK kedalam bash Variable array dengan membedakan element arraynya dari '\n'
		```sh
		readarray -t produkLine < <(--------AWK CODE--------)
		```
   	- Pilih data yang bukan merupaka Header dari data, memiliki Atribute Tahun dengan nilai 2012 dan memiliki Atribute Negara bernilai sama dengan Variable negara. Lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if(NR>1 && $1==negara && $7==2012) { produkLine[$4]=produkLine[$4]+$10 }
		```
	- Urutkan (sort) Dictionary descending dengan meletakkan key (berisi nama ProdukLine) yang pada array 'produkLine' dan mereturnkan jumlah data Dictionary di masukkan ke dalam variabel n.
		```sh
		 n=asorti(penjualan,country)
		```

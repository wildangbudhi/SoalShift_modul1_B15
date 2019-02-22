# Laporan Soal Shift Modul 1

 Daftar Isi

1. [NO1](#NO1)
2. [NO2](#NO2)
3. [NO3](#NO3)
4. [NO4](#NO4)
5. [NO5](#NO5)

<br>

## NO1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

Hint: Base64, Hexdump

### JAWAB : [soal1.sh](/soal1.sh)
### PENJELASAN :
**Script untuk Decrypt :**
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

## NO2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda dimintauntuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa: <br>
a.Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.	<br>
b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.<br>
c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

### JAWAB : [soal2.sh](/soal2.sh)
- (A) Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012
	```sh
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
	**PENJELASAN :**
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
- (B) Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
    ```sh
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
    **PENJELASAN :**
	- Masukkan hasil output AWK kedalam bash Variable array dengan membedakan element arraynya dari '\n'
		```sh
		readarray -t produkLine < <(--------AWK CODE--------)
		```
   	- Pilih data yang bukan merupaka Header dari data, memiliki Atribute Tahun dengan nilai 2012 dan memiliki Atribute Negara bernilai sama dengan Variable negara. Lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if(NR>1 && $1==negara && $7==2012) { produkLine[$4]=produkLine[$4]+$10 }
		```
	- Urutkan (sort) Dictionary descending dengan meletakkan key (berisi nama ProdukLine) yang pada array 'namaProdukLine' dan mereturnkan jumlah data Dictionary di masukkan ke dalam variabel n.
		```sh
		n=asorti(produkLine, namaProdukLine)
		```
	- Cetak pada file untuk hasil
		```sh
		 print "- " namaProdukLine[n-i] "(" produkLine[namaProdukLine[n-i]] ")" > "HasilSoalB.txt"
		```
	- Print untuk output yang nantinya digunakan untuk variable array bash
		```sh
		print namaProdukLine[n-i]
		```
	- Passing variabel bash ke dalam AWK
		```sh
		negara="${country}"
		```
- (C) Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
    ```sh
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
    ```
    **PENJELASAN :**
	- Loop dari 0 sampai 2 untuk mengakses array hasil dari soal b
		```sh
		for i in 0 1 2
		do
		  ------ code ------
		done
		```
	- Pilih data yang bukan merupaka Header dari data, memiliki Atribute Tahun dengan nilai 2012, memiliki Atribute Negara bernilai sama dengan Variable negara dan memiliki Atribute ProdukLine sama dengan variabel produkLine. Lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if(NR>1 && $4==produkLine && $1==negara && $7==2012) { produk[$5]=produk[$5]+$10 }
		```
	- Urutkan (sort) Dictionary descending dengan meletakkan key (berisi nama Produk) yang pada array 'namaProduk' dan mereturnkan jumlah data Dictionary di masukkan ke dalam variabel n.
		```sh
		n=asorti(produk, namaProduk)
		```
	- Cetak pada file untuk hasil
		```sh
		print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line " produkLine " : " >> "HasilSoalC.txt"
		for (i=0; i<3; i++){
			print "- " namaProduk[n-i] "(" produk[namaProduk[n-i]] ")" >> "HasilSoalC.txt"
		}
		```
   	- Passing variabel bash ke dalam AWK
		```sh
		produkLine="${produkLine[$i]}" negara="${country}"
		```

<br>

## NO3
Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut
disimpan pada file bernama password1.txt
<br />
b. Jika file password1.txt sudah ada maka password acak baru akan
disimpan pada file bernama password2.txt dan begitu seterusnya.
<br />
c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya
dihapus.
<br />
d. Password yang dihasilkan tidak boleh sama.

### JAWAB: [soal3.sh](/soal3.sh)
### PENJELASAN:
Ada beberapa tahap yang harus kita lakukan, diantara lain adalah:
<br />
1. Menginisialisasi variabel <br />
```sh
number=1
suffix=1
```
``number=1`` berfungsi sebagai temporary untuk memeriksa file yang nantinya ada.<br />
``suffix=1`` berfungsi agar file nantinya dimulai dengan nama "password1.txt"
<br /> <br />
2. Kemudian, melakukan looping menggunakan ``while`` ketika ``test -e "password$suffix"`` , untuk pemeriksaan keberadaan file itu apakah ada atau tidak, apabila file tersebut ada, maka akan terjadi looping yang menambahkan +1 ke dalam ``suffix`` hingga ke file yang belum ada.<br />
```sh
while test -e "password$suffix.txt"
    do
        ((++number))
        suffix="$number" 
    done
 ```
3. Kemudian, membuat nama file.
```sh
fname="password$suffix.txt"
```
Kode di atas berfungsi untuk menamai file yang belum ada. <br /> <br />
4. Menggunakan random string.
```sh
randomnum=$(</dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
```
Kita dapat menggunakan random string A-Z, a-z, dan 1-9 memakai ``/dev/urandom`` dengan ``tr``, lalu ambil bagian depan saja menggunakan ``head -c12``.<br /> <br />
5. Mencetak password.
```sh
echo "$randomnum" > "$fname"
```
Terakhir, kita mencetak password acak  ke dalam sebuah file teks.

## NO4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
urutan ke 12+2 = 14.
<br />
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.
<br />
c. setelah huruf z akan kembali ke huruf a
<br />
d. Backup file syslog setiap jam.
<br />
e. dan buatkan juga bash script untuk dekripsinya.

### JAWAB: [soal4_encrypt.sh](/soal4_encrypt.sh) | [soal4_decrypt.sh](./soal4_decrypt.sh)
**Script Encrypt:**
```sh
hour=`date +"%H"`
filename=`date +"%H:%M %d-%m-%Y"`

lowercase="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

cat /var/log/syslog | tr "${lowercase:0:26}${uppercase:0:26}" "${lowercase:$hour:26}${uppercase:$hour:26}" > "/home/hp/sisop1/soal4_encrypt/$filename"


```
**Script Decrypt:**
```sh
echo "Enter the file: "
read times
hour=${times:0:2}

lowercase="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
awk '{print}' "/home/hp/sisop19/nomor4_enkripsi/$times" | tr "${lowercase:$hour:26}${uppercase:$hour:26}" "${lowercase:0:26}${uppercase:0:26}" | awk '{print}' > "/home/hp/sisop1/soal4_decrypt/$times"

```
**crobtab -e:**
<br />
``
@hourly /bin/bash /home/hp/sisop1/soal4_encrypt.sh
``
### PENJELASAN:
1. ``sh
hour=`date +"%H"`
``<br /> 
Sintaks ini berfungsi supaya karakter tertentu dapat diterjemahkan dengan urutan (tanggal file terbuat) + (urutan alfabet)
2. ``sh
tr "${lowercase:0:26}${uppercase:0:26}" "${lowercase:$hour:26}${uppercase:$hour:26}"
`` <br />
Sintaks 'tr' ditulis seperti di atas ini karena ketika setiap huruf sudah diterjemahkan, urutan alfabet pun ikut tergeser.
3. ``
lowercase="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
``
``
uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"
`` <br />
Urutan alfabel ditulis sebanyak 2 kali supaya alfabet melakukan translate dan bergeser dengan tepat. Kemungkinan terburuk yang bisa terjadi adalah ketika file terbut pada pukul 23. Sehingga tentu huruf z akan menjadi urutan ke 23 + 26 = 49. Hal ini akan teratasi karena jumlah alfabet yang dituliskan 2 kali menghasilkan 52 karakter yang dimana menanggung urutan huruf z yang menjadi ke 49.
<br />
4. Untuk melakukan back up file syslog setiap jam, dituliskan pada pengaturan crontab sebagai berikut: 
``
@hourly /bin/bash /home/hp/sisop1/soal4_encrypt.sh
``

## NO5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.<br>
b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.<br>
c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1. <br>
d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst. <br>

### JAWAB : [soal5.sh](/soal5.sh)
### PENJELASAN :
**Script :**
- Filter Data yang tidak mengandung string "Sudo", tetapi mengandung "cron"
	```sh
	(!(/[sS][uU][dD][oO]/) && (/[cC][rR][oO][nN]/) && (NF<13))
	```
- Output pada file direktori /home/[user]/modul1
	```sh
	> /home/wildangbudhi/modul1
	```

**Crontab :** 
```sh
2-30/6 * * * *   /bin/bash /home/wildangbudhi/soal5.sh
```

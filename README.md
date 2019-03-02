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
    ```
    **PENJELASAN :**
	- Masukkan hasil output AWK kedalam bash Variable array dengan membedakan element arraynya dari '\n'
		```sh
		readarray -t produkLine < <(--------AWK CODE--------)
		```
   	- Pilih data yang bukan merupaka Header dari data, memiliki Atribute Tahun dengan nilai 2012 dan memiliki Atribute Negara bernilai sama dengan Variable negara. Lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if($7 == '2012' && $1==negara) iter[$4]+=$10
		```
	- Print semua hasil iter
		```sh
		for(hasil in iter) {
		  print iter[hasil], hasil
		}
		```
	- Urutkan data dan ambil 3 data teratas lali pipe output kedalah awk lain untuk mengcetak semua nya
		```sh
		| sort -nr | head -n3 | awk -F, '
		  BEGIN{
			print "Tiga product line yang memberikan penjualan(quantity) terbanyak pada negara " negara " : " > "HasilSoalB.txt"
		  }
		  {
			print "- " $2 > "HasilSoalB.txt"
			print $2
		  }')
		```
	- Passing variabel bash ke dalam AWK
		```sh
		negara="${country}"
		```
- (C) Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
    ```sh
    awk -F, '
	  {
		if(($7 == '2012' && $1=="United States")  && ($4==produkLine1 || $4==produkLine2 || $4==produkLine3)) iter[$6]+=$10
	  } 
	  END{
		for(hasil in iter) {
			print iter[hasil], hasil
		}
	  }' produkLine1="${produkLine[0]}" produkLine2="${produkLine[1]}" produkLine3="${produkLine[2]}" WA_Sales_Products_2012-14.csv OFS=',' | sort -nr | head -n3 | awk -F, '
	  BEGIN{
		print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line :" > "HasilSoalC.txt"
	  }
	  {
		print "- " $2 >> "HasilSoalC.txt"
	  }' 
    ```
    **PENJELASAN :**
	- Pilih data yang bukan merupaka Header dari data, memiliki Atribute Tahun dengan nilai 2012, memiliki Atribute Negara bernilai sama dengan Variable negara dan memiliki Atribute ProdukLine sama dengan variabel produkLine1 atau produkLine2 atau produkLine3. Lalu lakukan penjumlahan setiap penjualan dengan metode Counting Array namun menggunakan Dictionary dikarenakan key tidak Integer seperti index Array
		```sh
		if(($7 == '2012' && $1=="United States")  && ($4==produkLine1 || $4==produkLine2 || $4==produkLine3)) iter[$6]+=$10
		```
	- Print semua hasil iter
		```sh
		for(hasil in iter) {
		  print iter[hasil], hasil
		}
		```
	- Cetak pada file untuk hasil
		```sh
		print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line " produkLine " : " >> "HasilSoalC.txt"
		for (i=0; i<3; i++){
			print "- " namaProduk[n-i] "(" produk[namaProduk[n-i]] ")" >> "HasilSoalC.txt"
		}
		```
   	- Urutkan data dan ambil 3 data teratas lali pipe output kedalah awk lain untuk mengcetak semua nya
		```sh
		| sort -nr | head -n3 | awk -F, '
		  BEGIN{
			print "Tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada Produk Line :" > "HasilSoalC.txt"
		  }
		  {
			print "- " $2 >> "HasilSoalC.txt"
		  }' 
		```
	- Passing variabel bash ke dalam AWK
		```sh
		negara="${country}" produkLine1="${produkLine[0]}" produkLine2="${produkLine[1]}" produkLine3="${produkLine[2]}"
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
Terakhir, kita mencetak password acak tersebut ke dalam sebuah file teks.

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
### Script Encrypt:
```sh
#!/bin/bash

lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

hour=`date "+%H"`

filename=`date "+%H:%M %d-%m-%Y"`

lower=${lowerCase[${hour:1:2}]}
upper=${upperCase[${hour:1:2}]}

cat /var/log/syslog | tr '[a-z]' "[$lower-za-$lower]" | tr '[A-Z]' "[$upper-ZA-$upper]" >> encrypted/"$filename".txt
```
**PENJELASAN:**
- Pertama kami membuat 2 array berisi semua huruf kecil dan huruf bersar
	```sh
	lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
	upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
	```
- Lalu kami mengambil jam untuk proses encrypsi dan dimasukkan kedalam variable hour
	```sh
	hour=`date "+%H"`
	```
- Lalu kami mengambil tanggal dengan format HH:MM dd-mm-yyyy yang nantinya akan digunakan sebagai nama file 
	```sh
	filename=`date "+%H:%M %d-%m-%Y"`
	```
- Lalu kami simpan hurud denga index berdasarkan jam
	```sh
	lower=${lowerCase[${hour:1:2}]}
	upper=${upperCase[${hour:1:2}]}
	```
- Untuk menampilkan isi syslog yang kemudian akan men-”shift” setiap huruf kecil dan kapital ke kanan sebanyak $hour. Namun jika sampai Z akan kembali lagi ke A menggunakan dan diletakkan ke dalam file bernamakan dari variable ```filename``` yang berada didalam folder encrypted
	```sh
	cat /var/log/syslog | tr '[a-z]' "[$lower-za-$lower]" | tr '[A-Z]' "[$upper-ZA-$upper]" >> encrypted/"$filename".txt
	```


### Script Decrypt:
```sh
#!/bin/bash

lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)


for file in encrypted/*.txt
do
    hour=${file:10:2}
    hour=${hour:1:2}
    let reverse=$hour*-1
    filename=${file:10:16}
    lower=${lowerCase[$reverse]}
    upper=${upperCase[$reverse]}

    cat "$file" | tr '[a-z]' "[$lower-za-$lower]" | tr '[A-Z]' "[$upper-ZA-$upper]" >> decrypted/"$filename".txt
done
```

**PENJELASAN:**
- Pertama kami membuat 2 array berisi semua huruf kecil dan huruf bersar
	```sh
	lowerCase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
	upperCase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
	```
- Lalu kita lakukan iterasi setiap file yang ada di dalam folder ```encrypted``` dan memiliki extensi ```.txt```
	```sh
	for file in encrypted/*.txt
	do
		------ code ------
	done
	```
- Lalu kita mengambil jam dari namafile tersebut namum mebuatnya menjadi negatif dikarenakan untuk mengembalikan charakter menjadi asal
	```sh
	hour=${file:10:2}
    hour=${hour:1:2}
	let reverse=$hour*-1
	```
- Selanjutnya untuk nama file yang akan tersimpan sebagai hasil decrypt akan memiliki nama yang sama
	```sh
	filename=${file:10:16}
	```
- Lalu kami simpan hurud denga index berdasarkan jam
	```sh
	lower=${lowerCase[$reverse]}
    upper=${upperCase[$reverse]}
	```
- Untuk menampilkan isi dari file tersebut kemudian men-shift ke kanan setiap huruf kecil dan kapital sebanyak indeks $reverse sehingga isi file tersebut kembali seperti semula dan di letakkan kedalam file bernamakan dari variable ```filename``` yang berada didalam folder decrypted
	```sh
	cat "$file" | tr '[a-z]' "[$lower-za-$lower]" | tr '[A-Z]' "[$upper-ZA-$upper]" >> decrypted/"$filename".txt
	```

### crobtab -e:
<br />
``
0 * * * * /bin/bash /home/hp/sisop1/soal4_encrypt.sh
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

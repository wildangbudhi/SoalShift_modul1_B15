# Laporan Soal Shift Modul 1

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

    Hint: Base64, Hexdump

    ### JAWAB : [NO1.sh](/NO1.sh)
    
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
    <br> **Crontab :** 
    ```sh
    14 14 *  2  5   /bin/bash /home/wildangbudhi/NO1.sh
    14 14 14 2  *   /bin/bash /home/wildangbudhi/NO1.sh
    ```

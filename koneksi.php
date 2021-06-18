<?php
// konfigurasi utk koneksi ke database
$connect = mysqli_connect("localhost", "root", "", "berita");
//
if($connect === false){
die("ERROR: Database tidak terkoneksi " . mysqli_connect_error());
// Close connection
mysqli_close($connect);
}

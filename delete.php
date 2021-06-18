<?php
include 'koneksi.php';
$idl = $_GET['id'];
$Sql = "CALL hapusKategori('$idl')";
if (mysqli_query($connect, $Sql)) {
    header("location:index.php");
}

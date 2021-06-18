<?php
// koneksi ke database
include 'koneksi.php';
if (isset($_POST["btn_up"])) {
    $idlama = $_POST['idlm'];
    $idk    = $_POST['idkat'];
    $nmk    = $_POST['nmkat'];
    $ubah   = "CALL ubahKategori('$idlama','$idk','$nmk')";
    if (mysqli_query($connect, $ubah)) {
        header("location:index.php?update_sukses");
    } else {
        header("location:index.php?update_gagal");
    }
}
$idl = $_GET['id'];
?>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <title>Membuat Stored Procedure Di PHP MySQL</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .box {
            width: 500px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>

<body>
    <div class="container box my-5">
        <form action="" name="upt_kat" method="post">
            <h3 class="text-center">Ubah Kategori</h3>
            <?php
            $selectSql = "CALL tampilKategori2($idl)";
            $selectResult = mysqli_query($connect, $selectSql);
            $row = mysqli_fetch_array($selectResult);
            ?>
            <div class="form-group">
                <input type="hidden" name="idlm" class="form-control" value="<?php echo $row["id"]; ?>">
                Id kategori :
                <input type="text" name="idkat" class="form-control" value="<?php echo $row["id_kategori"]; ?>">
                </br>
                Nama kategori :
                <input type="text" name="nmkat" class="form-control" value="<?php echo $row["nm_kategori"]; ?>">
            </div>
            <div class="form-group text-center">
                <input type="submit" class="form-control bg-info text-white font-weight-bold" name="btn_up" value="Ubah Data">
            </div>
        </form>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

</html>
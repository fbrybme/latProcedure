<?php
// koneksi ke database
include 'koneksi.php';
// untuk proses insert
if (isset($_POST["btn_add"])) {
    $idk = $_POST['idkat'];
    $nmk = $_POST['nmkat'];
    $inputSql = "CALL inputKategori('$idk','$nmk')";
    if (mysqli_query($connect, $inputSql)) {
        header("location:index.php");
    }
}
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
        <form action="" name="add_kat" method="post">
            <h3 class="text-center">Tabel Kategori</h3>
            <div class="form-group">
                Id kategori :
                <input type="text" name="idkat" class="form-control"> </br>
                Nama kategori :
                <input type="text" name="nmkat" class="form-control">
            </div>
            <div class="form-group text-center">
                <input type="submit" class="form-control bg-info text-white font-weight-bold" name="btn_add" value="Add Data">
            </div>
        </form>
        <div class="table-responsive">
            <table class="table table-striped">
                <tr>
                    <th>Id Kategori</th>
                    <th>Nama Kategori</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <?php
                $selectSql = "CALL tampilKategori()";
                //sebelumnya silahkan buat procedurnya dulu seperti tampil berita
                $selectResult = mysqli_query($connect, $selectSql);
                if (mysqli_num_rows($selectResult) > 0) {
                    while ($row = mysqli_fetch_array($selectResult)) {
                ?>
                        <tr>
                            <td><?php echo $row["id_kategori"]; ?></td>
                            <td><?php echo $row["nm_kategori"]; ?></td>
                            <td><a href="update.php?id=<?php echo $row["id"]; ?>" class="btn btn-warning">Edit</a></td>
                            <td><a href="delete.php?id=<?php echo $row["id"]; ?>" class="btn btn-danger" onclick="return confirm('Yakin hapus data <?php echo $row["id_kategori"]; ?> ?')">Delete</a></td>
                        </tr>
                    <?php
                    }
                } else {
                    ?>
                    <tr>
                        <td colspan="3">No Data</td>
                    </tr>
                <?php
                }
                ?>
            </table>
        </div>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

</html>
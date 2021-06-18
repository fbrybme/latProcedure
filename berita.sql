-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 18 Jun 2021 pada 09.15
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `berita`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusKategori` (IN `idlama` INT(4))  BEGIN
	DELETE FROM kategori WHERE id=idlama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inputKategori` (IN `idkat` CHAR(10), IN `nmkat` VARCHAR(200))  BEGIN
	INSERT INTO kategori VALUES (NULL, idkat, nmkat);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pilihBerita` ()  BEGIN
	SELECT * FROM berita;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilKategori` ()  BEGIN
	SELECT * FROM kategori;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilKategori2` (IN `idl` INT(4))  BEGIN
	SELECT * FROM kategori WHERE id=idl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ubahKategori` (IN `idlama` INT(4), IN `idkat` CHAR(10), IN `nmkat` VARCHAR(200))  MODIFIES SQL DATA
    DETERMINISTIC
BEGIN
UPDATE kategori SET id_kategori=idkat,nm_kategori=nmkat
	WHERE id=idlama;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `berita`
--

CREATE TABLE `berita` (
  `id` int(4) NOT NULL,
  `id_berita` char(10) NOT NULL,
  `id_kategori` char(10) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi_berita` text NOT NULL,
  `tanggal` date NOT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `berita`
--

INSERT INTO `berita` (`id`, `id_berita`, `id_kategori`, `judul`, `isi_berita`, `tanggal`, `gambar`) VALUES
(4, 'IT01', 'FS01', 'Vamos Mataram FC gelar liga juara', 'Vamos menjuarai liga pro futsal dalam 3 kali berturut-turut', '2021-03-16', '');

--
-- Trigger `berita`
--
DELIMITER $$
CREATE TRIGGER `del_berita` AFTER DELETE ON `berita` FOR EACH ROW insert into log_del_berita 
values(now(),OLD.id_berita,'Hapus berita')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `edit_berita` AFTER UPDATE ON `berita` FOR EACH ROW insert into log_edit_berita 
values(now(),NEW.id_berita,NEW.judul,'Ubah berita')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `inp_berita` AFTER INSERT ON `berita` FOR EACH ROW insert into log_input_berita 
values(now(),NEW.id_berita,NEW.judul,'Tambah berita')
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(4) NOT NULL,
  `id_kategori` char(10) NOT NULL,
  `nm_kategori` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `id_kategori`, `nm_kategori`) VALUES
(1, 'BK01', 'Basketball'),
(3, 'BT01', 'Bulutangkis'),
(9, 'BV01', 'Bolavoli'),
(10, 'FS01', 'Futsal Player'),
(6, 'IT01', 'Sistem Operasi'),
(7, 'IT02', 'Pemrograman'),
(8, 'IT03', 'Jaringan Komputer'),
(5, 'RN01', 'Berenang'),
(4, 'SP01', 'Sepakbola');

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `id` int(2) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`id`, `username`, `password`) VALUES
(1, 'admin', '827ccb0eea8a706c4c34a16891f84e7b');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_del_berita`
--

CREATE TABLE `log_del_berita` (
  `waktu` datetime NOT NULL,
  `id_berita` char(10) NOT NULL,
  `keterangan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_del_berita`
--

INSERT INTO `log_del_berita` (`waktu`, `id_berita`, `keterangan`) VALUES
('2020-11-19 11:44:27', 'OL01', 'Hapus berita');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_edit_berita`
--

CREATE TABLE `log_edit_berita` (
  `waktu` datetime NOT NULL,
  `id_berita` char(10) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `keterangan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_edit_berita`
--

INSERT INTO `log_edit_berita` (`waktu`, `id_berita`, `judul`, `keterangan`) VALUES
('2020-11-19 11:36:49', 'TI01', 'Berakhir sistem operasi Windows 7', 'Ubah berita'),
('2020-12-15 13:39:48', 'IT01', 'Berakhir sistem operasi Windows 7', 'Ubah berita'),
('2020-12-15 13:43:18', 'IT01', 'Berakhir sistem operasi Windows 7', 'Ubah berita');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_input_berita`
--

CREATE TABLE `log_input_berita` (
  `waktu` datetime NOT NULL,
  `id_berita` char(10) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `keterangan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_input_berita`
--

INSERT INTO `log_input_berita` (`waktu`, `id_berita`, `judul`, `keterangan`) VALUES
('2020-11-19 11:29:20', 'OL01', 'Chelsea juara bersama hazard', 'Tambah berita'),
('2020-12-15 13:42:54', 'SP01', 'Persija Jakarta meraih gelar juara Liga 1 2018 berkat adanya pelatih Teco yang berasal dari Brazil', 'Tambah berita'),
('2021-03-16 12:59:40', 'IT01', 'Vamos Mataram FC gelar liga juara', 'Tambah berita');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `berita`
--
ALTER TABLE `berita`
  ADD PRIMARY KEY (`id_berita`,`id_kategori`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeks untuk tabel `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `berita`
--
ALTER TABLE `berita`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `login`
--
ALTER TABLE `login`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `berita`
--
ALTER TABLE `berita`
  ADD CONSTRAINT `berita_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

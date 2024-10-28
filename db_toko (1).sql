-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Okt 2024 pada 12.15
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_toko`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_barang`
--

CREATE TABLE `tb_barang` (
  `id` int(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `merk` varchar(255) NOT NULL,
  `stok` int(255) NOT NULL,
  `harga` int(255) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `exp` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_barang`
--

INSERT INTO `tb_barang` (`id`, `nama`, `merk`, `stok`, `harga`, `tgl_masuk`, `exp`) VALUES
(1, 'Buku Campus', 'BM Campus', 0, 5000, '2024-08-01', '2026-10-31'),
(2, 'Pensil 2B', 'Joyko', 57, 3000, '2024-07-03', '2027-10-29'),
(3, 'Apel', 'Iphone', 26, 9000000, '2024-10-01', '2024-11-30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_faktur`
--

CREATE TABLE `tb_faktur` (
  `id_faktur` varchar(255) NOT NULL,
  `id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_faktur`
--

INSERT INTO `tb_faktur` (`id_faktur`, `id`) VALUES
('F20241012-001', 1),
('F20241012-002', 2),
('F20241012-003', 3),
('F20241012-004', 4),
('F20241012-005', 5),
('F20241013-001', 6);

--
-- Trigger `tb_faktur`
--
DELIMITER $$
CREATE TRIGGER `set_status_barang` AFTER INSERT ON `tb_faktur` FOR EACH ROW BEGIN
    UPDATE tb_sales
    SET status_pembayaran = 'dibayar'
    WHERE kode_faktur = NEW.id_faktur;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_sales`
--

CREATE TABLE `tb_sales` (
  `id_sales` int(11) NOT NULL,
  `kode_faktur` varchar(255) NOT NULL,
  `id_barang` int(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga_barang` int(255) NOT NULL,
  `jumlah` int(255) NOT NULL,
  `total` int(255) NOT NULL,
  `status_pembayaran` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_sales`
--

INSERT INTO `tb_sales` (`id_sales`, `kode_faktur`, `id_barang`, `nama_barang`, `harga_barang`, `jumlah`, `total`, `status_pembayaran`) VALUES
(12, 'F20241012-001', 1, 'Buku Campus', 5000, 4, 20000, 'dibayar'),
(13, 'F20241012-001', 2, 'Pensil 2B', 3000, 2, 6000, 'dibayar'),
(14, 'F20241012-002', 3, 'Apel', 9000000, 1, 9000000, 'dibayar'),
(15, 'F20241012-003', 3, 'Apel', 9000000, 2, 18000000, 'dibayar'),
(16, 'F20241012-004', 1, 'Buku Campus', 5000, 14, 70000, 'dibayar'),
(17, 'F20241012-004', 2, 'Pensil 2B', 3000, 34, 102000, 'dibayar'),
(18, 'F20241012-004', 1, 'Buku Campus', 5000, 1, 5000, 'dibayar'),
(19, 'F20241012-004', 3, 'Apel', 9000000, 1, 9000000, 'dibayar'),
(21, 'F20241012-005', 2, 'Pensil 2B', 3000, 31, 93000, 'dibayar'),
(22, 'F20241012-005', 1, 'Buku Campus', 5000, 2, 10000, 'dibayar'),
(26, 'F20241013-001', 2, 'Pensil 2B', 3000, 1, 3000, 'dibayar'),
(27, 'F20241013-001', 1, 'Buku Campus', 5000, 2, 10000, 'dibayar'),
(28, 'F20241013-001', 3, 'Apel', 9000000, 1, 9000000, 'dibayar'),
(31, 'F20241013-002', 2, 'Pensil 2B', 3000, 2, 6000, 'belum dibayar'),
(32, 'F20241013-002', 3, 'Apel', 9000000, 1, 9000000, 'belum dibayar');

--
-- Trigger `tb_sales`
--
DELIMITER $$
CREATE TRIGGER `kurangi stok` AFTER INSERT ON `tb_sales` FOR EACH ROW BEGIN
    UPDATE tb_barang
    SET stok = stok - NEW.jumlah
    WHERE id = NEW.id_barang;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_barang`
--
ALTER TABLE `tb_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_faktur`
--
ALTER TABLE `tb_faktur`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_sales`
--
ALTER TABLE `tb_sales`
  ADD PRIMARY KEY (`id_sales`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_faktur`
--
ALTER TABLE `tb_faktur`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tb_sales`
--
ALTER TABLE `tb_sales`
  MODIFY `id_sales` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

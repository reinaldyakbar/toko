-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Des 2022 pada 07.57
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toko`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id` int(11) NOT NULL,
  `nama` text NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `gambar` text NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id`, `nama`, `harga`, `stok`, `gambar`, `id_kategori`, `created_by`, `created_date`, `updated_by`, `updated_date`) VALUES
(1, 'Yellow Sweater', 50000, 54, 'product-1.jpg', 2, 1, '2022-06-26 04:49:21', NULL, NULL),
(2, 'Dusty Pink Crop Sweater', 100000, 45, 'product-2.jpg', 2, 1, '2022-06-26 04:49:50', NULL, NULL),
(3, 'Green Jacket', 90000, 32, 'product-3.jpg', 1, 1, '2022-06-26 04:50:21', NULL, NULL),
(4, 'Grey Syal', 20000, 13, 'product-4.jpg', 3, 1, '2022-06-26 04:50:21', NULL, NULL),
(5, 'Yellow Bag', 200000, 1, 'product-7.jpg', 3, 1, '2022-06-26 04:59:21', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `diskon`
--

CREATE TABLE `diskon` (
  `id` int(11) NOT NULL,
  `Kode_voucher` varchar(10) NOT NULL,
  `Tanggal_mulai_berlaku` date NOT NULL,
  `Tanggal_akhir_berlaku` date NOT NULL,
  `Besar_diskon` tinyint(2) NOT NULL,
  `Aktif` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `diskon`
--

INSERT INTO `diskon` (`id`, `Kode_voucher`, `Tanggal_mulai_berlaku`, `Tanggal_akhir_berlaku`, `Besar_diskon`, `Aktif`) VALUES
(1, '12345', '2022-12-20', '2022-12-31', 50, 1),
(2, '223344', '2022-12-20', '2022-12-31', 10, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `nama`, `created_by`, `created_date`, `updated_by`, `updated_date`) VALUES
(1, 'Men', 1, '2022-06-26 04:50:03', NULL, NULL),
(2, 'Women', 1, '2022-06-26 04:50:03', NULL, NULL),
(3, 'Kid', 1, '2022-06-26 04:50:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `komentar` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_by` int(11) NOT NULL,
  `update_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `komentar`
--

INSERT INTO `komentar` (`id`, `id_barang`, `id_user`, `komentar`, `created_by`, `created_date`, `updated_by`, `update_date`) VALUES
(1, 4, 4, 'packing yang rapi yaa', 4, '2022-12-25 08:01:41', 0, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `id_pembeli` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `alamat` text NOT NULL,
  `ongkir` int(11) NOT NULL,
  `status` int(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `id_barang`, `id_pembeli`, `jumlah`, `total_harga`, `alamat`, `ongkir`, `status`, `created_by`, `created_date`, `updated_by`, `updated_date`) VALUES
(1, 1, 1, 1, 80000, 'Jl. Mijen Permai 5, Mijen, Kec. Mijen, Kota Semarang, Jawa Tengah 50519', 30000, 0, 1, '2022-12-20 03:31:33', NULL, NULL),
(2, 4, 4, 1, 27500, 'Perumahan Muria Indah Rt 06 Rw 07', 35000, 0, 4, '2022-12-25 08:01:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `salt` text NOT NULL,
  `avatar` text NOT NULL,
  `role` int(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `salt`, `avatar`, `role`, `created_by`, `created_date`, `updated_by`, `updated_date`) VALUES
(1, 'wildanaldip', '6a3a6438cfe6db30cf929a4c2e7c8e6c', '63a17a0412e5d7.91235324', '', 0, 0, '2022-12-20 03:01:56', NULL, NULL),
(3, 'Reinaldy Akbar', '0182a5ffba0fd598c05226a016e386f2', '63a851ecb802e7.59806680', '', 0, 0, '2022-12-25 07:36:44', NULL, NULL),
(4, 'Reinaldy ', 'c3c9b7c3e4b7dfd02f9eea85d329dfd5', '63a8567b3d4681.82847393', '', 0, 0, '2022-12-25 07:56:11', NULL, NULL),
(5, 'Reinaldy', 'd240ba20b39c4e6c7ab9d79dd95e0646', '63a856f797a774.01266192', '', 0, 0, '2022-12-25 07:58:15', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indeks untuk tabel `diskon`
--
ALTER TABLE `diskon`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_pembeli` (`id_pembeli`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang`
--
ALTER TABLE `barang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `diskon`
--
ALTER TABLE `diskon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `komentar_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `komentar_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_pembeli`) REFERENCES `user` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

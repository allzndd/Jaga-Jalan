-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 02 Jun 2025 pada 07.05
-- Versi server: 10.6.21-MariaDB-cll-lve
-- Versi PHP: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oyiwebid_jagajalan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(255) NOT NULL,
  `tipe_pengguna` enum('admin','super admin') NOT NULL DEFAULT 'admin',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `alamat`, `telepon`, `tipe_pengguna`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@admin.com', '$2y$12$w4dVwz6Pq.vxD7kztP6xcu09T5nUN./8rf/rRwRVF0qsSu/SuyoTq', 'Alamat Admin', '08123456789', 'admin', NULL, '2025-03-22 11:27:01', '2025-03-22 11:27:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_bencana`
--

CREATE TABLE `jenis_bencana` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jenis_bencana`
--

INSERT INTO `jenis_bencana` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'Banjir', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(2, 'Longsor', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(3, 'Erupsi', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(4, 'Lahar Panas', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(5, 'Lahar Dingin', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(6, 'Gempa', '2025-03-22 11:27:01', '2025-03-22 11:27:01'),
(7, 'Angin Topan', '2025-03-22 11:27:01', '2025-03-22 11:27:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"0e313798-f470-4f34-9f31-e8bd419113fd\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266e1ce33ea\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:43:40+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.930927\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.930927\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349020, 1747349020),
(2, 'default', '{\"uuid\":\"d0d13205-5288-4c45-9bf5-f27177e2f241\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266e1ceafea\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:43:40+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.962698\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.962698\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349020, 1747349020),
(3, 'default', '{\"uuid\":\"8a9ffe8f-ac5c-4d32-8721-4504b992083e\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266e1cec8d4\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:43:40+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.969069\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:43:40.969069\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349020, 1747349020),
(4, 'default', '{\"uuid\":\"9087f729-1fe2-4ffb-a327-cf1723f20b4e\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349020, 1747349020),
(5, 'default', '{\"uuid\":\"1c42b638-1c04-486c-8e49-6715b6bb528d\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266eb47940c\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:46:12+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.496720\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.496720\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349172, 1747349172),
(6, 'default', '{\"uuid\":\"1739f1cc-2b59-4333-aabb-6e5e956dfa42\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266eb47bb3b\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:46:12+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.506749\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.506749\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349172, 1747349172),
(7, 'default', '{\"uuid\":\"08f08e96-a6a7-4a54-8422-44521053b84f\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266eb47c709\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:46:12+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.509770\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:46:12.509770\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349172, 1747349172),
(8, 'default', '{\"uuid\":\"6afad474-2a10-4058-b538-40bd8bdc1e54\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:8;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349172, 1747349172),
(9, 'default', '{\"uuid\":\"f7248f37-5e0a-4c5f-b7f9-55d6878b7b97\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266fbe4cfe4\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:50:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.315430\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.315430\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349438, 1747349438),
(10, 'default', '{\"uuid\":\"386dbfa6-3e22-40b3-b206-48375c3c5a4f\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266fbe4f7d3\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:50:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.325664\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.325664\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349438, 1747349438),
(11, 'default', '{\"uuid\":\"b64ecb73-9791-4b0d-8f85-1391b4f2fa92\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68266fbe50339\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:50:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.328566\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:50:38.328566\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349438, 1747349438),
(12, 'default', '{\"uuid\":\"37ac5e46-0e50-49df-a5a3-186ad7f1bab8\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:9;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349438, 1747349438),
(13, 'default', '{\"uuid\":\"ce447bb4-7037-4804-9cda-156abfe5098b\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682670ed1801b\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:55:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.098443\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.098443\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349741, 1747349741),
(14, 'default', '{\"uuid\":\"a4b436b1-70ad-4e77-a865-4b3b5cda80aa\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682670ed1d24a\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:55:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.119502\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.119502\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349741, 1747349741),
(15, 'default', '{\"uuid\":\"e2181776-cfca-4770-9a33-b2b69ad737e5\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682670ed1e5c9\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T22:55:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.124424\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 22:55:41.124424\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349741, 1747349741),
(16, 'default', '{\"uuid\":\"9b71e8c9-24ac-4914-abfb-8c23b1b927bd\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747349741, 1747349741),
(17, 'default', '{\"uuid\":\"be961abb-ef98-4b23-b69e-16dec8a4efff\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682672cdb7b9a\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:03:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.752601\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.752601\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350221, 1747350221),
(18, 'default', '{\"uuid\":\"771e57e0-3f63-49d2-8b68-58fe61d21222\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682672cdb8f5d\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:03:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.757660\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.757660\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350221, 1747350221),
(19, 'default', '{\"uuid\":\"384edd1e-0342-4319-912d-dac4eb64e9d7\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682672cdba772\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:03:41+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.763825\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:03:41.763825\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350221, 1747350221),
(20, 'default', '{\"uuid\":\"068094f7-e392-47b8-ba06-5aae8b00b256\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:11;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350221, 1747350221),
(21, 'default', '{\"uuid\":\"e0a86fcd-43be-4acb-aa60-0fb22eb5605d\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826736176151\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:06:09+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.483733\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.483733\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350369, 1747350369),
(22, 'default', '{\"uuid\":\"ae2df980-ed19-4483-84c1-0efc96469851\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826736177d9e\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:06:09+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.491009\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.491009\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350369, 1747350369),
(23, 'default', '{\"uuid\":\"cb60d0a4-ec2e-4d5f-b3b0-a27b6de536e3\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826736178fbf\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:06:09+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.495621\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:06:09.495621\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350369, 1747350369),
(24, 'default', '{\"uuid\":\"a29c872a-9cee-4fbd-9509-2aed157172b2\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:12;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350369, 1747350369),
(25, 'default', '{\"uuid\":\"cb704317-5f5f-4047-b588-2068400a74c6\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68267484e37de\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:11:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.931869\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.931869\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350660, 1747350660),
(26, 'default', '{\"uuid\":\"25c8a480-cd31-4e4b-a882-0e44574fc66c\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68267484e4734\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:11:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.935796\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.935796\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350660, 1747350660),
(27, 'default', '{\"uuid\":\"33437533-c9e9-4517-b5f9-945c06989d8c\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68267484e5254\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:38:\\\"Laporan baru telah dibuat: Lahar Panas\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:11:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.938641\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:11:00.938641\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350660, 1747350660),
(28, 'default', '{\"uuid\":\"fa657e78-e51b-4eba-95f6-4b735150c7e1\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:13;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350660, 1747350660),
(29, 'default', '{\"uuid\":\"1bb48593-b671-413a-acc8-10bd2f347759\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674d6f2a71\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:12:22+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:22.993991\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:22.993991\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350742, 1747350742),
(30, 'default', '{\"uuid\":\"9e3b0709-2776-4093-a633-4b71d1a608f3\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674d6f3b9b\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:12:22+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:22.998357\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:22.998357\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350742, 1747350742),
(31, 'default', '{\"uuid\":\"dacbe67d-f0da-44e6-96a6-74680acd73fb\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674d700618\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:12:23+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:23.001619\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:12:23.001619\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350743, 1747350743),
(32, 'default', '{\"uuid\":\"75ba375d-4456-4871-a13d-f65c74469864\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:14;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350743, 1747350743),
(33, 'default', '{\"uuid\":\"3b98cdc6-65f3-4f66-b6d7-fc2a1170829e\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674fe3bfa6\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:32:\\\"Laporan baru telah dibuat: Gempa\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:13:02+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.245743\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.245743\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350782, 1747350782),
(34, 'default', '{\"uuid\":\"b9384de8-0607-40c1-bc0d-af2091f61155\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674fe3d0a5\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:32:\\\"Laporan baru telah dibuat: Gempa\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:13:02+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.250085\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.250085\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350782, 1747350782);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(35, 'default', '{\"uuid\":\"ac0d910a-1485-4cb5-9c3a-7a7fca0ff017\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682674fe3ea5f\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:32:\\\"Laporan baru telah dibuat: Gempa\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:13:02+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.256673\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:13:02.256673\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350782, 1747350782),
(36, 'default', '{\"uuid\":\"1fcb63b1-7f1a-426e-98f3-f19e4c4fa81d\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:15;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350782, 1747350782),
(37, 'default', '{\"uuid\":\"1c1d4b56-a16b-4752-9391-1e8cf2bbb62a\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"68267538828a9\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:14:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.534759\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.534759\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350840, 1747350840),
(38, 'default', '{\"uuid\":\"9c701f2a-0246-407d-a96b-9390c1a440db\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826753884049\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:14:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.540802\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.540802\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350840, 1747350840),
(39, 'default', '{\"uuid\":\"3777fd2a-d8a3-48fb-8e8b-20e00b713045\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"682675388538a\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:39:\\\"Laporan baru telah dibuat: Lahar Dingin\\\";s:4:\\\"type\\\";s:7:\\\"bencana\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-15T23:14:00+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.545728\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-15 23:14:00.545728\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350840, 1747350840),
(40, 'default', '{\"uuid\":\"15d3b20b-19db-4b25-b478-3d37946e1d40\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:25:\\\"App\\\\Models\\\\LaporanBencana\\\";s:2:\\\"id\\\";i:16;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747350840, 1747350840),
(41, 'default', '{\"uuid\":\"05f9cadd-01d8-417d-8494-119084a87382\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826e8eac8e3c\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:45:\\\"Laporan baru telah dibuat: jalan rusak ringan\\\";s:4:\\\"type\\\";s:5:\\\"jalan\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-16T07:27:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:60;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.823010\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.823010\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:60;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747380458, 1747380458),
(42, 'default', '{\"uuid\":\"181c8f59-1646-49bb-b740-a0d1ec0ebb84\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826e8eadbcb8\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:45:\\\"Laporan baru telah dibuat: jalan rusak ringan\\\";s:4:\\\"type\\\";s:5:\\\"jalan\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-16T07:27:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:61;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.900414\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.900414\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:61;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747380458, 1747380458),
(43, 'default', '{\"uuid\":\"ca4f1503-5ae6-4a60-9d8f-c160579adf51\",\"displayName\":\"App\\\\Events\\\\NewNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\NewNotification\\\":2:{s:12:\\\"notification\\\";a:4:{s:2:\\\"id\\\";s:13:\\\"6826e8eadc875\\\";s:4:\\\"data\\\";a:3:{s:7:\\\"message\\\";s:45:\\\"Laporan baru telah dibuat: jalan rusak ringan\\\";s:4:\\\"type\\\";s:5:\\\"jalan\\\";s:10:\\\"created_at\\\";s:25:\\\"2025-05-16T07:27:38+00:00\\\";}s:13:\\\"notifiable_id\\\";i:62;s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":4:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.903383\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";s:18:\\\"dumpDateProperties\\\";a:2:{s:4:\\\"date\\\";s:26:\\\"2025-05-16 07:27:38.903383\\\";s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}s:6:\\\"userId\\\";i:62;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747380458, 1747380458),
(44, 'default', '{\"uuid\":\"d3f21664-bf6d-4569-9295-b373d55c2316\",\"displayName\":\"App\\\\Events\\\\LaporanDibuat\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:24:\\\"App\\\\Events\\\\LaporanDibuat\\\":1:{s:7:\\\"laporan\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\LaporanJalan\\\";s:2:\\\"id\\\";i:45;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1747380458, 1747380458);

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan_bencana`
--

CREATE TABLE `laporan_bencana` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `jenis_bencana` enum('Banjir','Longsor','Erupsi','Lahar Panas','Lahar Dingin','Gempa','Angin Topan') NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `status` enum('menunggu','dalam_proses','selesai') NOT NULL DEFAULT 'menunggu',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `laporan_bencana`
--

INSERT INTO `laporan_bencana` (`id`, `user_id`, `lokasi`, `latitude`, `longitude`, `jenis_bencana`, `deskripsi`, `foto`, `status`, `created_at`, `updated_at`) VALUES
(1, 60, 'Lat: -8.238508511114578, Lng: 113.14954286455946', -8.2385085111146, 113.14954286456, 'Angin Topan', NULL, NULL, 'selesai', '2024-10-07 17:00:00', '2024-10-07 17:00:00'),
(2, 62, 'Lat: -8.243845785212335, Lng: 113.14679044809536', -8.243845785212335, 113.14679044809536, 'Angin Topan', NULL, NULL, 'menunggu', '2025-03-22 15:17:59', '2025-03-22 15:17:59'),
(3, 87, 'Lat: -8.145235660095846, Lng: 113.21993955362215', -8.145235660095846, 113.21993955362215, 'Longsor', 'kgkgkg', 'laporan-bencana/1747305181_foto_bencana_1747305179751.jpg', 'menunggu', '2025-05-15 03:33:01', '2025-05-15 03:33:01'),
(4, 87, 'Lat: -8.144803111598005, Lng: 113.2134788436168', -8.144803111598005, 113.2134788436168, 'Lahar Dingin', 'hdhdhd', 'laporan-bencana/1747347847_foto_bencana_1747347845920.jpg', 'menunggu', '2025-05-15 15:24:07', '2025-05-15 15:24:07'),
(5, 87, 'Lat: -8.140261324159287, Lng: 113.21547635782137', -8.140261324159287, 113.21547635782137, 'Lahar Dingin', 'jfjdcu', 'laporan-bencana/1747348460_foto_bencana_1747348460039.jpg', 'menunggu', '2025-05-15 15:34:20', '2025-05-15 15:34:20'),
(10, 87, 'Lat: -8.145884481966204, Lng: 113.22490212797408', -8.145884481966204, 113.22490212797408, 'Lahar Dingin', 'ghhh', 'laporan-bencana/1747349741_foto_bencana_1747349739498.jpg', 'menunggu', '2025-05-15 15:55:41', '2025-05-15 15:55:41'),
(13, 87, 'Lat: -8.14403070240382, Lng: 113.22611936319247', -8.14403070240382, 113.22611936319247, 'Lahar Panas', 'hhjj', 'laporan-bencana/1747350660_foto_bencana_1747350659646.jpg', 'menunggu', '2025-05-15 16:11:00', '2025-05-15 16:11:00'),
(14, 87, 'Lat: -8.143938013200373, Lng: 113.22402821550958', -8.143938013200373, 113.22402821550958, 'Lahar Dingin', 'fxhxhx', 'laporan-bencana/1747350742_foto_bencana_1747350741723.jpg', 'menunggu', '2025-05-15 16:12:22', '2025-05-15 16:12:22'),
(15, 87, 'Lat: -8.14671867996851, Lng: 113.2252766618874', -8.14671867996851, 113.2252766618874, 'Gempa', 'fhfjff', 'laporan-bencana/1747350782_foto_bencana_1747350780615.jpg', 'menunggu', '2025-05-15 16:13:02', '2025-05-15 16:13:02'),
(16, 87, 'Lat: -8.127006425659507, Lng: 113.21532030202414', -8.127006425659507, 113.21532030202414, 'Lahar Dingin', 'hdhdhd', 'laporan-bencana/1747350840_foto_bencana_1747350839167.jpg', 'menunggu', '2025-05-15 16:14:00', '2025-05-15 16:14:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `laporan_jalan`
--

CREATE TABLE `laporan_jalan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `jenis_rusak` enum('jalan rusak ringan','jalan rusak berat') NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `status` enum('menunggu','dalam_proses','selesai') NOT NULL DEFAULT 'menunggu',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `laporan_jalan`
--

INSERT INTO `laporan_jalan` (`id`, `user_id`, `lokasi`, `latitude`, `longitude`, `jenis_rusak`, `deskripsi`, `foto`, `status`, `created_at`, `updated_at`) VALUES
(1, 61, 'Lat: -8.2053897448152, Lng: 113.17503656814', -8.2053897448152, 113.17503656814, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(2, 61, 'Lat: -8.2053194687895, Lng: 113.17486996814', -8.2053194687895, 113.17486996814, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(3, 61, 'Lat: -8.205183073714, Lng: 113.17464766814', -8.205183073714, 113.17464766814, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(4, 61, 'Lat: -8.2049796066537, Lng: 113.1737436528', -8.2049796066537, 113.1737436528, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(5, 61, 'Lat: -8.1992836960069, Lng: 113.1666794528', -8.1992836960069, 113.1666794528, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(6, 61, 'Lat: -8.2037225578915, Lng: 113.17254747834', -8.2037225578915, 113.17254747834, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(7, 61, 'Lat: -8.1995855870385, Lng: 113.16727206307', -8.1995855870385, 113.16727206307, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(8, 61, 'Lat: -8.1980478818525, Lng: 113.16478497174', -8.1980478818525, 113.16478497174, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(9, 61, 'Lat: -8.1975984634749, Lng: 113.16421648526', -8.1975984634749, 113.16421648526, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(10, 61, 'Lat: -8.1966538668248, Lng: 113.16291014436', -8.1966538668248, 113.16291014436, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(11, 61, 'Lat: -8.1960453976167, Lng: 113.16205990727', -8.1960453976167, 113.16205990727, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(12, 61, 'Lat: -8.1959619783811, Lng: 113.16196819074', -8.1959619783811, 113.16196819074, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(13, 61, 'Lat: -8.1934975415461, Lng: 113.15790825213', -8.1934975415461, 113.15790825213, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(14, 61, 'Lat: -8.1927076493771, Lng: 113.15731441843', -8.1927076493771, 113.15731441843, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(15, 61, 'Lat: -8.1924730046386, Lng: 113.15743177687', -8.1924730046386, 113.15743177687, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(16, 61, 'Lat: -8.1917318980596, Lng: 113.15787069742', -8.1917318980596, 113.15787069742, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(17, 61, 'Lat: -8.1917318980596, Lng: 113.15787069742', -8.1917318980596, 113.15787069742, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(18, 61, 'Lat: -8.1917318980596, Lng: 113.15787069742', -8.1917318980596, 113.15787069742, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(19, 61, 'Lat: -8.1844933255441, Lng: 113.15410243533', -8.1844933255441, 113.15410243533, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(20, 61, 'Lat: -8.1818262112498, Lng: 113.15457891062', -8.1818262112498, 113.15457891062, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(21, 61, 'Lat: -8.1837075869878, Lng: 113.15414705723', -8.1837075869878, 113.15414705723, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(22, 61, 'Lat: -8.2080278723704, Lng: 113.17600509981', -8.2080278723704, 113.17600509981, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(23, 61, 'Lat: -8.2091116286718, Lng: 113.17780845972', -8.2091116286718, 113.17780845972, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(24, 61, 'Lat: -8.2094734517192, Lng: 113.17782159538', -8.2094734517192, 113.17782159538, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(25, 61, 'Lat: -8.2094908457196, Lng: 113.17782159538', -8.2094908457196, 113.17782159538, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(26, 61, 'Lat: -8.2099117177396, Lng: 113.17783313813', -8.2099117177396, 113.17783313813, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(27, 61, 'Lat: -8.211713974953, Lng: 113.18258920081', -8.211713974953, 113.18258920081, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(28, 61, 'Lat: -8.2117437048805, Lng: 113.18279140967', -8.2117437048805, 113.18279140967, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(29, 61, 'Lat: -8.2117716896057, Lng: 113.18300309647', -8.2117716896057, 113.18300309647, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(30, 61, 'Lat: -8.212423443922, Lng: 113.18512663271', -8.212423443922, 113.18512663271, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(31, 61, 'Lat: -8.2128064099039, Lng: 113.18587999177', -8.2128064099039, 113.18587999177, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(32, 61, 'Lat: -8.2130573851236, Lng: 113.18642874383', -8.2130573851236, 113.18642874383, 'jalan rusak ringan', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(33, 61, 'Lat: -8.2132062233635, Lng: 113.1869836461', -8.2132062233635, 113.1869836461, 'jalan rusak berat', NULL, NULL, 'dalam_proses', '2025-03-22 12:47:51', '2025-03-22 12:47:51'),
(34, 62, 'Lat: -8.210282127823815, Lng: 113.11658148235684', -8.210282127823815, 113.11658148235684, 'jalan rusak ringan', NULL, NULL, 'menunggu', '2025-03-22 15:17:19', '2025-03-22 15:17:19'),
(35, 87, 'Lat: -8.142084224625643, Lng: 113.22568240696023', -8.142084224625643, 113.22568240696023, 'jalan rusak ringan', 'vhvhv', 'laporan-jalan/1747302310_foto_jalan_1747302309357.jpg', 'dalam_proses', '2025-05-15 02:45:10', '2025-05-15 02:45:10'),
(36, 87, 'Lat: -8.142105975098442, Lng: 113.22792732527103', -8.142105975098442, 113.22792732527103, 'jalan rusak ringan', 'hvyvyv', 'laporan-jalan/1747304269_foto_jalan_1747304268677.jpg', 'menunggu', '2025-05-15 03:17:50', '2025-05-15 03:17:50'),
(37, 87, 'Lat: -8.143443670419595, Lng: 113.22162495623222', -8.143443670419595, 113.22162495623222, 'jalan rusak ringan', 'jcuchv', 'laporan-jalan/1747304958_foto_jalan_1747304957408.jpg', 'menunggu', '2025-05-15 03:29:18', '2025-05-15 03:29:18'),
(38, 87, 'Lat: -8.14332008462909, Lng: 113.22181222318892', -8.14332008462909, 113.22181222318892, 'jalan rusak ringan', 'ugugguvuv', 'laporan-jalan/1747304981_foto_jalan_1747304980591.jpg', 'menunggu', '2025-05-15 03:29:41', '2025-05-15 03:29:41'),
(39, 87, 'Lat: -8.141033740624081, Lng: 113.22555756232244', -8.141033740624081, 113.22555756232244, 'jalan rusak ringan', 'vkjvibi', 'laporan-jalan/1747305007_foto_jalan_1747305004763.jpg', 'menunggu', '2025-05-15 03:30:07', '2025-05-15 03:30:07'),
(40, 87, 'Lat: -8.14539014158891, Lng: 113.22780476580255', -8.14539014158891, 113.22780476580255, 'jalan rusak ringan', 'gjjvib', 'laporan-jalan/1747305033_foto_jalan_1747305032107.jpg', 'menunggu', '2025-05-15 03:30:33', '2025-05-15 03:30:33'),
(41, 87, 'Lat: -8.146873160889227, Lng: 113.22109436652165', -8.146873160889227, 113.22109436652165, 'jalan rusak ringan', 'vjjvvi', 'laporan-jalan/1747305054_foto_jalan_1747305052878.jpg', 'menunggu', '2025-05-15 03:30:54', '2025-05-15 03:30:54'),
(42, 87, 'Lat: -8.145081178543126, Lng: 113.22156253391336', -8.145081178543126, 113.22156253391336, 'jalan rusak berat', 'jvvhvu', 'laporan-jalan/1747305072_foto_jalan_1747305071615.jpg', 'menunggu', '2025-05-15 03:31:12', '2025-05-15 03:31:12'),
(43, 87, 'Lat: -8.144741318917331, Lng: 113.22187464550781', -8.144741318917331, 113.22187464550781, 'jalan rusak ringan', 'fugugug', 'laporan-jalan/1747305093_foto_jalan_1747305092424.jpg', 'menunggu', '2025-05-15 03:31:33', '2025-05-15 03:31:33'),
(44, 87, 'Lat: -8.147398395573747, Lng: 113.22062619912997', -8.147398395573747, 113.22062619912997, 'jalan rusak ringan', 'fhcjggu', 'laporan-jalan/1747305127_foto_jalan_1747305126719.jpg', 'menunggu', '2025-05-15 03:32:07', '2025-05-15 03:32:07'),
(45, 87, 'Lat: -8.141528086379795, Lng: 113.22302945840731', -8.141528086379795, 113.22302945840731, 'jalan rusak ringan', 'vxhchc', 'laporan-jalan/1747380458_foto_jalan_1747380455797.jpg', 'menunggu', '2025-05-16 00:27:38', '2025-05-16 00:27:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2024_01_01_000000_create_admins_table', 1),
(4, '2024_01_01_000000_create_users_table', 1),
(5, '2024_01_01_000001_create_jenis_bencana_table', 1),
(6, '2024_01_01_000001_create_laporan_jalan_table', 1),
(7, '2024_01_01_000002_create_laporan_bencana_table', 1),
(8, '2024_01_01_000004_create_sessions_table', 1),
(9, '2025_02_18_030842_create_personal_access_tokens_table', 1),
(10, '2025_03_06_294433_create_notifications_table', 1),
(11, '2025_03_06_294444_add_reset_password_fields_to_users_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('02ea7afe-beaf-414f-ad40-e31b5f78ebcb', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":43,\"lokasi\":\"Lat: -8.144741318917331, Lng: 113.22187464550781\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:33', '2025-05-15 03:31:33'),
('06325afd-94bc-4658-8fba-3984ce5fa0fd', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":38,\"lokasi\":\"Lat: -8.14332008462909, Lng: 113.22181222318892\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:41', '2025-05-15 03:29:41'),
('0a942a2c-33ce-4026-bcc6-432f1ebff8d5', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Gempa\",\"laporan_id\":15,\"lokasi\":\"Lat: -8.14671867996851, Lng: 113.2252766618874\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:13:02', '2025-05-15 16:13:02'),
('0b1e9707-f64c-4bdd-864d-a76e8290c609', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":45,\"lokasi\":\"Lat: -8.141528086379795, Lng: 113.22302945840731\",\"type\":\"jalan\"}', NULL, '2025-05-16 00:27:38', '2025-05-16 00:27:38'),
('1555f081-2667-4204-bae7-fa6f6d9160f9', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":8,\"lokasi\":\"Lat: -8.143783531146932, Lng: 113.22524545072798\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:46:12', '2025-05-15 15:46:12'),
('1726966a-d615-4c0b-ad99-46fdaff5b9b0', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Angin Topan\",\"laporan_id\":2,\"lokasi\":\"Lat: -8.243845785212335, Lng: 113.14679044809536\",\"type\":\"bencana\"}', NULL, '2025-03-22 15:17:59', '2025-03-22 15:17:59'),
('1899918e-1be4-4f69-8fd0-689684cb5c29', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Longsor\",\"laporan_id\":3,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.21993955362215\",\"type\":\"bencana\"}', NULL, '2025-05-15 03:33:01', '2025-05-15 03:33:01'),
('19310d0f-7b5a-4c30-8182-a59b990ef140', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":36,\"lokasi\":\"Lat: -8.142105975098442, Lng: 113.22792732527103\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:17:50', '2025-05-15 03:17:50'),
('1c1ea4e7-786c-453e-a7f9-f138c9a00515', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":13,\"lokasi\":\"Lat: -8.14403070240382, Lng: 113.22611936319247\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:11:00', '2025-05-15 16:11:00'),
('1f098ddb-e986-46cb-8d30-abcb81b7a4d0', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":37,\"lokasi\":\"Lat: -8.143443670419595, Lng: 113.22162495623222\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:18', '2025-05-15 03:29:18'),
('23fb2b54-7bda-4710-811d-ba9eff5c6581', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":35,\"lokasi\":\"Lat: -8.142084224625643, Lng: 113.22568240696023\",\"type\":\"jalan\"}', NULL, '2025-05-15 02:45:11', '2025-05-15 02:45:11'),
('2610b5ef-2334-490f-9929-5a374d0bfdbc', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":37,\"lokasi\":\"Lat: -8.143443670419595, Lng: 113.22162495623222\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:18', '2025-05-15 03:29:18'),
('286d5934-0e6f-44ee-8547-3ca48d235df7', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":43,\"lokasi\":\"Lat: -8.144741318917331, Lng: 113.22187464550781\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:33', '2025-05-15 03:31:33'),
('298e9f8e-9b7e-4de1-bd6f-794e32397d12', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":9,\"lokasi\":\"Lat: -8.143907116794452, Lng: 113.23002075812322\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:50:38', '2025-05-15 15:50:38'),
('2ae9e992-29fc-43d3-9463-ca45b8bb7426', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":5,\"lokasi\":\"Lat: -8.140261324159287, Lng: 113.21547635782137\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:34:20', '2025-05-15 15:34:20'),
('2e85b9e8-b3ca-4eda-b67f-6156cc7af108', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":44,\"lokasi\":\"Lat: -8.147398395573747, Lng: 113.22062619912997\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:32:07', '2025-05-15 03:32:07'),
('2f293b35-9663-4109-b49d-26e7a2e274fb', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":4,\"lokasi\":\"Lat: -8.144803111598005, Lng: 113.2134788436168\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:24:07', '2025-05-15 15:24:07'),
('2fddf008-7313-436c-a891-256acfe59a7b', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":5,\"lokasi\":\"Lat: -8.140261324159287, Lng: 113.21547635782137\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:34:20', '2025-05-15 15:34:20'),
('3223120d-5dd0-48fc-ac65-7c793c3faa9b', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":13,\"lokasi\":\"Lat: -8.14403070240382, Lng: 113.22611936319247\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:11:00', '2025-05-15 16:11:00'),
('46984060-da1d-4bfb-b4a3-4597bda105f8', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":40,\"lokasi\":\"Lat: -8.14539014158891, Lng: 113.22780476580255\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:33', '2025-05-15 03:30:33'),
('4972c72c-8881-4309-aa28-55cbfb419c2a', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":7,\"lokasi\":\"Lat: -8.14492669693079, Lng: 113.22112557768111\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:43:40', '2025-05-15 15:43:40'),
('4ac5dc3c-1437-4fbe-9bb8-f75edcef7906', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":35,\"lokasi\":\"Lat: -8.142084224625643, Lng: 113.22568240696023\",\"type\":\"jalan\"}', NULL, '2025-05-15 02:45:11', '2025-05-15 02:45:11'),
('4ac69d2e-3bab-4e08-a0d4-af703210dcd8', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Gempa\",\"laporan_id\":15,\"lokasi\":\"Lat: -8.14671867996851, Lng: 113.2252766618874\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:13:02', '2025-05-15 16:13:02'),
('4b460bcc-626a-4012-b268-84107dda176e', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":5,\"lokasi\":\"Lat: -8.140261324159287, Lng: 113.21547635782137\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:34:20', '2025-05-15 15:34:20'),
('507ccf88-a9e2-4ed5-b309-6225797cd518', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":13,\"lokasi\":\"Lat: -8.14403070240382, Lng: 113.22611936319247\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:11:00', '2025-05-15 16:11:00'),
('5143bc52-f3f6-480f-866b-e0944aeaf536', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":39,\"lokasi\":\"Lat: -8.141033740624081, Lng: 113.22555756232244\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:07', '2025-05-15 03:30:07'),
('51528028-b5e1-4e90-b943-3d773c9dcadd', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":10,\"lokasi\":\"Lat: -8.145884481966204, Lng: 113.22490212797408\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:55:41', '2025-05-15 15:55:41'),
('5635c308-a411-4afb-bef7-67d4dc8c8037', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":16,\"lokasi\":\"Lat: -8.127006425659507, Lng: 113.21532030202414\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:14:00', '2025-05-15 16:14:00'),
('57868774-dce8-4296-b854-1d945825d1b7', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":6,\"lokasi\":\"Lat: -8.145297452700223, Lng: 113.21731781622869\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:37:40', '2025-05-15 15:37:40'),
('584954b8-2d7c-434d-8bd1-01f60e059c8c', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":9,\"lokasi\":\"Lat: -8.143907116794452, Lng: 113.23002075812322\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:50:38', '2025-05-15 15:50:38'),
('59222313-0ab1-4124-aa1d-39263fc44888', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":12,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.2245900163796\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:06:09', '2025-05-15 16:06:09'),
('59bb3e69-30e0-4f78-9aa2-dfe35776d312', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":40,\"lokasi\":\"Lat: -8.14539014158891, Lng: 113.22780476580255\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:33', '2025-05-15 03:30:33'),
('60573087-03df-426d-b82e-9fd51398ae39', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":41,\"lokasi\":\"Lat: -8.146873160889227, Lng: 113.22109436652165\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:54', '2025-05-15 03:30:54'),
('62f44ac4-6de7-4cce-8c2b-b632801c2d43', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":41,\"lokasi\":\"Lat: -8.146873160889227, Lng: 113.22109436652165\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:54', '2025-05-15 03:30:54'),
('6655f9fb-df78-4ee4-acf2-f46152dcc525', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":8,\"lokasi\":\"Lat: -8.143783531146932, Lng: 113.22524545072798\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:46:12', '2025-05-15 15:46:12'),
('6786ec30-7a1d-483a-be04-49b74028c10b', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":16,\"lokasi\":\"Lat: -8.127006425659507, Lng: 113.21532030202414\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:14:00', '2025-05-15 16:14:00'),
('6e44904c-23d2-454c-a9a0-eac02eab397b', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":36,\"lokasi\":\"Lat: -8.142105975098442, Lng: 113.22792732527103\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:17:50', '2025-05-15 03:17:50'),
('702fac5c-6939-4ce0-a445-f4256971f22f', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":12,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.2245900163796\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:06:09', '2025-05-15 16:06:09'),
('73894d00-e095-46e7-94e7-c5c8225a6087', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak berat\",\"laporan_id\":42,\"lokasi\":\"Lat: -8.145081178543126, Lng: 113.22156253391336\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:12', '2025-05-15 03:31:12'),
('746be4e2-4b97-41ee-9296-4a2aa332be9d', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":7,\"lokasi\":\"Lat: -8.14492669693079, Lng: 113.22112557768111\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:43:40', '2025-05-15 15:43:40'),
('79769410-46ec-4822-bc0f-c408e025ea53', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":11,\"lokasi\":\"Lat: -8.14406159880021, Lng: 113.22917805681817\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:03:41', '2025-05-15 16:03:41'),
('82c129ae-59ab-41c6-878f-27add2d824c8', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Angin Topan\",\"laporan_id\":2,\"lokasi\":\"Lat: -8.243845785212335, Lng: 113.14679044809536\",\"type\":\"bencana\"}', NULL, '2025-03-22 15:17:59', '2025-03-22 15:17:59'),
('831776db-5943-4941-966e-cd5bcf45b1a1', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Longsor\",\"laporan_id\":3,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.21993955362215\",\"type\":\"bencana\"}', NULL, '2025-05-15 03:33:01', '2025-05-15 03:33:01'),
('8400b0ed-7654-43e1-9d2b-d5128b728a21', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":7,\"lokasi\":\"Lat: -8.14492669693079, Lng: 113.22112557768111\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:43:40', '2025-05-15 15:43:40'),
('84a964dd-7d84-44c5-9260-6e9873ec36e3', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":10,\"lokasi\":\"Lat: -8.145884481966204, Lng: 113.22490212797408\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:55:41', '2025-05-15 15:55:41'),
('85bfc8d9-c1bd-4d4e-ab87-ac5ba51f14de', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":44,\"lokasi\":\"Lat: -8.147398395573747, Lng: 113.22062619912997\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:32:07', '2025-05-15 03:32:07'),
('94824e6c-ff4f-4349-b051-cfd28dfee893', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":39,\"lokasi\":\"Lat: -8.141033740624081, Lng: 113.22555756232244\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:07', '2025-05-15 03:30:07'),
('96ba724a-8349-4154-b5fc-eb143afae8cb', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":8,\"lokasi\":\"Lat: -8.143783531146932, Lng: 113.22524545072798\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:46:12', '2025-05-15 15:46:12'),
('97ba3417-db5b-4c04-b9e3-d9c475cf952a', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":41,\"lokasi\":\"Lat: -8.146873160889227, Lng: 113.22109436652165\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:54', '2025-05-15 03:30:54'),
('a1d3c44c-453c-47cf-9bfc-0546363a3467', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":43,\"lokasi\":\"Lat: -8.144741318917331, Lng: 113.22187464550781\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:33', '2025-05-15 03:31:33'),
('ab72b070-353b-4784-833c-bf0374bc8e01', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":40,\"lokasi\":\"Lat: -8.14539014158891, Lng: 113.22780476580255\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:33', '2025-05-15 03:30:33'),
('ac241bee-56c1-407d-9201-69e858f5e145', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":11,\"lokasi\":\"Lat: -8.14406159880021, Lng: 113.22917805681817\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:03:41', '2025-05-15 16:03:41'),
('ac277360-381a-4944-8d85-e45d5540c0fb', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":34,\"lokasi\":\"Lat: -8.210282127823815, Lng: 113.11658148235684\",\"type\":\"jalan\"}', NULL, '2025-03-22 15:17:21', '2025-03-22 15:17:21'),
('ac4c8470-364a-4a79-ba08-185b85f25fbf', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":6,\"lokasi\":\"Lat: -8.145297452700223, Lng: 113.21731781622869\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:37:40', '2025-05-15 15:37:40'),
('ad0fa25c-eec9-4d04-850d-bc43d9c45e83', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":36,\"lokasi\":\"Lat: -8.142105975098442, Lng: 113.22792732527103\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:17:50', '2025-05-15 03:17:50'),
('ae904025-5d45-429b-a768-380f3eb4e9bc', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Gempa\",\"laporan_id\":15,\"lokasi\":\"Lat: -8.14671867996851, Lng: 113.2252766618874\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:13:02', '2025-05-15 16:13:02'),
('b118147f-a5ed-4a52-9a9b-e235b84e98c4', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":38,\"lokasi\":\"Lat: -8.14332008462909, Lng: 113.22181222318892\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:41', '2025-05-15 03:29:41'),
('bb2d77f5-1b78-4029-a174-ad27195cc518', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak berat\",\"laporan_id\":42,\"lokasi\":\"Lat: -8.145081178543126, Lng: 113.22156253391336\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:12', '2025-05-15 03:31:12'),
('bc177aac-19a7-42d0-b416-a9c56a3f2dbe', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":45,\"lokasi\":\"Lat: -8.141528086379795, Lng: 113.22302945840731\",\"type\":\"jalan\"}', NULL, '2025-05-16 00:27:38', '2025-05-16 00:27:38'),
('bc60b363-dbdf-4004-9be7-75a21d25e353', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":44,\"lokasi\":\"Lat: -8.147398395573747, Lng: 113.22062619912997\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:32:07', '2025-05-15 03:32:07'),
('c3c23057-edaa-400d-ab39-b83dcc8648c8', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":11,\"lokasi\":\"Lat: -8.14406159880021, Lng: 113.22917805681817\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:03:41', '2025-05-15 16:03:41'),
('c444296d-55cb-4902-95ce-efba2c5c22e6', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak berat\",\"laporan_id\":42,\"lokasi\":\"Lat: -8.145081178543126, Lng: 113.22156253391336\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:31:12', '2025-05-15 03:31:12'),
('c70bc1ba-65e1-400f-9de5-73108a84e319', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":16,\"lokasi\":\"Lat: -8.127006425659507, Lng: 113.21532030202414\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:14:00', '2025-05-15 16:14:00'),
('ca6f8b87-1094-4c78-9eda-251527177689', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":10,\"lokasi\":\"Lat: -8.145884481966204, Lng: 113.22490212797408\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:55:41', '2025-05-15 15:55:41'),
('cc22e638-3a56-49c7-a540-d075794e6d67', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":4,\"lokasi\":\"Lat: -8.144803111598005, Lng: 113.2134788436168\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:24:07', '2025-05-15 15:24:07'),
('cd303418-2e3f-4ebc-bdcb-37c4f1b3b0a3', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Longsor\",\"laporan_id\":3,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.21993955362215\",\"type\":\"bencana\"}', NULL, '2025-05-15 03:33:01', '2025-05-15 03:33:01'),
('ce386530-a69f-4928-8ff3-beed478e1d54', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":14,\"lokasi\":\"Lat: -8.143938013200373, Lng: 113.22402821550958\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:12:22', '2025-05-15 16:12:22'),
('d1880f90-e4b8-413f-a8ff-733682e141ca', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":39,\"lokasi\":\"Lat: -8.141033740624081, Lng: 113.22555756232244\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:30:07', '2025-05-15 03:30:07'),
('d1a9933d-2dbb-4e70-8d18-db98c4ff5c1e', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":14,\"lokasi\":\"Lat: -8.143938013200373, Lng: 113.22402821550958\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:12:22', '2025-05-15 16:12:22'),
('d2afccc4-a01f-4c07-8516-aa43909b2ed5', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":14,\"lokasi\":\"Lat: -8.143938013200373, Lng: 113.22402821550958\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:12:22', '2025-05-15 16:12:22'),
('dc5536f3-1358-45e0-9ab7-496f12844bd9', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":45,\"lokasi\":\"Lat: -8.141528086379795, Lng: 113.22302945840731\",\"type\":\"jalan\"}', NULL, '2025-05-16 00:27:38', '2025-05-16 00:27:38'),
('de8fd46c-02ce-40d5-b015-aa89c2a38bd7', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":4,\"lokasi\":\"Lat: -8.144803111598005, Lng: 113.2134788436168\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:24:07', '2025-05-15 15:24:07'),
('e063f956-ed46-4fe4-88fe-ad6f9df000c4', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":37,\"lokasi\":\"Lat: -8.143443670419595, Lng: 113.22162495623222\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:18', '2025-05-15 03:29:18'),
('e35d5f5b-8392-40a4-b2d2-a5a2aebf3621', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Angin Topan\",\"laporan_id\":2,\"lokasi\":\"Lat: -8.243845785212335, Lng: 113.14679044809536\",\"type\":\"bencana\"}', '2025-03-23 03:16:08', '2025-03-22 15:17:59', '2025-03-23 03:16:08'),
('eb912303-eeb8-497b-bbbf-e63d4481dd42', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":38,\"lokasi\":\"Lat: -8.14332008462909, Lng: 113.22181222318892\",\"type\":\"jalan\"}', NULL, '2025-05-15 03:29:41', '2025-05-15 03:29:41'),
('f0e52ae2-7a00-440d-b088-5f595d3c27cb', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":6,\"lokasi\":\"Lat: -8.145297452700223, Lng: 113.21731781622869\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:37:40', '2025-05-15 15:37:40'),
('f1141a51-64c3-4f53-8362-2cfee8cdf74f', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":34,\"lokasi\":\"Lat: -8.210282127823815, Lng: 113.11658148235684\",\"type\":\"jalan\"}', NULL, '2025-03-22 15:17:21', '2025-03-22 15:17:21'),
('f14dbe44-51fd-4d2f-b0c2-95d99b07c9d0', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 62, '{\"message\":\"Laporan bencana baru: Lahar Panas\",\"laporan_id\":9,\"lokasi\":\"Lat: -8.143907116794452, Lng: 113.23002075812322\",\"type\":\"bencana\"}', NULL, '2025-05-15 15:50:38', '2025-05-15 15:50:38'),
('f6c4d340-e570-4c2f-9bc8-c0933e41c259', 'App\\Notifications\\NewLaporanJalanNotification', 'App\\Models\\User', 61, '{\"message\":\"Laporan jalan rusak baru: Jalan rusak ringan\",\"laporan_id\":34,\"lokasi\":\"Lat: -8.210282127823815, Lng: 113.11658148235684\",\"type\":\"jalan\"}', '2025-03-23 03:16:14', '2025-03-22 15:17:21', '2025-03-23 03:16:14'),
('f7fc4bdd-0bc7-483e-b111-1c9cf276dd31', 'App\\Notifications\\NewLaporanBencanaNotification', 'App\\Models\\User', 60, '{\"message\":\"Laporan bencana baru: Lahar Dingin\",\"laporan_id\":12,\"lokasi\":\"Lat: -8.145235660095846, Lng: 113.2245900163796\",\"type\":\"bencana\"}', NULL, '2025-05-15 16:06:09', '2025-05-15 16:06:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2CBiia8LRNQHeCISKKZaSdJe0k4CaQwhB8hVoov6', NULL, '146.190.58.222', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSmFjc3NyZjVGZ1MwTXNNbnhrZUlvc3MzOXpSTnBGWVk1aXBWQVJCaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vamFnYWphbGFuLm95aS53ZWIuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748612377),
('2OfMkKjihWFH2ofYbRGm9jkKDXS3BPEKVvwhpo08', NULL, '135.148.100.196', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYTUyYjJnbFhhT2l6MjY2eFpHb2hlN28xZnpTRGdMbldVZW1ySEZSNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748697563),
('4c5WJcemrEB7Sp0VNUTWfm9NUuOECPTDBOtTf5CX', NULL, '149.57.180.70', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2ozanlnMU9rYlZROUlQTjB6SkhkWjhseG9NZVBHTzdoYVdjNEJKWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748520226),
('91aj6MTLzVA0EhkEEVItkY9VK0ng1AJw5Tytc5yd', NULL, '149.57.180.2', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlMyNjlrQ1hkZW9vcVJUcjhJeHFUU3Q1SFYzbDlkRFpmd3MyVmtYbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vamFnYWphbGFuLm95aS53ZWIuaWQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748518317),
('CLcxzgiE9eLLgkxjuKWeHc1A68YWDXKgfq5DCPPD', NULL, '146.190.58.222', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkIzcE9xU2F0T0dmSUg2cTk5a0Z0b0xLTlhlSVZKSGtGZm1yUVQxRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9qYWdhamFsYW4ub3lpLndlYi5pZC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748612375),
('eyfIARdKtYw4Bfsf07FyEajlHXpGQQJGNqidtr1V', NULL, '104.152.52.116', 'curl/7.61.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnZ4Mk9CZHg1aTlBOXd6T3JVeFo1SUduc0tsVXBuRTVWRGJnSUN0MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748803446),
('g81bbwBp5Pxs1MYVAh9pEAr2m17L8t3mnC3kqpHf', NULL, '68.183.91.193', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiODJXZHFRdHlGY3h2YXJLa2NEc0NhcThDOGNUU1FxQUhHTnVUYnVlYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748611687),
('Hw10wftblZYALuZYOe2KNSqaCllWMAsBi6W1hlZQ', NULL, '146.190.33.219', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUTR2d2xoTXZnOUpZWVlBN2Z2Z282WFVrckZZNzhZYUVvcm5VN1pHaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748599510),
('jooQeUCmpUrsXRs3omasCTS4MqU3cMTUwllp1Md5', NULL, '146.190.58.222', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUwzV2lpTjF5UHhuWFB5b0g3VlZkSHZISlljRkZ6dVY0WmVTQnB6cyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vamFnYWphbGFuLm95aS53ZWIuaWQvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748612385),
('mm795ECWWRPm8WkgGom3Oi2QrmYL3vbTkNlrtzYI', NULL, '146.190.58.222', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWtXTUVTM1BoWXdMeWpPNlh2M1FhSHpNWW1vb1VHdFVTVHdRNU4ydyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9qYWdhamFsYW4ub3lpLndlYi5pZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748612375),
('n2fb0fFcQxBUN6XhFySBXEPYJaFHtX2q8o98rzri', NULL, '146.190.33.219', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiclUxTlg4cW1GcnF3bTVFanpyRGJXQ0lMZXBIWVVZTm5oUUhYVXpERiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748599503),
('NYMdtKXQPurz5iOSDiitp81f1eZ13fJ3ziMPswzW', NULL, '68.183.91.193', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVBDVmpCN282c2VzOUhFYWlWVnNBcDRUNGJhTUpmZkN3U2hVdmc4byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly93d3cuamFnYWphbGFuLm95aS53ZWIuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748611681),
('OVrFCM89EA9IdBH9dSWvGoDkvvBg1A9Qoi0L6fWf', NULL, '146.190.33.219', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnpJa2gyQzNaVVJDajJXaUZYVzNpdzZ2Q0JsTU1rUEZlTE1oN0ZuRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly93d3cuamFnYWphbGFuLm95aS53ZWIuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748599503),
('pNRV0zvx7YmOQvPsHlTJhWfnhu3bs8yoozwsfQqG', NULL, '135.148.100.196', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnM5Q2dVWjFjTFI4WUoxNzlVb1hEQlp5QVBkODFnSGF4Um5ZRXpkMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748697566),
('RE9otuHnCGEIrvGSB1z1D7wkqUMdaRzOkOJskmW7', NULL, '68.183.91.193', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZHdFMTlqTmp5SXJ3ZWNoa01oYWJFaHdnYUt4RmZFSG43M3ZBQ1BIYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vd3d3LmphZ2FqYWxhbi5veWkud2ViLmlkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1748611681),
('vPz57IHtBS0PS0VvZwrEHMnX2kFLuF92UE3qG8YM', NULL, '104.152.52.221', 'curl/7.61.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0RJUXJOU0h0clFJeGlOYnZieVF0OGJWUkYyTnJ5dUxXMVk2WlljRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vamFnYWphbGFuLm95aS53ZWIuaWQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1748798403);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `tipe_pengguna` enum('user','admin','super admin') NOT NULL DEFAULT 'user',
  `instansi` varchar(255) DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) NOT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `tipe_pengguna`, `instansi`, `jabatan`, `alamat`, `verification_token`, `email_verified_at`, `is_verified`, `remember_token`, `created_at`, `updated_at`, `reset_password_token`, `reset_password_expires_at`) VALUES
(60, 'Admin BPBD', 'admin1@gmail.com', '$2y$12$i4wOqhS6r3w3mQ/U2xgdNOvisRWkbsafM4KmCums2FlGgawwDFOaC', 'admin', 'BPBD', 'Kepala Seksi Kedaruratan dan Logistik', 'Alamat Admin 1', NULL, NULL, 0, NULL, '2025-03-22 12:38:28', '2025-03-22 12:38:28', NULL, NULL),
(61, 'Admin PUPR', 'admin2@gmail.com', '$2y$12$OJRJdm4kBi2OOPec1tJcjOznLYZlQkhXEkPoL38c5YtI/dYTAegIi', 'admin', 'PUPR', 'Kepala Bidang Bina Marga', 'Alamat Admin 2', NULL, NULL, 0, NULL, '2025-03-22 12:38:28', '2025-03-22 12:38:28', NULL, NULL),
(62, 'Super Admin', 'superadmin@gmail.com', '$2y$12$mwPMdmUBJlJxPiavJrJLEe6bL998A9jM0angQVqposoQR2G1VdyLS', 'super admin', 'BPBD', 'Koordinator Tim Reaksi Cepat (TRC)', 'Alamat Super Admin', NULL, NULL, 0, NULL, '2025-03-22 12:38:29', '2025-03-22 12:38:29', NULL, NULL),
(63, 'Ahmad Fauzi', 'ahmad.fauzi87@gmail.com', '$2y$12$LmKo/uVaaTQrze48U6ZDXe2MUaXgwqpyvNzIU7ZqAES82DYGFPjwG', 'user', NULL, NULL, 'Jl. Gajah Mada No. 23, Lumajang', NULL, NULL, 0, NULL, '2025-03-22 12:38:29', '2025-03-22 12:38:29', NULL, NULL),
(64, 'Siti Rohmah Wati', 'siti.rohmah1992@gmail.com', '$2y$12$YJOqo32H5d7bqJwRGOXUq.ujvSBevWLcv3CUZZANjX48c4DW57upW', 'user', NULL, NULL, 'Perumahan Sukodono Indah Blok C-5, Lumajang', NULL, NULL, 0, NULL, '2025-03-22 12:38:30', '2025-03-22 12:38:30', NULL, NULL),
(65, 'Budi Santoso', 'budi.s@gmail.com', '$2y$12$pmVVLjBW6DiezByofrqaSep.mMQD0eDBGRx8FXqs6JulJyNir3PaC', 'user', NULL, NULL, 'Dusun Krajan RT 03/RW 02, Tempeh', NULL, NULL, 0, NULL, '2025-03-22 12:38:30', '2025-03-22 12:38:30', NULL, NULL),
(66, 'Dewi Lestari', 'dewilestari_90@gmail.com', '$2y$12$fve.4MtoHioefOdjP7Ja7uuDZPNiLYVnPkvpJLnPBwGR/TIfrd5WK', 'user', NULL, NULL, 'Jl. Ahmad Yani Km 3, Pasirian', NULL, NULL, 0, NULL, '2025-03-22 12:38:30', '2025-03-22 12:38:30', NULL, NULL),
(67, 'Eko Prasetyo Nugroho', 'eko.pras78@gmail.com', '$2y$12$/2f2/2pH9B9T6R0CdhKI3ee9sDLOMo0GElQNb3WTRf8m0qn9HoDn6', 'user', NULL, NULL, 'Perum Griya Asri Blok D-12, Kunir', NULL, NULL, 0, NULL, '2025-03-22 12:38:30', '2025-03-22 12:38:30', NULL, NULL),
(68, 'Fitri Handayani', 'fitri.h@gmail.com', '$2y$12$a3dRIztCO8IUCu/Eni58aucpbD5hm5NgdxMvjfLDx67f/mJ7n/txK', 'user', NULL, NULL, 'Jl. Raya Randuagung No. 45, Randuagung', NULL, NULL, 0, NULL, '2025-03-22 12:38:31', '2025-03-22 12:38:31', NULL, NULL),
(69, 'Gunawan Saputra', 'gunawan_s@gmail.com', '$2y$12$QoGeMPuo0ASbJDA3Flx1VOnsWRfFYpGLmFW.wGY81ekFRWSK0yAPG', 'user', NULL, NULL, 'Desa Tunjung RT 05/RW 01, Yosowilangun', NULL, NULL, 0, NULL, '2025-03-22 12:38:31', '2025-03-22 12:38:31', NULL, NULL),
(70, 'Hesti Wahyuni Putri', 'hestiwahyuni1995@gmail.com', '$2y$12$FJz/kRAQAtpEw0OkHhc0Ze8hjiR.JrpyWmEULx/S9mjc5vQFed0IW', 'user', NULL, NULL, 'Jl. Pahlawan No. 17, Pasrujambe', NULL, NULL, 0, NULL, '2025-03-22 12:38:31', '2025-03-22 12:38:31', NULL, NULL),
(71, 'Indra Wijaya', 'indra.wijaya85@gmail.com', '$2y$12$lmtWSybdx55txoH4Es/G6ekY5FpTmI/mRmqkcaeB9cddzHLFHJGAS', 'user', NULL, NULL, 'Perumahan Senduro Asri Blok F-7, Senduro', NULL, NULL, 0, NULL, '2025-03-22 12:38:32', '2025-03-22 12:38:32', NULL, NULL),
(72, 'Joko Susilo', 'joko_s@gmail.com', '$2y$12$ic/vDWSadzoUG/oO1zv5zOFITSAomh.SPaYzN9oIx3U2jwgja/Zjm', 'user', NULL, NULL, 'Dusun Sumbersari RT 02/RW 03, Candipuro', NULL, NULL, 0, NULL, '2025-03-22 12:38:32', '2025-03-22 12:38:32', NULL, NULL),
(73, 'Kartika Dewi Anggraini', 'kartika.d@gmail.com', '$2y$12$KUB.H3MybGU3CZjyPNyHGeUhQFVWS4SPc1iwZ7j8quYYeSO5lh00y', 'user', NULL, NULL, 'Jl. Veteran No. 32, Tekung', NULL, NULL, 0, NULL, '2025-03-22 12:38:32', '2025-03-22 12:38:32', NULL, NULL),
(74, 'Lukman Hakim', 'lukman.h1989@gmail.com', '$2y$12$7hbYh.7suLfKFzN/crjmTukFVYndOAmuz4EwV8dOeQ.Fska1Q0A5m', 'user', NULL, NULL, 'Jl. Wijaya Kusuma Gang 3 No. 12, Padang', NULL, NULL, 0, NULL, '2025-03-22 12:38:33', '2025-03-22 12:38:33', NULL, NULL),
(75, 'Maria Ulfa Rahmawati', 'maria_ulfa@gmail.com', '$2y$12$T3XILRs1JYJV8hjRjN/RReZct78C9y7SSktXdDkxkYYg375x4wBDC', 'user', NULL, NULL, 'Perum Griya Sukodono Blok A-9, Sukodono', NULL, NULL, 0, NULL, '2025-03-22 12:38:33', '2025-03-22 12:38:33', NULL, NULL),
(76, 'Nugroho Prabowo', 'nugroho.p@gmail.com', '$2y$12$l5kv0wtopaau8GGhYLpdhumNla0T1Q9f2cWfPj6qn1.8xZ64X1sbu', 'user', NULL, NULL, 'Desa Wonorejo RT 04/RW 02, Gucialit', NULL, NULL, 0, NULL, '2025-03-22 12:38:33', '2025-03-22 12:38:33', NULL, NULL),
(77, 'Okta Sari', 'okta.sari93@gmail.com', '$2y$12$vyAFDhQYSyiUqd317462NuV3en3GwgEuG0PMo8JcfjmM9E.H7XZu6', 'user', NULL, NULL, 'Jl. Kenanga No. 7, Jatiroto', NULL, NULL, 0, NULL, '2025-03-22 12:38:34', '2025-03-22 12:38:34', NULL, NULL),
(78, 'Prasetya Adi Nugraha', 'prasetya_adi@gmail.com', '$2y$12$pMSP0yDHTCFBzW9Wvc9.IezG10OSCMUZAPiRITr8z3CJSizN70pfa', 'user', NULL, NULL, 'Dusun Karangsari RT 01/RW 04, Tempursari', NULL, NULL, 0, NULL, '2025-03-22 12:38:34', '2025-03-22 12:38:34', NULL, NULL),
(79, 'Qorina Setiawati', 'qorina.s@gmail.com', '$2y$12$WBr6FMZ2MrxmJyQx29Mdq.yenuIAygO8/LuxGVo1rIBXo99qDwbFW', 'user', NULL, NULL, 'Jl. Sumberwuluh Gang Mawar No. 3, Pronojiwo', NULL, NULL, 0, NULL, '2025-03-22 12:38:34', '2025-03-22 12:38:34', NULL, NULL),
(80, 'Rizky Ramadhan Saputra', 'rizky.r1994@gmail.com', '$2y$12$A.m9t5yQsZ2CRjjuZvilH.V5vrn6QAKxxvlmchqtpDa6XHmPl4zBS', 'user', NULL, NULL, 'Perum Griya Ranuyoso Blok B-15, Ranuyoso', NULL, NULL, 0, NULL, '2025-03-22 12:38:34', '2025-03-22 12:38:34', NULL, NULL),
(81, 'Sulastri Handayani', 'sulastri_h@gmail.com', '$2y$12$7OfZlYI0qLIl98Gy09P7wuyqnX4DSMNG1FkdUQ/nP09sqqeR.PaHm', 'user', NULL, NULL, 'Jl. Anggrek No. 21, Klakah', NULL, NULL, 0, NULL, '2025-03-22 12:38:35', '2025-03-22 12:38:35', NULL, NULL),
(82, 'Teguh Wicaksono', 'teguh.w88@gmail.com', '$2y$12$/n9NiA.FcErwEDRqSuaDHOsiBhq1swt6nkvg19moVYUOjOPs7jHdC', 'user', NULL, NULL, 'Desa Kalipepe RT 03/RW 01, Rowokangkung', NULL, NULL, 0, NULL, '2025-03-22 12:38:35', '2025-03-22 12:38:35', NULL, NULL),
(83, 'Umi Salamah Hidayati', 'umi.salamah91@gmail.com', '$2y$12$MeWxKli8ivw2IwvwOOC3UOdXRUktWo4VFGCccAXWAAVT6uSqTOtJC', 'user', NULL, NULL, 'Jl. Mawar No. 9, Kedungjajang', NULL, NULL, 0, NULL, '2025-03-22 12:38:35', '2025-03-22 12:38:35', NULL, NULL),
(84, 'Vina Melati', 'vina_melati@gmail.com', '$2y$12$h01xYZLDIKo6XLGxFMkrUOOZ4onUDBKBAlOXweUst7TAPFyoyIJBu', 'user', NULL, NULL, 'Perumahan Kunir Indah Blok G-3, Kunir', NULL, NULL, 0, NULL, '2025-03-22 12:38:35', '2025-03-22 12:38:35', NULL, NULL),
(85, 'Wahyudi Syahputra Pratama', 'wahyudi.s@gmail.com', '$2y$12$onEgGxXOhiUkggWtHTJa.eEMAQPeNlN2CgI7xDdxalFcKdptSDk2W', 'user', NULL, NULL, 'Jl. Duren No. 15, Lumajang', NULL, NULL, 0, NULL, '2025-03-22 12:38:36', '2025-03-22 12:38:36', NULL, NULL),
(86, 'Xaverius Angga', 'xave.angga90@gmail.com', '$2y$12$7.yTOi7jbeaI0ImJ0Guc6O9pE.5Am/cVDWLBASS0bxdJAdQ7BU3Re', 'user', NULL, NULL, 'Perum Tempeh Permai Blok C-8, Tempeh', NULL, NULL, 0, NULL, '2025-03-22 12:38:36', '2025-03-22 12:38:36', NULL, NULL),
(87, 'Alzando Arya', 'buatgame10052004@gmail.com', '$2y$12$i7LY27dy2Wj9YP9.wD2lZ.mlFZQ5SqHjGaEN17mFex1waQRbD.T1S', 'user', NULL, NULL, 'Lumajang', NULL, NULL, 1, NULL, '2025-05-15 02:17:11', '2025-05-15 15:23:28', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jenis_bencana`
--
ALTER TABLE `jenis_bencana`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `laporan_bencana`
--
ALTER TABLE `laporan_bencana`
  ADD PRIMARY KEY (`id`),
  ADD KEY `laporan_bencana_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `laporan_jalan`
--
ALTER TABLE `laporan_jalan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `laporan_jalan_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jenis_bencana`
--
ALTER TABLE `jenis_bencana`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT untuk tabel `laporan_bencana`
--
ALTER TABLE `laporan_bencana`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `laporan_jalan`
--
ALTER TABLE `laporan_jalan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `laporan_bencana`
--
ALTER TABLE `laporan_bencana`
  ADD CONSTRAINT `laporan_bencana_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `laporan_jalan`
--
ALTER TABLE `laporan_jalan`
  ADD CONSTRAINT `laporan_jalan_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

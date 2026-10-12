-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2024 at 08:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `workouts_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `abs`
--

CREATE TABLE `abs` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `repetitions` varchar(255) NOT NULL,
  `instructions` text NOT NULL,
  `level` enum('Beginner','Intermediate','Advanced') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `abs`
--

INSERT INTO `abs` (`id`, `exercise_name`, `target`, `repetitions`, `instructions`, `level`) VALUES
(1, 'Crunches', 'Abs', '3 set x 15-20 repetisi', 'Berbaring di lantai dengan lutut ditekuk. Letakkan tangan di belakang kepala. Angkat tubuh bagian atas menuju lutut, lalu kembali ke posisi awal.', 'Beginner'),
(2, 'Leg Raises', 'Lower Abs', '3 set x 10-15 repetisi', 'Berbaring di lantai dengan kaki lurus. Angkat kaki ke atas hingga membentuk sudut 90 derajat dengan tubuh, lalu turunkan kembali tanpa menyentuh lantai.', 'Beginner'),
(3, 'Plank', 'Core', '3 set x 20-30 detik', 'Posisikan tubuh seperti push-up tetapi dengan lengan bawah menyentuh lantai. Tahan posisi ini selama yang diinstruksikan.', 'Beginner'),
(4, 'Bicycle Crunches', 'Abs, Obliques', '3 set x 15-20 repetisi per sisi', 'Berbaring di lantai dengan tangan di belakang kepala dan kaki diangkat. Lakukan gerakan mengayuh dengan kaki dan sentuhkan siku kiri ke lutut kanan secara bergantian.', 'Intermediate'),
(5, 'Hanging Leg Raises', 'Lower Abs', '3 set x 10-15 repetisi', 'Gantungkan tubuh pada pull-up bar dengan tangan selebar bahu. Angkat kaki lurus ke atas hingga sejajar dengan pinggang, lalu turunkan kembali.', 'Intermediate'),
(6, 'Russian Twists', 'Obliques', '3 set x 20-30 repetisi per sisi', 'Duduk di lantai dengan lutut ditekuk dan kaki sedikit terangkat. Pegang tangan bersama-sama di depan dada, lalu putar tubuh ke kanan dan kiri.', 'Intermediate'),
(7, 'Flutter Kicks', 'Lower Abs', '3 set x 20-30 repetisi per sisi', 'Berbaring di lantai dengan tangan di bawah pinggul. Angkat kaki sedikit dari lantai dan lakukan gerakan naik-turun cepat dengan kaki secara bergantian.', 'Intermediate'),
(8, 'V-Ups', 'Abs', '3 set x 10-15 repetisi', 'Berbaring di lantai dengan tangan dan kaki lurus. Angkat tubuh bagian atas dan kaki secara bersamaan hingga tangan menyentuh kaki, lalu kembali ke posisi awal.', 'Intermediate'),
(9, 'Dragon Flags', 'Abs, Core', '3 set x 5-10 repetisi', 'Berbaring di bangku dengan tangan memegang tepi bangku di belakang kepala. Angkat tubuh dan kaki lurus ke atas hingga hanya bagian atas punggung yang menyentuh bangku, lalu turunkan secara perlahan tanpa menyentuh bangku.', 'Advanced'),
(10, 'Windshield Wipers', 'Abs, Obliques', '3 set x 10-15 repetisi per sisi', 'Gantungkan tubuh pada pull-up bar dengan tangan selebar bahu. Angkat kaki lurus ke atas dan gerakkan ke samping kanan dan kiri seperti wiper kaca mobil.', 'Advanced'),
(11, 'Ab Rollouts', 'Abs, Core', '3 set x 10-15 repetisi', 'Posisikan tubuh seperti plank dengan tangan memegang ab roller. Gulung roller ke depan hingga tubuh hampir menyentuh lantai, lalu tarik kembali ke posisi awal.', 'Advanced'),
(12, 'Hanging Leg Circles', 'Abs, Obliques', '3 set x 10-15 repetisi per arah', 'Gantungkan tubuh pada pull-up bar dengan tangan selebar bahu. Angkat kaki lurus ke atas dan buat gerakan melingkar dengan kaki.', 'Advanced'),
(13, 'Toe Touches', 'Upper Abs', '3 set x 15-20 repetisi', 'Berbaring di lantai dengan kaki diangkat lurus ke atas. Sentuhkan tangan ke ujung jari kaki dengan mengangkat tubuh bagian atas, lalu kembali ke posisi awal.', 'Advanced'),
(14, 'Single-Arm Plank', 'Core', '3 set x 20-30 detik per sisi', 'Posisikan tubuh seperti plank tetapi dengan satu tangan diangkat dari lantai. Tahan posisi ini selama yang diinstruksikan, lalu ganti sisi.', 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `cardio`
--

CREATE TABLE `cardio` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `instructions` text NOT NULL,
  `level` enum('Beginner','Intermediate','Advanced') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cardio`
--

INSERT INTO `cardio` (`id`, `exercise_name`, `target`, `duration`, `instructions`, `level`) VALUES
(1, 'Brisk Walking', 'Cardio', '30 menit', 'Berjalan dengan kecepatan yang cepat untuk meningkatkan denyut jantung dan pernapasan Anda.', 'Beginner'),
(2, 'Jumping Jacks', 'Cardio', '3 set x 30 detik', 'Lakukan jumping jacks secara kontinu selama 30 detik per set.', 'Beginner'),
(3, 'Stationary Cycling', 'Cardio', '20 menit', 'Bersepeda di sepeda statis dengan kecepatan sedang selama 20 menit.', 'Beginner'),
(4, 'Running', 'Cardio', '3-5 km', 'Lari di luar ruangan atau di treadmill, dengan tujuan jarak 3-5 kilometer.', 'Intermediate'),
(5, 'Skipping Rope', 'Cardio', '3 set x 1 menit', 'Lompat tali secara kontinu selama 1 menit per set.', 'Intermediate'),
(6, 'High-Intensity Interval Training (HIIT)', 'Cardio', '20 menit', 'Lakukan latihan HIIT dengan menggabungkan antara burst intensitas tinggi dan periode istirahat.', 'Intermediate'),
(7, 'Sprint', 'Cardio', '8 set x 100 meter', 'Lakukan sprint interval 100 meter setiap kali, dengan istirahat di antara set.', 'Advanced'),
(8, 'Circuit Training', 'Cardio', '30 menit', 'Ikuti latihan sirkuit yang menggabungkan berbagai latihan dengan istirahat minimal.', 'Advanced'),
(9, 'Dance Aerobics', 'Cardio', '30 menit', 'Ikuti sesi dance aerobik yang menggabungkan gerakan intensitas tinggi dan rendah.', 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `chest_arms`
--

CREATE TABLE `chest_arms` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `repetitions` varchar(255) NOT NULL,
  `instructions` text NOT NULL,
  `level` enum('Beginner','Intermediate','Advanced') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chest_arms`
--

INSERT INTO `chest_arms` (`id`, `exercise_name`, `target`, `repetitions`, `instructions`, `level`) VALUES
(1, 'Knee Push-Ups', 'Dada, Trisep, Bahu', '3 set x 8-12 repetisi', 'Mulai dari posisi push-up dengan lutut di lantai. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Beginner'),
(2, 'Tricep Dips', 'Trisep', '3 set x 8-10 repetisi', 'Gunakan kursi atau bangku. Letakkan tangan di tepi kursi dengan jari menghadap ke depan, kaki ditekuk atau lurus di depan. Turunkan tubuh hingga siku membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal.', 'Beginner'),
(3, 'Incline Push-Ups', 'Dada, Trisep', '3 set x 8-12 repetisi', 'Letakkan tangan di permukaan yang lebih tinggi seperti meja atau kursi. Turunkan tubuh hingga dada hampir menyentuh permukaan, lalu dorong kembali ke posisi awal.', 'Beginner'),
(4, 'Standard Push-Ups', 'Dada, Trisep, Bahu', '3 set x 12-15 repetisi', 'Posisikan tangan sedikit lebih lebar dari bahu. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(5, 'Tricep Dips', 'Trisep', '3 set x 10-15 repetisi', 'Gunakan kursi atau bangku. Letakkan tangan di tepi kursi dengan jari menghadap ke depan, kaki ditekuk atau lurus di depan. Turunkan tubuh hingga siku membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(6, 'Diamond Push-Ups', 'Dada bagian dalam, Trisep', '3 set x 10-12 repetisi', 'Posisikan tangan membentuk segitiga di bawah dada. Turunkan tubuh hingga dada hampir menyentuh tangan, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(7, 'Pike Push-Ups', 'Bahu, Trisep', '3 set x 10-12 repetisi', 'Mulai dalam posisi push-up dengan pinggul diangkat ke atas membentuk segitiga dengan tubuh. Turunkan kepala ke arah lantai di antara tangan, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(8, 'Decline Push-Ups', 'Dada bagian atas, Trisep', '3 set x 10-12 repetisi', 'Letakkan kaki di permukaan yang lebih tinggi seperti kursi atau bangku. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(9, 'Diamond Push-Ups', 'Dada bagian dalam, Trisep', '3 set x 12-15 repetisi', 'Posisikan tangan membentuk segitiga di bawah dada. Turunkan tubuh hingga dada hampir menyentuh tangan, lalu dorong kembali ke posisi awal.', 'Advanced'),
(10, 'Decline Push-Ups', 'Dada bagian atas, Trisep', '3 set x 12-15 repetisi', 'Letakkan kaki di permukaan yang lebih tinggi seperti kursi atau bangku. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Advanced'),
(11, 'Archer Push-Ups', 'Dada, Trisep, Bahu', '3 set x 8-10 repetisi tiap sisi', 'Posisi push-up dengan tangan lebih lebar dari bahu. Turunkan tubuh ke satu sisi sambil menjaga lengan yang lain tetap lurus, lalu dorong kembali ke posisi awal dan ulangi di sisi lain.', 'Advanced'),
(12, 'Explosive Push-Ups', 'Dada, Trisep, Bahu', '3 set x 10-12 repetisi', 'Lakukan push-up dengan dorongan kuat sehingga tangan terangkat dari lantai. Jika memungkinkan, tambahkan tepukan di udara sebelum mendarat kembali.', 'Advanced'),
(13, 'Tricep Dips', 'Trisep', '3 set x 15-20 repetisi', 'Gunakan kursi atau bangku. Letakkan tangan di tepi kursi dengan jari menghadap ke depan, kaki ditekuk atau lurus di depan. Turunkan tubuh hingga siku membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal.', 'Advanced'),
(14, 'Pike Push-Ups', 'Bahu, Trisep', '3 set x 12-15 repetisi', 'Mulai dalam posisi push-up dengan pinggul diangkat ke atas membentuk segitiga dengan tubuh. Turunkan kepala ke arah lantai di antara tangan, lalu dorong kembali ke posisi awal.', 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `full_body`
--

CREATE TABLE `full_body` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `repetitions` varchar(255) NOT NULL,
  `instructions` text NOT NULL,
  `level` enum('Beginner','Intermediate','Advanced') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `full_body`
--

INSERT INTO `full_body` (`id`, `exercise_name`, `target`, `repetitions`, `instructions`, `level`) VALUES
(1, 'Push-Ups', 'Dada, Trisep, Bahu', '3 set x 10-12 repetisi', 'Posisikan tangan sedikit lebih lebar dari bahu. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Beginner'),
(2, 'Bodyweight Squats', 'Quads, Glutes, Hamstrings', '3 set x 15-20 repetisi', 'Berdiri dengan kaki selebar bahu. Turunkan tubuh seperti duduk di kursi hingga paha sejajar dengan lantai, lalu kembali ke posisi awal.', 'Beginner'),
(3, 'Plank', 'Core', '3 set x 30-45 detik', 'Berbaring tengkurap dengan lengan ditekuk dan tumpu pada siku. Angkat tubuh hingga membentuk garis lurus dari kepala hingga kaki, tahan posisi ini.', 'Beginner'),
(4, 'Standard Push-Ups', 'Dada, Trisep, Bahu', '3 set x 12-15 repetisi', 'Posisikan tangan sedikit lebih lebar dari bahu. Turunkan tubuh hingga dada hampir menyentuh lantai, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(5, 'Squats', 'Quads, Glutes, Hamstrings', '3 set x 12-15 repetisi', 'Berdiri dengan kaki selebar bahu. Turunkan tubuh seperti duduk di kursi hingga paha sejajar dengan lantai, lalu kembali ke posisi awal.', 'Intermediate'),
(6, 'Russian Twists', 'Core, Obliques', '3 set x 15-20 repetisi', 'Duduk dengan lutut ditekuk dan tumit diangkat. Pegang tangan di depan dada dan putar tubuh ke kanan dan kiri secara bergantian.', 'Intermediate'),
(7, 'Bicycle Crunches', 'Core, Obliques', '3 set x 15-20 repetisi', 'Berbaring telentang dengan tangan di belakang kepala. Tekuk lutut dan angkat kaki. Lakukan gerakan seolah-olah mengendarai sepeda dengan membawa siku ke arah lutut yang berlawanan.', 'Intermediate'),
(8, 'Reverse Lunges', 'Quads, Glutes, Hamstrings', '3 set x 12-15 repetisi tiap sisi', 'Berdiri tegak dengan kaki selebar pinggul. Langkah mundur satu kaki dan turunkan tubuh hingga lutut membentuk sudut 90 derajat. Kembali ke posisi awal dan ulangi dengan kaki lain.', 'Intermediate'),
(9, 'Clap Push-Ups', 'Dada, Trisep, Bahu', '3 set x 8-10 repetisi', 'Lakukan push-up dengan dorongan kuat sehingga tangan terangkat dari lantai. Jika memungkinkan, tambahkan tepukan di udara sebelum mendarat kembali.', 'Advanced'),
(10, 'Pistol Squats', 'Quads, Glutes, Hamstrings', '3 set x 8-10 repetisi per kaki', 'Berdiri dengan satu kaki diangkat lurus di depan. Turunkan tubuh dengan kaki lainnya hingga paha sejajar dengan lantai, lalu dorong kembali ke posisi awal.', 'Advanced'),
(11, 'Plank with Leg Lifts', 'Core, Glutes', '3 set x 12-15 repetisi per sisi', 'Mulai dari posisi plank. Angkat satu kaki ke atas secara bergantian, menjaga tubuh tetap stabil.', 'Advanced'),
(12, 'Dragon Flags', 'Core, Hip Flexors', '3 set x 5-8 repetisi', 'Berbaring telentang di atas bangku atau kursi. Angkat tubuh dengan tangan memegang tepi tempat duduk. Turunkan tubuh secara perlahan hingga kaki hampir menyentuh lantai, lalu angkat kembali ke posisi awal.', 'Advanced');

-- --------------------------------------------------------

--
-- Table structure for table `legs`
--

CREATE TABLE `legs` (
  `id` int(11) NOT NULL,
  `exercise_name` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `repetitions` varchar(255) NOT NULL,
  `instructions` text NOT NULL,
  `level` enum('Beginner','Intermediate','Advanced') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `legs`
--

INSERT INTO `legs` (`id`, `exercise_name`, `target`, `repetitions`, `instructions`, `level`) VALUES
(1, 'Bodyweight Squats', 'Quads, Glutes, Hamstrings', '3 set x 15-20 repetisi', 'Berdiri dengan kaki selebar bahu. Turunkan tubuh seperti duduk di kursi hingga paha sejajar dengan lantai, lalu kembali ke posisi awal.', 'Beginner'),
(2, 'Lunges', 'Quads, Glutes, Hamstrings', '3 set x 10-12 repetisi per kaki', 'Berdiri dengan kaki selebar pinggul. Langkahkan satu kaki ke depan dan turunkan tubuh hingga lutut depan membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal dan ulangi dengan kaki lainnya.', 'Beginner'),
(3, 'Glute Bridges', 'Glutes, Hamstrings', '3 set x 15-20 repetisi', 'Berbaring di lantai dengan lutut ditekuk dan kaki rata di lantai. Angkat pinggul ke atas hingga tubuh membentuk garis lurus dari lutut ke bahu, lalu turunkan kembali.', 'Beginner'),
(4, 'Bulgarian Split Squats', 'Quads, Glutes, Hamstrings', '3 set x 10-12 repetisi per kaki', 'Berdiri dengan satu kaki di depan dan kaki lainnya di atas bangku di belakang. Turunkan tubuh hingga lutut depan membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal.', 'Intermediate'),
(5, 'Step-Ups', 'Quads, Glutes', '3 set x 15-20 repetisi per kaki', 'Berdiri di depan bangku atau kotak. Langkahkan satu kaki ke atas bangku, dorong tubuh ke atas hingga kaki lurus, lalu kembali ke posisi awal dan ulangi dengan kaki lainnya.', 'Intermediate'),
(6, 'Calf Raises', 'Calves', '3 set x 15-20 repetisi', 'Berdiri dengan kaki selebar bahu. Angkat tumit hingga berdiri di atas ujung kaki, lalu turunkan kembali.', 'Intermediate'),
(7, 'Single-Leg Deadlifts', 'Hamstrings, Glutes, Lower Back', '3 set x 10-12 repetisi per kaki', 'Berdiri dengan satu kaki diangkat sedikit dari lantai. Turunkan tubuh ke depan dengan punggung lurus sambil mengangkat kaki belakang hingga sejajar dengan lantai, lalu kembali ke posisi awal.', 'Intermediate'),
(8, 'Jump Squats', 'Quads, Glutes, Calves', '3 set x 10-15 repetisi', 'Berdiri dengan kaki selebar bahu. Turunkan tubuh seperti squat, lalu dorong dengan kuat untuk melompat setinggi mungkin dan mendarat dengan lembut kembali ke posisi squat.', 'Intermediate'),
(9, 'Pistol Squats', 'Quads, Glutes, Hamstrings', '3 set x 8-10 repetisi per kaki', 'Berdiri dengan satu kaki diangkat lurus di depan. Turunkan tubuh dengan kaki lainnya hingga paha sejajar dengan lantai, lalu dorong kembali ke posisi awal.', 'Advanced'),
(10, 'Box Jumps', 'Quads, Glutes, Calves', '3 set x 10-12 repetisi', 'Berdiri di depan kotak atau bangku. Lompat ke atas kotak dengan kedua kaki, lalu mendarat dengan lembut dan kembali ke posisi awal.', 'Advanced'),
(11, 'Walking Lunges', 'Quads, Glutes, Hamstrings', '3 set x 20-30 repetisi per kaki', 'Langkahkan satu kaki ke depan dan turunkan tubuh hingga lutut depan membentuk sudut 90 derajat, lalu dorong tubuh ke depan untuk langkah berikutnya dan ulangi dengan kaki lainnya.', 'Advanced'),
(12, 'Single-Leg Box Squats', 'Quads, Glutes, Hamstrings', '3 set x 10-12 repetisi per kaki', 'Berdiri di depan bangku dengan satu kaki diangkat. Turunkan tubuh hingga duduk di bangku dengan kaki lainnya, lalu dorong kembali ke posisi awal.', 'Advanced'),
(13, 'Lateral Lunges', 'Quads, Glutes, Inner Thighs', '3 set x 10-15 repetisi per kaki', 'Berdiri dengan kaki selebar bahu. Langkahkan satu kaki ke samping dan turunkan tubuh hingga lutut membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal dan ulangi dengan kaki lainnya.', 'Advanced'),
(14, 'Broad Jumps', 'Quads, Glutes, Hamstrings, Calves', '3 set x 10-12 repetisi', 'Berdiri dengan kaki selebar bahu. Lompat sejauh mungkin ke depan dengan kedua kaki, mendarat dengan lutut sedikit ditekuk dan segera lanjutkan dengan lompatan berikutnya.', 'Advanced');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `abs`
--
ALTER TABLE `abs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cardio`
--
ALTER TABLE `cardio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chest_arms`
--
ALTER TABLE `chest_arms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `full_body`
--
ALTER TABLE `full_body`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `legs`
--
ALTER TABLE `legs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `abs`
--
ALTER TABLE `abs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cardio`
--
ALTER TABLE `cardio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `chest_arms`
--
ALTER TABLE `chest_arms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `full_body`
--
ALTER TABLE `full_body`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `legs`
--
ALTER TABLE `legs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

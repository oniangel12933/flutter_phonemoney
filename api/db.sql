-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 26, 2020 at 09:50 AM
-- Server version: 10.2.30-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `devmyweb_phonemoney`
--

-- --------------------------------------------------------

--
-- Table structure for table `contributes`
--

CREATE TABLE `contributes` (
  `contribute_id` int(10) NOT NULL,
  `created_group_id` varchar(10) NOT NULL,
  `created_user_id` varchar(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(300) NOT NULL,
  `target_amount` varchar(20) NOT NULL,
  `current_amount` varchar(20) NOT NULL DEFAULT '0',
  `created_time` varchar(50) NOT NULL,
  `end_time` varchar(50) NOT NULL,
  `beneficiary_phone` varchar(20) NOT NULL,
  `beneficiary_name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `donates`
--

CREATE TABLE `donates` (
  `donate_id` int(10) NOT NULL,
  `contribute_id` varchar(10) NOT NULL,
  `donated_user_id` varchar(10) NOT NULL,
  `donated_member_name` varchar(50) NOT NULL,
  `donated_member_phone` varchar(50) NOT NULL,
  `donated_amount` varchar(10) NOT NULL,
  `donated_time` varchar(10) NOT NULL,
  `end_status` varchar(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_id` int(10) NOT NULL,
  `created_user_id` varchar(20) NOT NULL,
  `title` varchar(20) NOT NULL,
  `description` varchar(300) NOT NULL,
  `created_time` varchar(50) NOT NULL,
  `number_of_members` varchar(10) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` int(10) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `member_user_id` varchar(10) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `joined_time` varchar(50) NOT NULL,
  `owner_status` varchar(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(10) NOT NULL,
  `sender_id` varchar(10) NOT NULL,
  `sender_name` varchar(50) NOT NULL,
  `receiver_id` varchar(10) NOT NULL,
  `type` varchar(5) NOT NULL,
  `optional_val` varchar(100) NOT NULL,
  `created_time` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `main_phone` varchar(20) NOT NULL,
  `other_phones` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `isOnLine` varchar(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contributes`
--
ALTER TABLE `contributes`
  ADD PRIMARY KEY (`contribute_id`);

--
-- Indexes for table `donates`
--
ALTER TABLE `donates`
  ADD PRIMARY KEY (`donate_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contributes`
--
ALTER TABLE `contributes`
  MODIFY `contribute_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donates`
--
ALTER TABLE `donates`
  MODIFY `donate_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

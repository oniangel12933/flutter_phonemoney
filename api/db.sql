-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 23, 2020 at 04:55 PM
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
-- Table structure for table `contribute`
--

CREATE TABLE `contributes` (
  `contribute_id` int(10) DEFAULT NULL,
  `created_group_id` varchar(10) NOT NULL,
  `created_user_id` varchar(10) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL,
  `target_amount` varchar(10) NOT NULL,
  `current_amount` varchar(10) NOT NULL,
  `created_time` varchar(50) NOT NULL,
  `end_time` varchar(50) NOT NULL,
  `beneficiary_name` varchar(50) NOT NULL,
  `beneficiary_phone` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `donate`
--

CREATE TABLE `donates` (
  `donate_id` int(10) NOT NULL,
  `contribute_id` varchar(10) NOT NULL,
  `donated_user_id` varchar(10) NOT NULL,
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
  `created_time` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`group_id`, `created_user_id`, `title`, `description`, `created_time`) VALUES
(1, '122454523', '', '', '2020-03-25-17-25'),
(2, '122454523', '', '', '2020-03-25-17-25'),
(3, '122454523', 'oni`s group 1', 'This is oni`s first group', '2020-03-25-17-25'),
(4, '122454523', 'oni`s group 1', 'This is oni`s first group', '2020-03-25-17-25');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `members` (
  `member_id` int(10) NOT NULL,
  `group_id` varchar(10) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `joined_time` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `members` (`member_id`, `group_id`, `phone_number`, `joined_time`) VALUES
(1, '1', '313241324', '2020-03-25-17-25'),
(2, '1', '313241324', '2020-03-25-17-25'),
(3, '1', '313241324', '2020-03-25-17-25'),
(4, '1', '313241324', '2020-03-25-17-25'),
(5, '1', '313241324', '2020-03-25-17-25'),
(6, '1', '313241324', '2020-03-25-17-25'),
(7, '1', '313241324', '2020-03-25-17-25'),
(8, '1', '313241324', '2020-03-25-17-25'),
(9, '1', '313241324', '2020-03-25-17-25'),
(10, '1', '313241324', '2020-03-25-17-25');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `reports` (
  `report_id` int(10) NOT NULL,
  `sender_id` varchar(10) NOT NULL,
  `receiver_id` varchar(10) NOT NULL,
  `type` varchar(5) NOT NULL,
  `optional_val` varchar(100) NOT NULL,
  `created_time` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `main_phone` varchar(20) NOT NULL,
  `other_phone` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `isOnLine` varchar(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `users` (`id`, `name`, `main_phone`, `other_phone`, `password`, `isOnLine`) VALUES
(1, 'oni', '341234312', '', '341234312', '1'),
(2, 'oni', '3412343121', '', 'qwert', '1'),
(3, 'oni', '1', '', 'qwert', '1'),
(4, 'oni', '2', '', 'qwert', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `donate`
--
ALTER TABLE `donates`
  ADD PRIMARY KEY (`donate_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `donate`
--
ALTER TABLE `donates`
  MODIFY `donate_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `members`
  MODIFY `member_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

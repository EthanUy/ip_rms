-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2018 at 09:28 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ip_rms`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `name` varchar(42) NOT NULL,
  `bday` date NOT NULL,
  `hiredDate` date NOT NULL,
  `contact` varchar(15) NOT NULL,
  `email` varchar(42) NOT NULL,
  `status` enum('Hired','Fired','Vacation','') NOT NULL,
  `isJoined` tinyint(1) NOT NULL,
  `password` varchar(16) NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `name`, `bday`, `hiredDate`, `contact`, `email`, `status`, `isJoined`, `password`, `role`) VALUES
(9, 'Ethan', '2018-12-12', '2018-12-12', '09336608506', 'ethanlyleuy@gmail.com', 'Hired', 1, '1234', 'Manager'),
(10, 'Logan', '2018-12-16', '2018-12-16', '1234', 'chlogan@gmail.com', 'Hired', 1, '1234', 'Office'),
(12, 'Shanna', '2018-12-18', '2018-12-18', '234234', 'shana@gmail.com', 'Hired', 0, '1234', 'Manager'),
(13, 'Shanna Ong', '2018-12-18', '2018-12-18', '1232', 'Admin@tuf.com', 'Hired', 0, '1234', 'Field');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `status` enum('Pending','OnGoing','Completed','Cancelled') NOT NULL,
  `manager_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `status`, `manager_id`, `name`) VALUES
(1, 'Cancelled', 9, 'Shanna'),
(4, 'Pending', 9, 'ff'),
(5, 'Pending', 9, 'Shanna');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role`) VALUES
('Field'),
('Manager'),
('Office');

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `status` enum('Pending','OnGoing','Completed','Cancelled') NOT NULL,
  `task` varchar(1024) NOT NULL,
  `project_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`id`, `status`, `task`, `project_id`, `employee_id`) VALUES
(1, 'Cancelled', 'Get a burger', 5, 10),
(2, 'Cancelled', 'test', 1, 9),
(6, 'Cancelled', 'test task', 1, 9),
(7, 'Cancelled', 'test task', 1, 9),
(8, 'Cancelled', '122', 1, 9),
(9, 'Cancelled', 'test task', 1, 9),
(10, 'Pending', 'test task', 1, 9),
(11, 'Cancelled', 'Logan', 1, 10),
(12, 'Cancelled', 'Test', 1, 10),
(13, 'Cancelled', 'server', 1, 9),
(14, 'Cancelled', 'server', 1, 10),
(15, 'Cancelled', 'server', 1, 10),
(16, 'Cancelled', 'aaaaaaaaaa', 1, 10),
(17, 'Cancelled', 'bbbbb', 1, 10),
(18, 'Completed', 'ccc', 1, 10),
(19, 'Completed', 'ddd', 1, 10),
(20, 'Completed', '1111', 1, 10),
(21, 'Completed', '2222', 1, 10),
(22, 'Completed', '3333', 1, 10),
(23, 'Completed', '444', 1, 10),
(24, 'Completed', '5555', 1, 10),
(25, 'Completed', '666', 1, 10),
(26, 'Completed', '1234', 1, 10),
(27, 'Completed', '2345', 1, 10),
(28, 'Completed', '3456', 1, 10),
(29, 'Completed', '4567', 1, 10),
(30, 'Completed', '111111', 1, 10),
(31, 'Completed', '222222222222', 1, 10),
(32, 'Completed', '33333333333333', 1, 10),
(33, 'Completed', '44444444444444', 1, 10),
(34, 'Completed', '555555', 1, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `e_role` (`role`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pm_id` (`manager_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tp_id` (`project_id`),
  ADD KEY `te_id` (`employee_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `e_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `pm_id` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`id`);

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `te_id` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `tp_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

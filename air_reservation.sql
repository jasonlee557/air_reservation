-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 26, 2025 at 01:22 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `air_reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent_airline_authorization`
--

CREATE TABLE `agent_airline_authorization` (
  `agent_email` varchar(50) NOT NULL,
  `airline_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `agent_airline_authorization`
--

INSERT INTO `agent_airline_authorization` (`agent_email`, `airline_name`) VALUES
('agent_global@agency.com', 'Alaska Airlines'),
('agent_global@agency.com', 'American Airlines'),
('agent_nyu@agency.com', 'Delta Air Lines'),
('agent_nyu@agency.com', 'United Airlines'),
('agent_premium@agency.com', 'All Nippon Airways'),
('agent_premium@agency.com', 'China Eastern Airlines');

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `airline_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `airline`
--

INSERT INTO `airline` (`airline_name`) VALUES
('Alaska Airlines'),
('All Nippon Airways'),
('American Airlines'),
('China Eastern Airlines'),
('Delta Air Lines'),
('United Airlines');

-- --------------------------------------------------------

--
-- Table structure for table `airline_staff`
--

CREATE TABLE `airline_staff` (
  `username` varchar(50) NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `airline_name` varchar(50) NOT NULL,
  `role` enum('admin','operator','both') DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `airline_staff`
--

INSERT INTO `airline_staff` (`username`, `password`, `first_name`, `last_name`, `date_of_birth`, `airline_name`, `role`) VALUES
('aa_admin', '$2b$12$3FIAwqNMqGFENWIkVCHFtuTg1i2hB4n.6OdCo/QySJi6VmJH7QBO.', 'James', 'Wilson', '1982-03-18', 'American Airlines', 'admin'),
('cea_ops', 'staffpass5', 'Li', 'Wei', '1979-09-09', 'China Eastern Airlines', 'operator'),
('delta_admin', 'staffpass1', 'Megan', 'Green', '1980-02-10', 'Delta Air Lines', 'admin'),
('delta_ops', 'staffpass2', 'Luke', 'Miller', '1985-07-22', 'Delta Air Lines', 'operator'),
('united_both', 'staffpass3', 'Sophia', 'Lopez', '1978-11-05', 'United Airlines', 'both');

-- --------------------------------------------------------

--
-- Table structure for table `airplane`
--

CREATE TABLE `airplane` (
  `airline_name` varchar(50) NOT NULL,
  `airplane_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `airplane`
--

INSERT INTO `airplane` (`airline_name`, `airplane_id`) VALUES
('Alaska Airlines', 1),
('Alaska Airlines', 2),
('All Nippon Airways', 1),
('American Airlines', 1),
('American Airlines', 2),
('China Eastern Airlines', 1),
('Delta Air Lines', 1),
('Delta Air Lines', 2),
('United Airlines', 1),
('United Airlines', 2);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `airport_name` varchar(50) NOT NULL,
  `airport_city` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`airport_name`, `airport_city`) VALUES
('ATL', 'Atlanta'),
('DFW', 'Dallas'),
('HND', 'Tokyo'),
('JFK', 'New York'),
('LAX', 'Los Angeles'),
('LHR', 'London'),
('ORD', 'Chicago'),
('PEK', 'Beijing'),
('PVG', 'Shanghai'),
('SEA', 'Seattle'),
('SFO', 'San Francisco'),
('SIN', 'Singapore');

-- --------------------------------------------------------

--
-- Table structure for table `booking_agent`
--

CREATE TABLE `booking_agent` (
  `email` varchar(50) NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `booking_agent`
--

INSERT INTO `booking_agent` (`email`, `password`) VALUES
('agent_global@agency.com', '$2b$12$cAH2VNH7/crlBNnCCZuCNen8tKX/SUNYud8CQYY5UHERVLN1NKIvi'),
('agent_nyu@agency.com', '$2b$12$3FIAwqNMqGFENWIkVCHFtuTg1i2hB4n.6OdCo/QySJi6VmJH7QBO.'),
('agent_premium@agency.com', 'agentpass3');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `building_number` varchar(30) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `passport_number` varchar(30) NOT NULL,
  `passport_expiration` date NOT NULL,
  `passport_country` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`email`, `name`, `password`, `building_number`, `street`, `city`, `state`, `phone_number`, `passport_number`, `passport_expiration`, `passport_country`, `date_of_birth`) VALUES
('123@456.com', 'lucas', '$2b$12$3FIAwqNMqGFENWIkVCHFtuTg1i2hB4n.6OdCo/QySJi6VmJH7QBO.', '0', '', '', '', '', '', '2030-01-01', '', '2000-01-01'),
('1@2.com', '123', '$2b$12$cAH2VNH7/crlBNnCCZuCNen8tKX/SUNYud8CQYY5UHERVLN1NKIvi', '0', '', '', '', '', '', '2030-01-01', '', '2000-01-01'),
('alice@example.com', 'Alice Johnson', '$2b$12$3FIAwqNMqGFENWIkVCHFtuTg1i2hB4n.6OdCo/QySJi6VmJH7QBO.', '101', 'Main St', 'New York', 'NY', '212-555-0101', 'US1234567', '2030-05-01', 'USA', '1990-04-15'),
('bob@example.com', 'Bob Smith', '$2b$12$3FIAwqNMqGFENWIkVCHFtuTg1i2hB4n.6OdCo/QySJi6VmJH7QBO.', '202', 'Oak Ave', 'Los Angeles', 'CA', '310-555-0202', 'US2345678', '2029-10-01', 'USA', '1988-09-20'),
('carol@example.com', 'Carol Lee', '$2b$12$cAH2VNH7/crlBNnCCZuCNen8tKX/SUNYud8CQYY5UHERVLN1NKIvi', '303', 'Pine Rd', 'Seattle', 'WA', '206-555-0303', 'US3456789', '2031-01-15', 'USA', '1995-12-05'),
('david@example.com', 'David Wang', 'davidpass', '404', 'Nanjing Rd', 'Shanghai', 'Shanghai', '21-555-0404', 'CN4567890', '2032-07-20', 'China', '1993-03-10'),
('emma@example.com', 'Emma Brown', 'emmapass', '505', 'Market St', 'San Francisco', 'CA', '415-555-0505', 'US5678901', '2030-12-31', 'USA', '1998-06-25');

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `airline_name` varchar(50) NOT NULL,
  `flight_num` int(11) NOT NULL,
  `departure_airport` varchar(50) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_airport` varchar(50) NOT NULL,
  `arrival_time` datetime NOT NULL,
  `base_price` decimal(10,0) DEFAULT NULL,
  `status` enum('upcoming','in-progress','delayed') DEFAULT 'upcoming',
  `airplane_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`airline_name`, `flight_num`, `departure_airport`, `departure_time`, `arrival_airport`, `arrival_time`, `base_price`, `status`, `airplane_id`) VALUES
('Alaska Airlines', 4001, 'SEA', '2025-01-05 10:00:00', 'SFO', '2025-01-05 12:00:00', 180, 'upcoming', 1),
('Alaska Airlines', 4002, 'SFO', '2025-01-06 16:00:00', 'SEA', '2025-01-06 18:00:00', 190, 'upcoming', 1),
('Alaska Airlines', 4003, 'SEA', '2025-01-07 09:00:00', 'LAX', '2025-01-07 11:30:00', 200, 'upcoming', 2),
('Alaska Airlines', 4010, 'SEA', '2025-12-03 10:30:00', 'SFO', '2025-12-03 12:30:00', 190, 'upcoming', 1),
('Alaska Airlines', 4011, 'SEA', '2026-01-08 09:00:00', 'LAX', '2026-01-08 11:30:00', 210, 'upcoming', 2),
('All Nippon Airways', 6001, 'HND', '2025-02-15 09:00:00', 'SIN', '2025-02-15 15:00:00', 650, 'upcoming', 1),
('All Nippon Airways', 6002, 'SIN', '2025-02-22 18:00:00', 'HND', '2025-02-23 05:00:00', 640, 'upcoming', 1),
('All Nippon Airways', 6010, 'HND', '2025-12-18 09:30:00', 'SIN', '2025-12-18 15:30:00', 670, 'upcoming', 1),
('All Nippon Airways', 6011, 'SIN', '2026-01-12 17:45:00', 'HND', '2026-01-13 04:45:00', 660, 'upcoming', 1),
('American Airlines', 3001, 'JFK', '2025-01-20 06:30:00', 'DFW', '2025-01-20 09:30:00', 250, 'upcoming', 1),
('American Airlines', 3002, 'DFW', '2025-01-21 17:00:00', 'LHR', '2025-01-22 07:00:00', 750, 'upcoming', 1),
('American Airlines', 3003, 'LHR', '2025-01-28 11:00:00', 'DFW', '2025-01-28 15:30:00', 740, 'upcoming', 2),
('American Airlines', 3004, 'DFW', '2025-01-29 19:00:00', 'JFK', '2025-01-29 23:00:00', 260, 'upcoming', 2),
('American Airlines', 3010, 'JFK', '2025-12-20 07:00:00', 'DFW', '2025-12-20 10:00:00', 270, 'upcoming', 1),
('American Airlines', 3011, 'DFW', '2026-01-05 18:00:00', 'LHR', '2026-01-06 07:30:00', 780, 'upcoming', 1),
('China Eastern Airlines', 5001, 'PVG', '2025-03-01 09:00:00', 'PEK', '2025-03-01 11:00:00', 220, 'upcoming', 1),
('China Eastern Airlines', 5002, 'PVG', '2025-03-05 13:00:00', 'LAX', '2025-03-05 09:00:00', 780, 'upcoming', 1),
('China Eastern Airlines', 5003, 'LAX', '2025-03-20 23:00:00', 'PVG', '2025-03-22 05:00:00', 790, 'upcoming', 1),
('China Eastern Airlines', 5010, 'PVG', '2025-12-25 13:00:00', 'LAX', '2025-12-25 09:00:00', 820, 'upcoming', 1),
('China Eastern Airlines', 5011, 'LAX', '2026-01-20 23:30:00', 'PVG', '2026-01-22 05:30:00', 830, 'upcoming', 1),
('Delta Air Lines', 1001, 'JFK', '2025-01-10 08:00:00', 'LAX', '2025-01-10 11:00:00', 350, 'upcoming', 1),
('Delta Air Lines', 1002, 'LAX', '2025-01-11 13:00:00', 'JFK', '2025-01-11 21:00:00', 360, 'upcoming', 1),
('Delta Air Lines', 1003, 'ATL', '2025-01-09 09:30:00', 'SFO', '2025-01-09 12:00:00', 320, 'delayed', 2),
('Delta Air Lines', 1004, 'SEA', '2025-01-08 14:00:00', 'ATL', '2025-01-08 21:30:00', 280, 'in-progress', 2),
('Delta Air Lines', 1010, 'JFK', '2025-12-01 09:00:00', 'LAX', '2025-12-01 12:00:00', 380, 'upcoming', 1),
('Delta Air Lines', 1011, 'LAX', '2025-12-05 14:00:00', 'JFK', '2025-12-05 22:00:00', 390, 'upcoming', 1),
('United Airlines', 2001, 'SFO', '2025-01-15 07:00:00', 'ORD', '2025-01-15 13:00:00', 300, 'upcoming', 1),
('United Airlines', 2002, 'ORD', '2025-01-16 15:00:00', 'SFO', '2025-01-16 19:00:00', 310, 'upcoming', 1),
('United Airlines', 2003, 'LAX', '2025-02-01 12:00:00', 'HND', '2025-02-02 17:00:00', 900, 'upcoming', 2),
('United Airlines', 2004, 'HND', '2025-02-10 18:00:00', 'LAX', '2025-02-10 10:00:00', 880, 'upcoming', 2),
('United Airlines', 2010, 'SFO', '2025-12-10 08:30:00', 'ORD', '2025-12-10 14:30:00', 320, 'upcoming', 1),
('United Airlines', 2011, 'LAX', '2026-01-15 11:00:00', 'HND', '2026-01-16 17:00:00', 950, 'upcoming', 2);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `ticket_id` int(11) NOT NULL,
  `customer_email` varchar(50) NOT NULL,
  `booking_agent_email` varchar(50) DEFAULT NULL,
  `purchase_date` date NOT NULL,
  `purchase_price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`ticket_id`, `customer_email`, `booking_agent_email`, `purchase_date`, `purchase_price`) VALUES
(1, 'alice@example.com', 'agent_nyu@agency.com', '2024-12-20', 368),
(2, 'bob@example.com', NULL, '2024-12-22', 343),
(4, 'david@example.com', 'agent_nyu@agency.com', '2024-12-28', 396),
(5, 'emma@example.com', NULL, '2024-12-29', 756),
(6, 'alice@example.com', 'agent_nyu@agency.com', '2024-12-10', 270),
(7, 'bob@example.com', 'agent_nyu@agency.com', '2024-12-12', 420),
(8, 'carol@example.com', 'agent_premium@agency.com', '2025-01-05', 990),
(9, 'david@example.com', NULL, '2024-12-18', 250),
(10, 'emma@example.com', 'agent_global@agency.com', '2024-12-20', 787),
(11, 'alice@example.com', 'agent_global@agency.com', '2024-12-22', 962),
(12, 'bob@example.com', NULL, '2024-12-05', 153),
(13, 'carol@example.com', NULL, '2024-12-06', 171),
(14, 'david@example.com', 'agent_global@agency.com', '2024-12-07', 200),
(15, 'emma@example.com', 'agent_premium@agency.com', '2025-02-10', 220),
(16, 'david@example.com', 'agent_premium@agency.com', '2025-02-15', 819),
(17, 'alice@example.com', NULL, '2025-02-20', 1501),
(18, 'bob@example.com', 'agent_premium@agency.com', '2025-01-20', 780),
(19, 'carol@example.com', NULL, '2025-01-25', 640),
(20, 'alice@example.com', NULL, '2025-11-22', 380),
(21, '123@456.com', NULL, '2025-11-22', 760),
(22, '1@2.com', 'agent_nyu@agency.com', '2025-11-25', 380),
(23, '1@2.com', 'agent_nyu@agency.com', '2025-11-25', 570);

-- --------------------------------------------------------

--
-- Table structure for table `seat_class`
--

CREATE TABLE `seat_class` (
  `airline_name` varchar(50) NOT NULL,
  `airplane_id` int(11) NOT NULL,
  `seat_class_id` int(11) NOT NULL,
  `seat_capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `seat_class`
--

INSERT INTO `seat_class` (`airline_name`, `airplane_id`, `seat_class_id`, `seat_capacity`) VALUES
('Alaska Airlines', 1, 1, 150),
('Alaska Airlines', 1, 2, 30),
('Alaska Airlines', 1, 3, 10),
('Alaska Airlines', 2, 1, 150),
('Alaska Airlines', 2, 2, 30),
('Alaska Airlines', 2, 3, 10),
('All Nippon Airways', 1, 1, 150),
('All Nippon Airways', 1, 2, 30),
('All Nippon Airways', 1, 3, 10),
('American Airlines', 1, 1, 150),
('American Airlines', 1, 2, 30),
('American Airlines', 1, 3, 10),
('American Airlines', 2, 1, 150),
('American Airlines', 2, 2, 30),
('American Airlines', 2, 3, 10),
('China Eastern Airlines', 1, 1, 150),
('China Eastern Airlines', 1, 2, 30),
('China Eastern Airlines', 1, 3, 10),
('Delta Air Lines', 1, 1, 150),
('Delta Air Lines', 1, 2, 30),
('Delta Air Lines', 1, 3, 10),
('Delta Air Lines', 2, 1, 150),
('Delta Air Lines', 2, 2, 30),
('Delta Air Lines', 2, 3, 10),
('United Airlines', 1, 1, 150),
('United Airlines', 1, 2, 30),
('United Airlines', 1, 3, 10),
('United Airlines', 2, 1, 150),
('United Airlines', 2, 2, 30),
('United Airlines', 2, 3, 10);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `airline_name` varchar(50) NOT NULL,
  `flight_num` int(11) NOT NULL,
  `airplane_id` int(11) NOT NULL,
  `seat_class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `airline_name`, `flight_num`, `airplane_id`, `seat_class_id`) VALUES
(1, 'Delta Air Lines', 1001, 1, 1),
(2, 'Delta Air Lines', 1001, 1, 1),
(3, 'Delta Air Lines', 1001, 1, 2),
(4, 'Delta Air Lines', 1002, 1, 1),
(5, 'Delta Air Lines', 1002, 1, 3),
(6, 'United Airlines', 2001, 1, 1),
(7, 'United Airlines', 2001, 1, 2),
(8, 'United Airlines', 2003, 2, 1),
(9, 'American Airlines', 3001, 1, 1),
(10, 'American Airlines', 3002, 1, 1),
(11, 'American Airlines', 3003, 2, 2),
(12, 'Alaska Airlines', 4001, 1, 1),
(13, 'Alaska Airlines', 4002, 1, 1),
(14, 'Alaska Airlines', 4003, 2, 1),
(15, 'China Eastern Airlines', 5001, 1, 1),
(16, 'China Eastern Airlines', 5002, 1, 1),
(17, 'China Eastern Airlines', 5003, 1, 3),
(18, 'All Nippon Airways', 6001, 1, 2),
(19, 'All Nippon Airways', 6002, 1, 1),
(20, 'Delta Air Lines', 1010, 1, 1),
(21, 'Delta Air Lines', 1010, 1, 3),
(22, 'Delta Air Lines', 1010, 1, 1),
(23, 'Delta Air Lines', 1010, 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent_airline_authorization`
--
ALTER TABLE `agent_airline_authorization`
  ADD PRIMARY KEY (`agent_email`,`airline_name`),
  ADD KEY `airline_name` (`airline_name`);

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_name`);

--
-- Indexes for table `airline_staff`
--
ALTER TABLE `airline_staff`
  ADD PRIMARY KEY (`username`),
  ADD KEY `airline_name` (`airline_name`);

--
-- Indexes for table `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`airline_name`,`airplane_id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`airport_name`);

--
-- Indexes for table `booking_agent`
--
ALTER TABLE `booking_agent`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`airline_name`,`flight_num`),
  ADD KEY `airline_name` (`airline_name`,`airplane_id`),
  ADD KEY `departure_airport` (`departure_airport`),
  ADD KEY `arrival_airport` (`arrival_airport`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`ticket_id`,`customer_email`),
  ADD KEY `booking_agent_email` (`booking_agent_email`),
  ADD KEY `customer_email` (`customer_email`);

--
-- Indexes for table `seat_class`
--
ALTER TABLE `seat_class`
  ADD PRIMARY KEY (`airline_name`,`airplane_id`,`seat_class_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `airline_name` (`airline_name`,`flight_num`),
  ADD KEY `airline_name_2` (`airline_name`,`airplane_id`,`seat_class_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agent_airline_authorization`
--
ALTER TABLE `agent_airline_authorization`
  ADD CONSTRAINT `agent_airline_authorization_ibfk_1` FOREIGN KEY (`agent_email`) REFERENCES `booking_agent` (`email`) ON DELETE CASCADE,
  ADD CONSTRAINT `agent_airline_authorization_ibfk_2` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`airline_name`) ON DELETE CASCADE;

--
-- Constraints for table `airline_staff`
--
ALTER TABLE `airline_staff`
  ADD CONSTRAINT `airline_staff_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`airline_name`) ON DELETE CASCADE;

--
-- Constraints for table `airplane`
--
ALTER TABLE `airplane`
  ADD CONSTRAINT `airplane_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`airline_name`) ON DELETE CASCADE;

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airline_name`,`airplane_id`) REFERENCES `airplane` (`airline_name`, `airplane_id`),
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`departure_airport`) REFERENCES `airport` (`airport_name`),
  ADD CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`arrival_airport`) REFERENCES `airport` (`airport_name`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`booking_agent_email`) REFERENCES `booking_agent` (`email`),
  ADD CONSTRAINT `purchases_ibfk_3` FOREIGN KEY (`customer_email`) REFERENCES `customer` (`email`);

--
-- Constraints for table `seat_class`
--
ALTER TABLE `seat_class`
  ADD CONSTRAINT `seat_class_ibfk_1` FOREIGN KEY (`airline_name`,`airplane_id`) REFERENCES `airplane` (`airline_name`, `airplane_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`airline_name`,`flight_num`) REFERENCES `flight` (`airline_name`, `flight_num`),
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`airline_name`,`airplane_id`,`seat_class_id`) REFERENCES `seat_class` (`airline_name`, `airplane_id`, `seat_class_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

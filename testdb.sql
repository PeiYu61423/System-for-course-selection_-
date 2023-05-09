-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-05-09 10:37:53
-- 伺服器版本： 10.4.27-MariaDB
-- PHP 版本： 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `testdb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `course`
--

CREATE TABLE `course` (
  `course_id` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dept_name` varchar(255) DEFAULT NULL,
  `dept_class` varchar(255) DEFAULT NULL,
  `dept_grade` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `num_people` int(11) DEFAULT NULL,
  `max_people` int(11) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course`
--

INSERT INTO `course` (`course_id`, `title`, `dept_name`, `dept_class`, `dept_grade`, `type`, `num_people`, `max_people`, `credit`) VALUES
('A001', '資料庫系統', '資訊系', '資訊二丁', 2, 'required', 65, 67, 3),
('A002', '資料庫系統', '資訊系', '資訊二丙', 2, 'required', 65, 67, 3),
('A003', '系統程式', '資訊系', '資訊二丁', 2, 'required', 67, 67, 3),
('A004', '系統程式', '資訊系', '資訊二丙', 2, 'required', 66, 67, 3),
('A005', '計算機結構學', '資訊系', '資訊三甲', 3, 'required', 67, 67, 3),
('A006', '計算機演算法', '資訊系', '資訊三甲', 3, 'required', 67, 67, 3),
('B001', '軟體框架設計', '資訊系', '資訊合', 0, 'option', 67, 67, 3),
('B002', '行動應用程式開發', '資訊系', '資訊合', 0, 'option', 70, 70, 3),
('B003', '安全程式設計', '資訊系', '資訊合', 0, 'option', 60, 65, 3),
('B004', '嵌入式系統', '資訊系', '資訊三甲', 0, 'option', 65, 65, 3),
('B005', '嵌入式系統', '資訊系', '資訊三乙', 0, 'option', 62, 65, 3),
('B006', '線性代數', '資訊系', '資訊一乙', 0, 'option', 66, 67, 3),
('B007', '邏輯設計實習', '資訊系', '資訊一乙', 0, 'option', 66, 67, 1),
('B008', 'Web程式設計', '資訊系', '資訊二丙', 0, 'option', 53, 55, 3),
('B009', 'Web程式設計', '資訊系', '資訊二丁', 0, 'option', 55, 55, 3),
('B010', '邏輯設計', '資訊系', '資訊一丙', 0, 'option', 70, 75, 3),
('B011', '微積分', '資訊系', '資訊合', 0, 'option', 98, 102, 3),
('B012', 'UNIX應用與實務', '資訊系', '資訊合', 0, 'option', 50, 55, 2),
('B013', '物件導向', '資訊系', '資訊合', 0, 'option', 67, 67, 2),
('B014', '物件導向實習', '資訊系', '資訊合', 0, 'option', 67, 67, 1),
('B015', '數位系統設計', '資訊系', '資訊合', 0, 'option', 70, 72, 3),
('B016', '數位系統設計實驗', '資訊系', '資訊合', 0, 'option', 70, 72, 1),
('B017', '組合數學', '資訊系', '資訊二丙', 0, 'option', 65, 70, 3),
('B018', '組合數學', '資訊系', '資訊二丁', 0, 'option', 65, 70, 3);

-- --------------------------------------------------------

--
-- 資料表結構 `cou_tea`
--

CREATE TABLE `cou_tea` (
  `t_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `cou_tea`
--

INSERT INTO `cou_tea` (`t_id`, `course_id`) VALUES
(1, 'A001'),
(2, 'B006'),
(3, 'A003'),
(3, 'A004'),
(4, 'B007'),
(5, 'B008'),
(5, 'B009'),
(5, 'B001'),
(6, 'B010'),
(7, 'B011'),
(8, 'B012'),
(9, 'B002'),
(9, 'B013'),
(9, 'B014'),
(10, 'A005'),
(11, 'A006'),
(12, 'B003'),
(13, 'B004'),
(13, 'B005'),
(14, 'B017'),
(14, 'B018'),
(15, 'A002'),
(16, 'B015'),
(16, 'B016');

-- --------------------------------------------------------

--
-- 資料表結構 `cou_time`
--

CREATE TABLE `cou_time` (
  `course_id` varchar(255) DEFAULT NULL,
  `time_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `cou_time`
--

INSERT INTO `cou_time` (`course_id`, `time_id`) VALUES
('A001', 6),
('A001', 16),
('A001', 17),
('A002', 8),
('A002', 46),
('A002', 47),
('A003', 3),
('A003', 4),
('A003', 43),
('A004', 14),
('A004', 15),
('A004', 27),
('A005', 7),
('A005', 8),
('A005', 32),
('A006', 19),
('A006', 20),
('A006', 58),
('B001', 9),
('B001', 10),
('B001', 42),
('B002', 28),
('B002', 29),
('B002', 30),
('B003', 24),
('B003', 25),
('B003', 26),
('B004', 59),
('B004', 60),
('B004', 61),
('B005', 59),
('B005', 60),
('B005', 61),
('B006', 2),
('B006', 55),
('B006', 56),
('B007', 11),
('B007', 12),
('B007', 13),
('B008', 19),
('B008', 20),
('B008', 41),
('B009', 19),
('B009', 20),
('B009', 41),
('B010', 34),
('B010', 35),
('B010', 40),
('B011', 37),
('B011', 38),
('B011', 39),
('B012', 48),
('B012', 49),
('B013', 1),
('B013', 21),
('B014', 22),
('B014', 23),
('B015', 23),
('B015', 53),
('B015', 54),
('B016', 53),
('B016', 54),
('B017', 63),
('B017', 64),
('B017', 65),
('B018', 63),
('B018', 64),
('B018', 65);

-- --------------------------------------------------------

--
-- 資料表結構 `students`
--

CREATE TABLE `students` (
  `s_id` varchar(255) NOT NULL,
  `s_name` varchar(255) DEFAULT NULL,
  `s_class` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `students`
--

INSERT INTO `students` (`s_id`, `s_name`, `s_class`) VALUES
('D1112149', '吳珮瑜', '資訊二丁'),
('D2222222', '李佳炫', '資訊二丙'),
('D3333333', '吳世勳', '資訊三甲');

-- --------------------------------------------------------

--
-- 資料表結構 `stu_cou`
--

CREATE TABLE `stu_cou` (
  `s_id` varchar(255) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `dept_class` varchar(255) DEFAULT NULL,
  `dept_grade` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `stu_cou`
--

INSERT INTO `stu_cou` (`s_id`, `course_id`, `title`, `department`, `dept_class`, `dept_grade`, `type`, `credit`) VALUES
('D1112149', 'A001', '資料庫系統', '資訊系', '資訊二丁', 2, 'required', 3),
('D1112149', 'A003', '系統程式', '資訊系', '資訊二丁', 2, 'required', 3),
('D2222222', 'A002', '資料庫系統', '資訊系', '資訊二丙', 2, 'required', 3),
('D2222222', 'A004', '系統程式', '資訊系', '資訊二丙', 2, 'required', 3),
('D3333333', 'A005', '計算機結構學', '資訊系', '資訊三甲', 3, 'required', 3),
('D3333333', 'A006', '計算機演算法', '資訊系', '資訊三甲', 3, 'required', 3),
('D1112149', 'A006', '計算機演算法', '資訊系', '資訊三甲', 3, 'required', 3),
('D1112149', 'A005', '計算機結構學', '資訊系', '資訊三甲', 3, 'required', 3),
('D2222222', 'B001', '軟體框架設計', '資訊系', '資訊合', 0, 'option', 3);

-- --------------------------------------------------------

--
-- 資料表結構 `teacher`
--

CREATE TABLE `teacher` (
  `t_id` int(11) NOT NULL,
  `t_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `teacher`
--

INSERT INTO `teacher` (`t_id`, `t_name`) VALUES
(1, '許懷中'),
(2, '洪維志'),
(3, '劉宗杰'),
(4, '王益文'),
(5, '薛念林'),
(6, '李俊宏'),
(7, '方瓊菀'),
(8, '劉明機'),
(9, '陳錫民'),
(10, '郭崇韋'),
(11, '陳烈武'),
(12, '蔡國裕'),
(13, '蔡明峰'),
(14, '游景盛'),
(15, '賴傳淇'),
(16, '陳德生');

-- --------------------------------------------------------

--
-- 資料表結構 `time_slot`
--

CREATE TABLE `time_slot` (
  `time_id` int(11) NOT NULL,
  `day` varchar(255) DEFAULT NULL,
  `class_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `time_slot`
--

INSERT INTO `time_slot` (`time_id`, `day`, `class_number`) VALUES
(1, 'MON', 1),
(2, 'MON', 2),
(3, 'MON', 3),
(4, 'MON', 4),
(5, 'MON', 5),
(6, 'MON', 6),
(7, 'MON', 7),
(8, 'MON', 8),
(9, 'MON', 9),
(10, 'MON', 10),
(11, 'MON', 11),
(12, 'MON', 12),
(13, 'MON', 13),
(14, 'TUE', 1),
(15, 'TUE', 2),
(16, 'TUE', 3),
(17, 'TUE', 4),
(18, 'TUE', 5),
(19, 'TUE', 6),
(20, 'TUE', 7),
(21, 'TUE', 8),
(22, 'TUE', 9),
(23, 'TUE', 10),
(24, 'TUE', 11),
(25, 'TUE', 12),
(26, 'TUE', 13),
(27, 'WED', 1),
(28, 'WED', 2),
(29, 'WED', 3),
(30, 'WED', 4),
(31, 'WED', 5),
(32, 'WED', 6),
(33, 'WED', 7),
(34, 'WED', 8),
(35, 'WED', 9),
(36, 'WED', 10),
(37, 'WED', 11),
(38, 'WED', 12),
(39, 'WED', 13),
(40, 'THU', 1),
(41, 'THU', 2),
(42, 'THU', 3),
(43, 'THU', 4),
(44, 'THU', 5),
(45, 'THU', 6),
(46, 'THU', 7),
(47, 'THU', 8),
(48, 'THU', 9),
(49, 'THU', 10),
(50, 'THU', 11),
(51, 'THU', 12),
(52, 'THU', 13),
(53, 'FRI', 1),
(54, 'FRI', 2),
(55, 'FRI', 3),
(56, 'FRI', 4),
(57, 'FRI', 5),
(58, 'FRI', 6),
(59, 'FRI', 7),
(60, 'FRI', 8),
(61, 'FRI', 9),
(62, 'FRI', 10),
(63, 'FRI', 11),
(64, 'FRI', 12),
(65, 'FRI', 13);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- 資料表索引 `cou_tea`
--
ALTER TABLE `cou_tea`
  ADD KEY `t_id` (`t_id`),
  ADD KEY `course_id` (`course_id`);

--
-- 資料表索引 `cou_time`
--
ALTER TABLE `cou_time`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `time_id` (`time_id`);

--
-- 資料表索引 `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`s_id`);

--
-- 資料表索引 `stu_cou`
--
ALTER TABLE `stu_cou`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `s_id` (`s_id`);

--
-- 資料表索引 `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`t_id`);

--
-- 資料表索引 `time_slot`
--
ALTER TABLE `time_slot`
  ADD PRIMARY KEY (`time_id`);

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `cou_tea`
--
ALTER TABLE `cou_tea`
  ADD CONSTRAINT `cou_tea_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`),
  ADD CONSTRAINT `cou_tea_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

--
-- 資料表的限制式 `cou_time`
--
ALTER TABLE `cou_time`
  ADD CONSTRAINT `cou_time_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `cou_time_ibfk_2` FOREIGN KEY (`time_id`) REFERENCES `time_slot` (`time_id`);

--
-- 資料表的限制式 `stu_cou`
--
ALTER TABLE `stu_cou`
  ADD CONSTRAINT `stu_cou_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `stu_cou_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `students` (`s_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

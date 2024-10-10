-- Create WEB_FILM database
CREATE DATABASE IF NOT EXISTS WEB_FILM;
USE WEB_FILM;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET TIME_ZONE = "+00:00";

DROP TABLE IF EXISTS `CINEMAS`;
CREATE TABLE `CINEMAS` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `cinema_name` VARCHAR(255) NOT NULL,
    `cinema_address` VARCHAR(255) NOT NULL,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `cinemas` (`id`, `cinema_name`, `cinema_address`) VALUES
(1, 'Beta Mỹ Đình', 'Hà Nội'),
(2, 'Beta Thanh Xuân', 'Hà Nội'),
(3, 'Beta Đan Phượng', 'Hà Nội'),
(4, 'Beta Thái Nguyên', 'Hà Nội'),
(5, 'Beta Biên Hòa', 'Hà Nội'),
(6, 'Beta Long Khánh', 'Hà Nội'),
(7, 'Beta Long Thành', 'Hà Nội'),
(8, 'CGV Thái Hà', 'Hà Nội'),
(9, 'Beta Giải Phóng', 'Hà Nội');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(255) NOT NULL UNIQUE,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `roles` (`code`, `name`) VALUES ('ADMIN', 'Quản Trị Viên'), ('USER', 'Khách Hàng');

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `category_name` VARCHAR(150) NOT NULL UNIQUE,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `categories` (`category_name`) 
VALUES ('Khoa học viễn tưởng'), ('Hành động'), ('Tâm lý - Tình cảm');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `roleid` INT NOT NULL,
    `username` VARCHAR(150) NOT NULL,
    `password` VARCHAR(15) NOT NULL,
    `fullname` VARCHAR(150) NOT NULL,
    `avatar` LONGTEXT,
    `email` VARCHAR(255),
    `city` VARCHAR(255),
    `phone` VARCHAR(12),
    `status` INT NOT NULL DEFAULT 1,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`roleid`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `users` (`id`, `roleid`, `username`, `password`, `fullname`, `avatar`, `email`, `city`, `phone`) VALUES
(1, 1, 'khanh04', '123456', 'Nguyễn Văn A', 'http://example.com/avatar1.jpg', 'admin@example.com', 'Hà Nội', '0123456789'),
(2, 2, 'cuong04', '123456', 'Nguyễn Văn B', 'http://example.com/avatar1.jpg', 'admin@example.com', 'Hà Nội', '0123456789');

DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `movie_name` VARCHAR(250) NOT NULL,
    `movie_category_id` INT, 
    `movie_description` TEXT,
    `movie_directors` VARCHAR(1000),
    `movie_cast` VARCHAR(1000),
    `release_date` TIMESTAMP NULL,
    `running_time` TIME DEFAULT '00:00:00',
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`movie_category_id`) REFERENCES `categories`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `movies` (`movie_name`, `movie_category_id`, `movie_description`, `movie_directors`, `movie_cast`, `release_date`, `running_time`) VALUES 
('Inception', 1, 'A skilled thief is offered a chance to have his past crimes forgiven by implanting another person\'s idea into their subconscious.', 'Christopher Nolan', 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page', '2024-10-09 00:00:00', '02:28:00'),
('Parasite', 2, 'A poor family schemes to become employed by a wealthy family and infiltrates their household by posing as unrelated, highly qualified individuals.', 'Bong Joon-ho', 'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong', '2024-10-08 00:00:00', '02:12:00');

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `movie_id` INT DEFAULT NULL,
    `cinema_id` INT DEFAULT NULL,
    `schedule_date` DATE DEFAULT NULL,
    `schedule_start` TIME DEFAULT NULL,
    `schedule_end` TIME DEFAULT NULL,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`movie_id`) REFERENCES `movies`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`cinema_id`) REFERENCES `cinemas`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `schedule` (`movie_id`, `cinema_id`, `schedule_date`, `schedule_start`, `schedule_end`) VALUES
(1, 1, '2024-10-10', '14:00:00', '16:00:00'),
(2, 2, '2024-10-10', '18:00:00', '20:00:00'),
(1, 2, '2024-10-11', '20:30:00', '22:30:00');

DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats` (
	`id` int not null auto_increment,
    `seat_type` varchar(50) not null,
    `cinema_id` int default null,
    `seat_row` varchar(2),
    `seat_number` int,
    `seat_status` TINYINT(1) DEFAULT 0, -- 0 = Available, 1 = Booked
    `createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`cinema_id`) REFERENCES `cinemas`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `seats` (`seat_type`, `cinema_id`, `seat_row`, `seat_number`, `seat_status`) VALUES
('Thường', 1 , 'A', 1, 0),
('Thường', 1, 'A', 2, 1), 
('VIP', 1, 'B', 1, 0),
('VIP', 1, 'B', 2, 0);

DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `userid` INT DEFAULT NULL,
    `schedule_id` INT DEFAULT NULL,
    `price` DOUBLE DEFAULT 0, 
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`userid`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`schedule_id`) REFERENCES `schedule`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `booking` (`userid`, `schedule_id`, `price`) VALUES
(2, 1, 200000), 
(1, 2, 120000);

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `movie_id` INT NOT NULL,
    `rating_value` INT NOT NULL CHECK (`rating_value` >= 1 AND `rating_value` <= 5),
    `rating_comment` TEXT,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`movie_id`) REFERENCES `movies`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `ratings` (`user_id`, `movie_id`, `rating_value`, `rating_comment`) VALUES
(2, 1, 5, 'Phim rất hay'),
(1, 2, 4, 'Như cl');


DROP TABLE IF EXISTS `booking_details`;
CREATE TABLE `booking_details` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `booking_id` INT NOT NULL,
    `seat_id` INT NOT NULL,
    `cinema_id` INT NOT NULL,
    `price` DOUBLE DEFAULT 0,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`booking_id`) REFERENCES `booking`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`seat_id`) REFERENCES `seats`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`cinema_id`) REFERENCES `cinemas`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `booking_details` (`booking_id`, `seat_id`, `cinema_id`, `price`) VALUES
(1, 1, 1, 100000), 
(1, 2, 1, 100000), 
(2, 1, 1, 120000); 


COMMIT;

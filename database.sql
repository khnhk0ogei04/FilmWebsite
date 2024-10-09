CREATE DATABASE IF NOT EXISTS FILM;
USE FILM;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET TIME_ZONE = "+00:00";

DROP TABLE IF EXISTS `CINEMAS`;
CREATE TABLE CINEMAS (
	`id` INT NOT NULL AUTO_INCREMENT,
    `CINEMA_NAME` VARCHAR(255) NOT NULL,
    `CINEMA_ADDRESS` varchar(255) NOT NULL,
    createddate TIMESTAMP NULL,
	modifieddate TIMESTAMP NULL,
	createdby VARCHAR(255) NULL,
	modifiedby VARCHAR(255) NULL,
    primary key(id)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_vietnamese_ci;

INSERT INTO `cinemas` (`id`, `cinema_name`, `cinema_address`) VALUES
(1, 'Beta Mỹ Đình', 'Hà Nội'),
(2, 'Beta Thanh Xuân', 'Hà Nội'),
(3, 'Beta Đan Phượng', 'Hà Nội'),
(4, 'Beta Thái Nguyên', 'Hà Nội'),
(5, 'Beta Biên Hòa', 'Hà Nội'),
(6, 'Beta Long Khánh', 'Hà Nội'),
(7, 'Beta Long Thành', 'Hà Nội'),
(8, 'CGV Thái Hà', 'Hà Nội'),
(9, 'Beta Giải Phóng', 'Hà Nội')
;

DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`(
	`id` int not null auto_increment,
    `cinema_id` int default null,
    `room_name` varchar(250),
    PRIMARY KEY (`id`), 
    FOREIGN KEY (`cinema_id`) REFERENCES `cinemas`(`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `room` (`cinema_id`, `room_name`) 
VALUES 
(1, 'Phòng 1'),
(1, 'Phòng 2'),
(2, 'Phòng 1'),
(2, 'Phòng 2');

Drop table if exists `roles`;
create table roles(
	id int not null primary key auto_increment,
    code varchar(255) not null unique,
    name varchar(255) not null unique,
    createddate TIMESTAMP NULL,
	modifieddate TIMESTAMP NULL,
	createdby VARCHAR(255) NULL,
	modifiedby VARCHAR(255) NULL
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_vietnamese_ci;

insert into roles(code,name) values('ADMIN','Quản Trị Viên');
insert into roles(code,name) values('USER','Khách Hàng');

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`(
	`id` int not null auto_increment,
    `category_name` varchar(150) not null unique,
    PRIMARY KEY (`id`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_vietnamese_ci;
INSERT INTO `categories` (`category_name`) 
VALUES 
('Khoa học viễn tưởng'), 
('Hành động'), 
('Tâm lý - Tình cảm');


DROP TABLE IF EXISTS `users`;
CREATE TABLE `USERS`(
	`id` int not null auto_increment,
    `roleid` int not null,
    `username` varchar(150) not null,
	`password` varchar(15) not null,
    `fullname` varchar(150) not null,
    `avatar` longtext,
    `email` varchar(255),
    `city` varchar(255),
    `phone` varchar(12),
    `status` int not null default 1,
    `createddate` TIMESTAMP NULL,
	`modifieddate` TIMESTAMP NULL,
	`createdby` VARCHAR(255) NULL,
	`modifiedby` VARCHAR(255) NULL,
    primary key(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

ALTER table users 
add constraint fk_roleid 
foreign key(roleid) references roles(id);

INSERT INTO `USERS` (`id`, `roleid`, `username`, `password`, `fullname`, `avatar`, `email`, `city`, `phone`)
VALUES 
(1, 1, 'khanh04', '123456', 'Nguyễn Văn A', 'http://example.com/avatar1.jpg', 'admin@example.com', 'Hà Nội', '0123456789'),
(2, 2, 'cuong04', '123456', 'Nguyễn Văn B', 'http://example.com/avatar1.jpg', 'admin@example.com', 'Hà Nội', '0123456789');



CREATE TABLE `BOOKING` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `userid` INT DEFAULT NULL,
    `schedule_id` INT DEFAULT NULL,
    `seat_id` INT DEFAULT NULL,
    `price` DOUBLE DEFAULT 0,
    `seat_status` TINYINT(1) DEFAULT NULL,
    `createddate` TIMESTAMP NULL,
    `modifieddate` TIMESTAMP NULL,
    `createdby` VARCHAR(255) NULL,
    `modifiedby` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`userid`) REFERENCES `USERS`(`ID`) ON DELETE CASCADE,
    FOREIGN KEY (`schedule_id`) REFERENCES `SCHEDULE`(`ID`) ON DELETE CASCADE,
    FOREIGN KEY (`seat_id`) REFERENCES `SEATS`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `BOOKING` (`userid`, `schedule_id`, `seat_id`, `price`, `seat_status`) VALUES
(1, 1, 1, 750000, 1),
(1, 1, 2, 150000, 1);

DROP TABLE if exists `movies`;
CREATE TABLE `movies`(
	`id` int not null auto_increment,
    `movie_name` varchar(250) not null,
    `movie_category_id` int, 
    `movie_description` text,
	`movie_directors` varchar(1000),
    `movie_cast` varchar(1000),
    `release_date` timestamp NULL,
    `running_time` TIME default '00:00:00',
    createddate TIMESTAMP NULL,
	modifieddate TIMESTAMP NULL,
	createdby VARCHAR(255) NULL,
	modifiedby VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`movie_category_id`) REFERENCES `categories`(`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

INSERT INTO `movies` (
    `movie_name`, `movie_category_id`, `movie_description`, `movie_directors`, `movie_cast`, `release_date`, `running_time`
) VALUES 
('Inception', 1, 'A skilled thief is offered a chance to have his past crimes forgiven by implanting another person\'s idea into their subconscious.', 'Christopher Nolan', 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page', '2024-10-09 00:00:00', '02:28:00'),
('Parasite', 2, 'A poor family schemes to become employed by a wealthy family and infiltrates their household by posing as unrelated, highly qualified individuals.', 'Bong Joon-ho', 'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong', '2024-10-08 00:00:00', '02:12:00');

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `schedule_date` date DEFAULT NULL,
  `schedule_start` time DEFAULT NULL,
  `schedule_end` time DEFAULT NULL,
  createddate TIMESTAMP NULL,
  modifieddate TIMESTAMP NULL,
  createdby VARCHAR(255) NULL,
  modifiedby VARCHAR(255) NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`movie_id`) REFERENCES `movies`(`id`) ON DELETE CASCADE,
  FOREIGN KEY(`room_id`) REFERENCES `room`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
INSERT INTO `schedule` (`id`, `movie_id`, `room_id`, `schedule_date`, `schedule_start`, `schedule_end`) VALUES
(1, 1, 1, '2024-10-10', '14:00:00', '16:00:00'), 
(2, 2, 2, '2024-10-10', '18:00:00', '20:00:00'), 
(3, 1, 2, '2024-10-11', '20:30:00', '22:30:00');

DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats` (
	`id` int not null auto_increment,
    `seat_type` varchar(50) not null,
    `room_id` int default null,
    `seat_row` varchar(2),
    `seat_number` int,
    createddate TIMESTAMP NULL,
	modifieddate TIMESTAMP NULL,
	createdby VARCHAR(255) NULL,
	modifiedby VARCHAR(255) NULL,
    primary key (`id`),
    FOREIGN KEY (`room_id`) REFERENCES `room`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
INSERT INTO `seats` (`seat_type`, `room_id`, `seat_row`, `seat_number`) VALUES
('Thường', 1, 'A', 1),
('Thường', 1, 'A', 2),
('VIP', 1, 'B', 1),
('VIP', 1, 'B', 2);

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE ratings(
	`id` int auto_increment primary key,
	`user_id` int not null,
    `movie_id` int not null,
    `rating` tinyint not null,
    `review` text,
    createddate TIMESTAMP NULL,
	modifieddate TIMESTAMP NULL,
	createdby VARCHAR(255) NULL,
	modifiedby VARCHAR(255) NULL,
    foreign key (user_id) references users(id),
    foreign key (movie_id) references movies(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

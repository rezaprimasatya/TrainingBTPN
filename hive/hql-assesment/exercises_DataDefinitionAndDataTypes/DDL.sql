CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET ucs2 COLLATE ucs2_general_ci NOT NULL,
  `director_id` int DEFAULT NULL,
  `copyright_year` year DEFAULT NULL,
  `length` time DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `rating` decimal(10,0) DEFAULT NULL,
  `otes` text,
  PRIMARY KEY (`id`),
  KEY `fk_director_id` (`director_id`),
  KEY `fk_genre_id` (`genre_id`),
  KEY `fk_caregory_id` (`category_id`),
  CONSTRAINT `fk_caregory_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_director_id` FOREIGN KEY (`director_id`) REFERENCES `directors` (`id`),
  CONSTRAINT `fk_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

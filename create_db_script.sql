-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema book_store_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema book_store_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `book_store_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `book_store_db` ;

-- -----------------------------------------------------
-- Table `book_store_db`.`statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`statuses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `label_UNIQUE` (`label` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 124
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `role_id` INT NOT NULL DEFAULT '2',
  `address` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `role_id_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `book_store_db`.`roles` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`books` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `stock` INT NULL DEFAULT '0',
  `stock_rent` INT NULL DEFAULT '0',
  `category_id` INT NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `vendor_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  `view_count` INT NULL DEFAULT '0',
  `purchase_count` INT NULL DEFAULT '0',
  `borrow_count` INT NULL DEFAULT '0',
  `rating_average` FLOAT NULL DEFAULT '0',
  `review_count` INT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  INDEX `vendor_id_idx` (`vendor_id` ASC) VISIBLE,
  INDEX `book_status_id_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `book_status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `book_store_db`.`statuses` (`id`),
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `book_store_db`.`categories` (`id`),
  CONSTRAINT `vendor_id`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 48
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`book_copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`book_copies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `book_copy_book_id_idx` (`book_id` ASC) VISIBLE,
  INDEX `book_copy_status_id_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `book_copy_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `book_copy_status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `book_store_db`.`statuses` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 407
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `type` ENUM('sale', 'rental') NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `cart_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `cart_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `cart_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `cart_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 126
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `payment_method` VARCHAR(50) NULL DEFAULT NULL,
  `payment_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `user_payment_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_payment_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`order_statuses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` DECIMAL(10,2) NOT NULL,
  `payment_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `payment_id_idx` (`payment_id` ASC) VISIBLE,
  INDEX `order_status_id_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `order_payment_id`
    FOREIGN KEY (`payment_id`)
    REFERENCES `book_store_db`.`payments` (`id`),
  CONSTRAINT `order_status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `book_store_db`.`order_statuses` (`id`),
  CONSTRAINT `order_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`order_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL DEFAULT NULL,
  `book_id` INT NULL DEFAULT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `book_store_db`.`orders` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`rentals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `book_id` INT NULL DEFAULT NULL,
  `rental_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `return_date` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `book_rental_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `user_rental_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `review_book_id_idx` (`book_id` ASC) VISIBLE,
  INDEX `review_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `review_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `review_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `book_store_db`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_store_db`.`wishlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `wishlist_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `wishlist_book_id_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `wishlist_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `book_store_db`.`books` (`id`),
  CONSTRAINT `wishlist_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `book_store_db`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 81
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

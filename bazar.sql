-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bazardigital_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bazardigital_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bazardigital_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bazardigital_db` ;

-- -----------------------------------------------------
-- Table `bazardigital_db`.`products_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`products_categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bazardigital_db`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`articles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `description` VARCHAR(450) NOT NULL,
  `stock` TINYINT NOT NULL,
  `profesional_use` INT NOT NULL,
  `typeId` INT NOT NULL,
  `productCategoryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_articles_idx` (`productCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_category_articles`
    FOREIGN KEY (`productCategoryId`)
    REFERENCES `bazardigital_db`.`products_categories` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bazardigital_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bazardigital_db`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `dni` TINYINT NOT NULL,
  `salary` TINYINT NOT NULL,
  `rolId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_rol_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `fk_employees_rol`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazardigital_db`.`roles` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bazardigital_db`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `article` VARCHAR(45) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `total_amount` DECIMAL(9,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bazardigital_db`.`employees_access`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazardigital_db`.`employees_access` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `saleId` INT NOT NULL,
  `articlesId` INT NOT NULL,
  `rolId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_access_idx` (`rolId` ASC) VISIBLE,
  INDEX `fk_employees_sales_idx` (`saleId` ASC) VISIBLE,
  INDEX `fk_employees_articles_idx` (`articlesId` ASC) VISIBLE,
  CONSTRAINT `fk_employees_access`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazardigital_db`.`employees` (`rolId`),
  CONSTRAINT `fk_employees_articles`
    FOREIGN KEY (`articlesId`)
    REFERENCES `bazardigital_db`.`articles` (`id`),
  CONSTRAINT `fk_employees_sales`
    FOREIGN KEY (`saleId`)
    REFERENCES `bazardigital_db`.`sales` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

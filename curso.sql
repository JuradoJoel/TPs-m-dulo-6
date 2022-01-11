-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema playground_db10
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground_db10
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground_db10` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `playground_db10` ;

-- -----------------------------------------------------
-- Table `playground_db10`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`categories` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `categoryId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_categories_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_users_categories`
    FOREIGN KEY (`categoryId`)
    REFERENCES `playground_db10`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(450) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `end date` DATE NOT NULL,
  `quota` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`units` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(450) NOT NULL,
  `start_date` DATE NOT NULL,
  `coursesId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_units_courses_idx` (`coursesId` ASC) VISIBLE,
  CONSTRAINT `fk_units_courses`
    FOREIGN KEY (`coursesId`)
    REFERENCES `playground_db10`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`lessons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(450) NOT NULL,
  `start_date` DATE NOT NULL,
  `visible` TINYINT NOT NULL,
  `unitId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lesson_unit`
    FOREIGN KEY (`id`)
    REFERENCES `playground_db10`.`units` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`blocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `visible` TINYINT(1) NULL,
  `type` VARCHAR(45) NOT NULL,
  `content` VARCHAR(255) NOT NULL,
  `typeId` INT NOT NULL,
  `lessonId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_blocks_types`
    FOREIGN KEY (`id`)
    REFERENCES `playground_db10`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blocks_lessons`
    FOREIGN KEY (`id`)
    REFERENCES `playground_db10`.`lessons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`courses_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`courses_users` (
  `id` INT NOT NULL,
  `userId` INT NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_courses_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_courses_users_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_users_courses`
    FOREIGN KEY (`userId`)
    REFERENCES `playground_db10`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_users`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground_db10`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

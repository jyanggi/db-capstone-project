-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `StaffId` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NULL,
  `Role` VARCHAR(45) NULL,
  `Salary` VARCHAR(45) NULL,
  `Email` VARCHAR(255) NULL,
  `ContactNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`StaffId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerId` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NULL,
  `Email` VARCHAR(255) NULL,
  `ContactNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingId` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NULL,
  `TableNumber` INT NULL,
  `StaffId` INT NULL,
  `CustomerId` INT NULL,
  `BookingSlot` INT NULL,
  PRIMARY KEY (`BookingId`),
  INDEX `EmployeeId_idx` (`StaffId` ASC),
  INDEX `CustomerId_idx` (`CustomerId` ASC),
  CONSTRAINT `b_StaffId`
    FOREIGN KEY (`StaffId`)
    REFERENCES `LittleLemonDB`.`Staff` (`StaffId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `b_CustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemsId` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(255) NULL,
  `StarterName` VARCHAR(255) NULL,
  `DessertName` VARCHAR(255) NULL,
  PRIMARY KEY (`MenuItemsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuId` INT NOT NULL AUTO_INCREMENT,
  `MenuName` VARCHAR(45) NULL,
  `Cuisine` VARCHAR(45) NULL,
  `MenuItemsId` INT NULL,
  PRIMARY KEY (`MenuId`),
  INDEX `MenuItemsId_idx` (`MenuItemsId` ASC),
  CONSTRAINT `MenuItemsId`
    FOREIGN KEY (`MenuItemsId`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderId` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL,
  `TotalCost` DECIMAL NULL,
  `MenuId` INT NULL,
  `CustomerId` INT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `o_MenuId_idx` (`MenuId` ASC),
  INDEX `o_CustomerId_idx` (`CustomerId` ASC),
  CONSTRAINT `o_MenuId`
    FOREIGN KEY (`MenuId`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `o_CustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `OrderDeliveryStatusId` INT NOT NULL AUTO_INCREMENT,
  `OrderId` INT NULL,
  `Status` VARCHAR(45) NULL,
  `DeliveryDate` DATETIME NULL,
  PRIMARY KEY (`OrderDeliveryStatusId`),
  INDEX `OrderId_idx` (`OrderId` ASC),
  UNIQUE INDEX `OrderId_UNIQUE` (`OrderId` ASC),
  CONSTRAINT `OrderId`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

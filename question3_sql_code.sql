-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`affected_gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`affected_gene` (
  `idaffected_gene` INT UNSIGNED NOT NULL,
  `affected_gene` VARCHAR(45) NULL,
  `description_affected_gene` MEDIUMTEXT NULL,
  PRIMARY KEY (`idaffected_gene`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gene` (
  `idGene` INT UNSIGNED NOT NULL,
  `gene_name` VARCHAR(45) NULL,
  `chromosomal_position` VARCHAR(45) NULL,
  `affected_gene_idaffected_gene` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idGene`, `affected_gene_idaffected_gene`),
  INDEX `fk_Gene_affected_gene1_idx` (`affected_gene_idaffected_gene` ASC) VISIBLE,
  CONSTRAINT `fk_Gene_affected_gene1`
    FOREIGN KEY (`affected_gene_idaffected_gene`)
    REFERENCES `mydb`.`affected_gene` (`idaffected_gene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Chromosomal_position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Chromosomal_position` (
  `idChromosomal_position` INT UNSIGNED NOT NULL,
  `chromosome` VARCHAR(45) NULL,
  `start` INT NULL,
  `end` INT NULL,
  PRIMARY KEY (`idChromosomal_position`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `idpatient` INT UNSIGNED NOT NULL,
  `patient_name` VARCHAR(45) NULL,
  `patient_gender` ENUM("M", "F") NULL,
  `patient_age_diagnosis` INT NULL,
  `patient_syndrome` VARCHAR(45) NULL,
  `Gene_idGene` INT UNSIGNED NOT NULL,
  `Gene_affected_gene_idaffected_gene` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idpatient`, `Gene_idGene`, `Gene_affected_gene_idaffected_gene`),
  INDEX `fk_patient_Gene1_idx` (`Gene_idGene` ASC, `Gene_affected_gene_idaffected_gene` ASC) VISIBLE,
  CONSTRAINT `fk_patient_Gene1`
    FOREIGN KEY (`Gene_idGene` , `Gene_affected_gene_idaffected_gene`)
    REFERENCES `mydb`.`Gene` (`idGene` , `affected_gene_idaffected_gene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`syndrome` (
  `idsyndrome` INT UNSIGNED NOT NULL,
  `syndrome` VARCHAR(45) NULL,
  `description_syndrome` MEDIUMTEXT NULL,
  PRIMARY KEY (`idsyndrome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient_has_syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient_has_syndrome` (
  `patient_idpatient` INT UNSIGNED NOT NULL,
  `syndrome_idsyndrome` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`patient_idpatient`, `syndrome_idsyndrome`),
  INDEX `fk_patient_has_syndrome_syndrome1_idx` (`syndrome_idsyndrome` ASC) VISIBLE,
  INDEX `fk_patient_has_syndrome_patient_idx` (`patient_idpatient` ASC) VISIBLE,
  CONSTRAINT `fk_patient_has_syndrome_patient`
    FOREIGN KEY (`patient_idpatient`)
    REFERENCES `mydb`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_has_syndrome_syndrome1`
    FOREIGN KEY (`syndrome_idsyndrome`)
    REFERENCES `mydb`.`syndrome` (`idsyndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Chromosomal_position_has_Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Chromosomal_position_has_Gene` (
  `Chromosomal_position_idChromosomal_position` INT UNSIGNED NOT NULL,
  `Gene_idGene` INT UNSIGNED NOT NULL,
  `Gene_affected_gene_idaffected_gene` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Chromosomal_position_idChromosomal_position`, `Gene_idGene`, `Gene_affected_gene_idaffected_gene`),
  INDEX `fk_Chromosomal_position_has_Gene_Gene1_idx` (`Gene_idGene` ASC, `Gene_affected_gene_idaffected_gene` ASC) VISIBLE,
  INDEX `fk_Chromosomal_position_has_Gene_Chromosomal_position1_idx` (`Chromosomal_position_idChromosomal_position` ASC) VISIBLE,
  CONSTRAINT `fk_Chromosomal_position_has_Gene_Chromosomal_position1`
    FOREIGN KEY (`Chromosomal_position_idChromosomal_position`)
    REFERENCES `mydb`.`Chromosomal_position` (`idChromosomal_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chromosomal_position_has_Gene_Gene1`
    FOREIGN KEY (`Gene_idGene` , `Gene_affected_gene_idaffected_gene`)
    REFERENCES `mydb`.`Gene` (`idGene` , `affected_gene_idaffected_gene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

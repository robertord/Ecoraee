# SQL Manager Lite for MySQL 5.3.1.7
# ---------------------------------------
# Host     : energylab
# Port     : 3306
# Database : energylab_demostrativos


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

SET sql_mode = '';

#
# Dropping database objects
#

DROP VIEW IF EXISTS `vw_suma_demostrativo_diario`;
DROP VIEW IF EXISTS `vw_salida_demostrativo_4`;
DROP VIEW IF EXISTS `vw_salida_demostrativo_3`;
DROP VIEW IF EXISTS `vw_salida_demostrativo_2`;
DROP VIEW IF EXISTS `vw_salida_demostrativo_1`;
DROP VIEW IF EXISTS `vw_max_demostrativo_acumulativo`;
DROP VIEW IF EXISTS `vw_demostrativo_parametros`;
DROP VIEW IF EXISTS `vw_demostrativo_categorias`;
DROP VIEW IF EXISTS `vw_demostrativo_campos_linechart`;
DROP VIEW IF EXISTS `vw_demostrativo_bubble_vars`;
DROP VIEW IF EXISTS `vw_check_data_demostrativo_4`;
DROP VIEW IF EXISTS `vw_check_data_demostrativo_3`;
DROP VIEW IF EXISTS `vw_check_data_demostrativo_2`;
DROP VIEW IF EXISTS `vw_check_data_demostrativo_1`;
DROP VIEW IF EXISTS `td_members`;
DROP VIEW IF EXISTS `demostrativo_4_acumulativo_todo`;
DROP VIEW IF EXISTS `demostrativo_4_acumulativo`;
DROP VIEW IF EXISTS `demostrativo_4`;
DROP VIEW IF EXISTS `demostrativo_4_diario`;
DROP VIEW IF EXISTS `demostrativo_3_acumulativo_todo`;
DROP VIEW IF EXISTS `demostrativo_3_acumulativo`;
DROP VIEW IF EXISTS `demostrativo_3`;
DROP VIEW IF EXISTS `demostrativo_3_diario`;
DROP VIEW IF EXISTS `demostrativo_2_acumulativo_todo`;
DROP VIEW IF EXISTS `demostrativo_2_acumulativo`;
DROP VIEW IF EXISTS `demostrativo_2`;
DROP VIEW IF EXISTS `demostrativo_2_diario`;
DROP VIEW IF EXISTS `demostrativo_1_acumulativo_todo`;
DROP VIEW IF EXISTS `demostrativo_1_acumulativo`;
DROP VIEW IF EXISTS `demostrativo_1`;
DROP VIEW IF EXISTS `demostrativo_1_diario`;
DROP PROCEDURE IF EXISTS `update_acumulativos_from_date`;
DROP PROCEDURE IF EXISTS `insert_test_data`;
DROP PROCEDURE IF EXISTS `check_data_demostrativo_diario`;
DROP PROCEDURE IF EXISTS `set_dacumulativo_fecha`;
DROP TABLE IF EXISTS `login_attempts`;
DROP TABLE IF EXISTS `demostrativo_acumulativo`;
DROP TABLE IF EXISTS `demostrativo_diario`;
DROP TABLE IF EXISTS `members`;
DROP TABLE IF EXISTS `members_role`;
DROP TABLE IF EXISTS `demostrativo`;

#
# Structure for the `demostrativo` table : 
#

CREATE TABLE `demostrativo` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` MEDIUMTEXT COLLATE utf8_spanish_ci NOT NULL,
  `description` MEDIUMTEXT COLLATE utf8_spanish_ci,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT 1,
  `is_loading` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY USING BTREE (`id`)
)ENGINE=InnoDB CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Structure for the `members_role` table : 
#

CREATE TABLE `members_role` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `name` CHAR(128) COLLATE utf8_spanish_ci NOT NULL,
  `code` CHAR(25) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`id`)
)ENGINE=InnoDB CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Structure for the `members` table : 
#

CREATE TABLE `members` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) COLLATE utf8_spanish_ci NOT NULL,
  `email` VARCHAR(50) COLLATE utf8_spanish_ci NOT NULL,
  `password` CHAR(128) COLLATE utf8_spanish_ci NOT NULL,
  `salt` CHAR(128) COLLATE utf8_spanish_ci NOT NULL,
  `members_role_id` INTEGER(11) NOT NULL,
  `demostrativo_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`id`),
  UNIQUE INDEX `email` USING BTREE (`email`),
   INDEX `members_role_id` USING BTREE (`members_role_id`),
   INDEX `members_ibfk_2` USING BTREE (`demostrativo_id`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`members_role_id`) REFERENCES `members_role` (`id`),
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`demostrativo_id`) REFERENCES `demostrativo` (`id`)
)ENGINE=InnoDB  CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Structure for the `demostrativo_diario` table : 
#

CREATE TABLE `demostrativo_diario` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `demostrativo_id` INTEGER(11) NOT NULL COMMENT 'C2',
  `date` DATE NOT NULL COMMENT 'D4',
  `equipos_procesados` INTEGER(11) NOT NULL COMMENT 'G4',
  `parametro_1` DECIMAL(25,10) NOT NULL COMMENT 'D6',
  `parametro_2` DECIMAL(25,10) NOT NULL COMMENT 'D7',
  `parametro_3` DECIMAL(25,10) NOT NULL COMMENT 'D8',
  `parametro_4` DECIMAL(25,10) NOT NULL COMMENT 'D9',
  `parametro_5` DECIMAL(25,10) NOT NULL COMMENT 'D10',
  `parametro_6` DECIMAL(25,10) NOT NULL COMMENT 'D11',
  `parametro_7` DECIMAL(25,10) NOT NULL COMMENT 'D12',
  `parametro_8` DECIMAL(25,10) NOT NULL COMMENT 'D13',
  `parametro_9` DECIMAL(25,10) NOT NULL COMMENT 'D14',
  `parametro_10` DECIMAL(25,10) NOT NULL COMMENT 'D15',
  `parametro_11` DECIMAL(25,10) NOT NULL COMMENT 'D16',
  `parametro_12` DECIMAL(25,10) NOT NULL COMMENT 'D17',
  `parametro_13` DECIMAL(25,10) NOT NULL COMMENT 'D18',
  `parametro_14` DECIMAL(25,10) NOT NULL COMMENT 'D19',
  `parametro_15` DECIMAL(25,10) NOT NULL COMMENT 'D20',
  `parametro_16` DECIMAL(25,10) NOT NULL COMMENT 'D21',
  `parametro_17` DECIMAL(25,10) NOT NULL COMMENT 'D22',
  `parametro_18` DECIMAL(25,10) NOT NULL COMMENT 'D23',
  `parametro_19` DECIMAL(25,10) DEFAULT NULL COMMENT 'D24',
  `parametro_20` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D25',
  `parametro_21` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D26',
  `parametro_22` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D27',
  `parametro_23` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D28',
  `parametro_24` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D29',
  `parametro_25` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D30',
  `parametro_26` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D31',
  `parametro_27` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D32',
  `parametro_28` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D33',
  `parametro_29` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D34',
  `parametro_30` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D35',
  `parametro_31` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'D36',
  `parametro_32` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_33` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_34` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_35` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_36` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_37` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_38` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_39` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `parametro_40` DECIMAL(25,10) DEFAULT 0.000000 COMMENT '*no se usa*',
  `categoria_1` DECIMAL(25,10) NOT NULL COMMENT 'D36',
  `categoria_1_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_1_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_1_ia` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'F36',
  `categoria_1_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G36',
  `categoria_2` DECIMAL(25,10) NOT NULL COMMENT 'D37',
  `categoria_2_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_2_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_2_ia` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'F37',
  `categoria_2_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G37',
  `categoria_3` DECIMAL(25,10) NOT NULL COMMENT 'D38',
  `categoria_3_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_3_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_3_ia` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'F38',
  `categoria_3_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G38',
  `categoria_4` DECIMAL(25,10) NOT NULL COMMENT 'D39',
  `categoria_4_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_4_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_4_ia` DECIMAL(25,10) UNSIGNED DEFAULT 0.000000 COMMENT 'F39',
  `categoria_4_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G39',
  `categoria_5` DECIMAL(25,10) NOT NULL COMMENT 'D40',
  `categoria_5_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_5_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_5_ia` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'F40',
  `categoria_5_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G40',
  `categoria_6` DECIMAL(25,10) NOT NULL COMMENT 'D41',
  `categoria_6_ui` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_6_peso` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `categoria_6_ia` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'F41',
  `categoria_6_ie` DECIMAL(25,10) DEFAULT 0.000000 COMMENT 'G41',
  `total_enviado_gestor_residuos` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `embalajes_y_etiquetas` DECIMAL(25,10) DEFAULT NULL COMMENT '*lo calcula el trigger*',
  `user_id` INTEGER(11) NOT NULL COMMENT 'F3',
  `observaciones` MEDIUMTEXT COLLATE utf8_spanish2_ci,
  PRIMARY KEY USING BTREE (`id`),
  UNIQUE INDEX `demostrativo_id` USING BTREE (`demostrativo_id`, `date`),
   INDEX `demostrativo_diario_ibfk_2` USING BTREE (`user_id`),
  CONSTRAINT `demostrativo_diario_ibfk_1` FOREIGN KEY (`demostrativo_id`) REFERENCES `demostrativo` (`id`),
  CONSTRAINT `demostrativo_diario_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `members` (`id`)
)ENGINE=InnoDB  CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Structure for the `demostrativo_acumulativo` table : 
#

CREATE TABLE `demostrativo_acumulativo` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `demostrativo_id` INTEGER(11) NOT NULL,
  `demostrativo_diario_id` INTEGER(11) DEFAULT NULL,
  `date` DATE DEFAULT NULL,
  `equipos_procesados` INTEGER(11) DEFAULT NULL,
  `parametro_1` DECIMAL(25,10) DEFAULT NULL,
  `parametro_2` DECIMAL(25,10) DEFAULT NULL,
  `parametro_3` DECIMAL(25,10) DEFAULT NULL,
  `parametro_4` DECIMAL(25,10) DEFAULT NULL,
  `parametro_5` DECIMAL(25,10) DEFAULT NULL,
  `parametro_6` DECIMAL(25,10) DEFAULT NULL,
  `parametro_7` DECIMAL(25,10) DEFAULT NULL,
  `parametro_8` DECIMAL(25,10) DEFAULT NULL,
  `parametro_9` DECIMAL(25,10) DEFAULT NULL,
  `parametro_10` DECIMAL(25,10) DEFAULT NULL,
  `parametro_11` DECIMAL(25,10) DEFAULT NULL,
  `parametro_12` DECIMAL(25,10) DEFAULT NULL,
  `parametro_13` DECIMAL(25,10) DEFAULT NULL,
  `parametro_14` DECIMAL(25,10) DEFAULT NULL,
  `parametro_15` DECIMAL(25,10) DEFAULT NULL,
  `parametro_16` DECIMAL(25,10) DEFAULT NULL,
  `parametro_17` DECIMAL(25,10) DEFAULT NULL,
  `parametro_18` DECIMAL(25,10) DEFAULT NULL,
  `parametro_19` DECIMAL(25,10) DEFAULT NULL,
  `parametro_20` DECIMAL(25,10) DEFAULT NULL,
  `parametro_21` DECIMAL(25,10) DEFAULT NULL,
  `parametro_22` DECIMAL(25,10) DEFAULT NULL,
  `parametro_23` DECIMAL(25,10) DEFAULT NULL,
  `parametro_24` DECIMAL(25,10) DEFAULT NULL,
  `parametro_25` DECIMAL(25,10) DEFAULT NULL,
  `parametro_26` DECIMAL(25,10) DEFAULT NULL,
  `parametro_27` DECIMAL(25,10) DEFAULT NULL,
  `parametro_28` DECIMAL(25,10) DEFAULT NULL,
  `parametro_29` DECIMAL(25,10) DEFAULT NULL,
  `parametro_30` DECIMAL(25,10) DEFAULT NULL,
  `parametro_31` DECIMAL(25,10) DEFAULT NULL,
  `parametro_32` DECIMAL(25,10) DEFAULT NULL,
  `parametro_33` DECIMAL(25,10) DEFAULT NULL,
  `categoria_1` DECIMAL(25,10) DEFAULT NULL,
  `categoria_1_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_1_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_1_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_1_ie` DECIMAL(25,10) DEFAULT NULL,
  `categoria_2` DECIMAL(25,10) DEFAULT NULL,
  `categoria_2_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_2_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_2_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_2_ie` DECIMAL(25,10) DEFAULT NULL,
  `categoria_3` DECIMAL(25,10) DEFAULT NULL,
  `categoria_3_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_3_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_3_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_3_ie` DECIMAL(25,10) DEFAULT NULL,
  `categoria_4` DECIMAL(25,10) DEFAULT NULL,
  `categoria_4_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_4_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_4_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_4_ie` DECIMAL(25,10) DEFAULT NULL,
  `categoria_5` DECIMAL(25,10) DEFAULT NULL,
  `categoria_5_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_5_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_5_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_5_ie` DECIMAL(25,10) DEFAULT NULL,
  `categoria_6` DECIMAL(25,10) DEFAULT NULL,
  `categoria_6_ui` DECIMAL(25,10) DEFAULT NULL,
  `categoria_6_peso` DECIMAL(25,10) DEFAULT NULL,
  `categoria_6_ia` DECIMAL(25,10) DEFAULT NULL,
  `categoria_6_ie` DECIMAL(25,10) DEFAULT NULL,
  `total_enviado_gestor_residuos` DECIMAL(25,10) DEFAULT NULL,
  `embalajes_y_etiquetas` DECIMAL(25,10) DEFAULT NULL,
  `observaciones` MEDIUMTEXT COLLATE utf8_spanish2_ci,
  `parametro_34` DECIMAL(25,10) DEFAULT NULL,
  `parametro_35` DECIMAL(25,10) DEFAULT NULL,
  `parametro_36` DECIMAL(25,10) DEFAULT NULL,
  `parametro_37` DECIMAL(25,10) DEFAULT NULL,
  `parametro_38` DECIMAL(25,10) DEFAULT NULL,
  `parametro_39` DECIMAL(25,10) DEFAULT NULL,
  `parametro_40` DECIMAL(25,10) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`id`),
  UNIQUE INDEX `demostrativo_id` USING BTREE (`demostrativo_id`, `date`),
   INDEX `demostrativo_acumulativo_ibfk_2` USING BTREE (`demostrativo_diario_id`),
  CONSTRAINT `demostrativo_acumulativo_ibfk_1` FOREIGN KEY (`demostrativo_id`) REFERENCES `demostrativo` (`id`),
  CONSTRAINT `demostrativo_acumulativo_ibfk_2` FOREIGN KEY (`demostrativo_diario_id`) REFERENCES `demostrativo_diario` (`id`) ON DELETE CASCADE
)ENGINE=InnoDB CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Structure for the `login_attempts` table : 
#

CREATE TABLE `login_attempts` (
  `user_id` INTEGER(11) NOT NULL,
  `time` VARCHAR(30) COLLATE utf8_spanish_ci NOT NULL
)ENGINE=InnoDB CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci'
COMMENT=''
;

#
# Definition for the `set_dacumulativo_fecha` procedure : 
#
DELIMITER //
CREATE PROCEDURE `set_dacumulativo_fecha`(
        IN `v_demostrativo_diario_id` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  DECLARE var_demostrativo_id INT;
  DECLARE var_date DATE;
  
  SELECT demostrativo_id, date INTO var_demostrativo_id, var_date FROM demostrativo_diario WHERE id = v_demostrativo_diario_id;
  
  DELETE FROM demostrativo_acumulativo WHERE demostrativo_diario_id = v_demostrativo_diario_id;
    
  INSERT INTO demostrativo_acumulativo
      (
      demostrativo_id, parametro_1, parametro_2, parametro_3, parametro_4, parametro_5, parametro_6, parametro_7, parametro_8, parametro_9, parametro_10, 
      parametro_11, parametro_12, parametro_13, parametro_14, parametro_15, parametro_16, parametro_17, parametro_18, parametro_19, parametro_20, 
      parametro_21, parametro_22, parametro_23, parametro_24, parametro_25, parametro_26, parametro_27, parametro_28, parametro_29, parametro_30, 
      parametro_31, parametro_32, parametro_33, parametro_34, parametro_35, parametro_36, parametro_37, parametro_38, parametro_39, parametro_40, 
      
      categoria_1, categoria_1_ui, categoria_1_peso,
      categoria_2, categoria_2_ui, categoria_2_peso,
      categoria_3, categoria_3_ui, categoria_3_peso,
      categoria_4, categoria_4_ui, categoria_4_peso, 
      categoria_5, categoria_5_ui, categoria_5_peso,
      categoria_6, categoria_6_ui, categoria_6_peso,
      total_enviado_gestor_residuos, embalajes_y_etiquetas,
      `date`, equipos_procesados, demostrativo_diario_id)   
    SELECT  
        demostrativo_id,
        SUM(parametro_1) AS parametro_1, 
        SUM(parametro_2) AS parametro_2,
        SUM( parametro_3)AS parametro_3,
        SUM( parametro_4) AS parametro_4, 
        SUM( parametro_5) AS parametro_5, 
        SUM( parametro_6) AS parametro_6, 
        SUM( parametro_7) AS parametro_7, 
        SUM( parametro_8) AS parametro_8, 
        SUM( parametro_9) AS parametro_9, 
        SUM( parametro_10) AS parametro_10, 
        SUM(parametro_11) AS parametro_11, 
        SUM(parametro_12) AS parametro_12,
        SUM( parametro_13)AS parametro_13,
        SUM( parametro_14) AS parametro_14, 
        SUM( parametro_15) AS parametro_15, 
        SUM( parametro_16) AS parametro_16, 
        SUM( parametro_17) AS parametro_17, 
        SUM( parametro_18) AS parametro_18, 
        SUM( parametro_19) AS parametro_19, 
        SUM( parametro_20) AS parametro_20, 
        SUM(parametro_21) AS parametro_21, 
        SUM(parametro_22) AS parametro_22,
        SUM( parametro_23)AS parametro_23,
        SUM( parametro_24) AS parametro_24, 
        SUM( parametro_25) AS parametro_25, 
        SUM( parametro_26) AS parametro_26, 
        SUM( parametro_27) AS parametro_27, 
        SUM( parametro_28) AS parametro_28, 
        SUM( parametro_29) AS parametro_29, 
        SUM( parametro_30) AS parametro_30, 
        
        
        SUM(parametro_31) AS parametro_31, 
        SUM(parametro_32) AS parametro_32,
        SUM( parametro_33)AS parametro_33,
        SUM( parametro_34) AS parametro_34, 
        SUM( parametro_35) AS parametro_35, 
        SUM( parametro_36) AS parametro_36, 
        SUM( parametro_37) AS parametro_37, 
        SUM( parametro_38) AS parametro_38, 
        SUM( parametro_39) AS parametro_39, 
        SUM( parametro_40) AS parametro_40, 
        
        SUM( categoria_1) AS categoria_1, 
        SUM( categoria_1_ui) AS categoria_1_ui, 
        SUM( categoria_1_peso) AS categoria_1_peso, 
        
        SUM( categoria_2) AS categoria_2, 
        SUM( categoria_2_ui) AS categoria_2_ui, 
        SUM( categoria_2_peso) AS categoria_2_peso, 
        
        SUM( categoria_3) AS categoria_3, 
        SUM( categoria_3_ui) AS categoria_3_ui, 
        SUM( categoria_3_peso) AS categoria_3_peso, 
        
        SUM( categoria_4) AS categoria_4, 
        SUM( categoria_4_ui) AS categoria_4_ui, 
        SUM( categoria_4_peso) AS categoria_4_peso, 
        
        SUM( categoria_5) AS categoria_5, 
        SUM( categoria_5_ui) AS categoria_5_ui,
        SUM( categoria_5_peso) AS categoria_5_peso, 
        
        SUM( categoria_6) AS categoria_6, 
        SUM( categoria_6_ui) AS categoria_6_ui,
        SUM( categoria_6_peso) AS categoria_6_peso,
        
        SUM( total_enviado_gestor_residuos) AS total_enviado_gestor_residuos,
        SUM( embalajes_y_etiquetas) AS embalajes_y_etiquetas,
        
        CONCAT("",var_date) AS date, 
        SUM(equipos_procesados) AS equipos_procesados   ,
        v_demostrativo_diario_id
      FROM demostrativo_diario      
      WHERE demostrativo_id = var_demostrativo_id
      AND `date` <= var_date;   
END//
DELIMITER ;
#
# Definition for the `check_data_demostrativo_diario` procedure : 
#
DELIMITER //
CREATE DEFINER = 'energylab_demo'@'%' PROCEDURE `check_data_demostrativo_diario`(
        IN `v_demostrativo_diario_id` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN  
  DECLARE v_categoria_1 DECIMAL(50, 6);
  DECLARE v_categoria_1_ia DECIMAL(50, 6);
  DECLARE v_categoria_1_ie DECIMAL(50, 6);
  DECLARE v_categoria_1_peso DECIMAL(50, 6);
  DECLARE v_categoria_1_ui DECIMAL(50, 6);

  DECLARE v_categoria_2 DECIMAL(50, 6);
  DECLARE v_categoria_2_ia DECIMAL(50, 6);
  DECLARE v_categoria_2_ie DECIMAL(50, 6);
  DECLARE v_categoria_2_peso DECIMAL(50, 6);
  DECLARE v_categoria_2_ui DECIMAL(50, 6);

  DECLARE v_categoria_3 DECIMAL(50, 6);
  DECLARE v_categoria_3_ia DECIMAL(50, 6);
  DECLARE v_categoria_3_ie DECIMAL(50, 6);
  DECLARE v_categoria_3_peso DECIMAL(50, 6);
  DECLARE v_categoria_3_ui DECIMAL(50, 6);

  DECLARE v_categoria_4 DECIMAL(50, 6);
  DECLARE v_categoria_4_ia DECIMAL(50, 6);
  DECLARE v_categoria_4_ie DECIMAL(50, 6);
  DECLARE v_categoria_4_peso DECIMAL(50, 6);
  DECLARE v_categoria_4_ui DECIMAL(50, 6);

  DECLARE v_categoria_5 DECIMAL(50, 6);
  DECLARE v_categoria_5_ia DECIMAL(50, 6);
  DECLARE v_categoria_5_ie DECIMAL(50, 6);
  DECLARE v_categoria_5_peso DECIMAL(50, 6);
  DECLARE v_categoria_5_ui DECIMAL(50, 6);

  DECLARE v_categoria_6 DECIMAL(50, 6);
  DECLARE v_categoria_6_ia DECIMAL(50, 6);
  DECLARE v_categoria_6_ie DECIMAL(50, 6);
  DECLARE v_categoria_6_peso DECIMAL(50, 6);
  DECLARE v_categoria_6_ui DECIMAL(50, 6);
  
  
  DECLARE v_parametro_10 DECIMAL(50, 6);
  DECLARE v_parametro_11 DECIMAL(50, 6);
  DECLARE v_parametro_12 DECIMAL(50, 6);
  DECLARE v_parametro_13 DECIMAL(50, 6);
  DECLARE v_parametro_14 DECIMAL(50, 6);
  DECLARE v_parametro_15 DECIMAL(50, 6);
  DECLARE v_parametro_16 DECIMAL(50, 6);
  DECLARE v_parametro_17 DECIMAL(50, 6);
  DECLARE v_parametro_18 DECIMAL(50, 6);
  DECLARE v_parametro_19 DECIMAL(50, 6);
  DECLARE v_parametro_20 DECIMAL(50, 6);
  DECLARE v_parametro_4 DECIMAL(50, 6);
  DECLARE v_parametro_5 DECIMAL(50, 6);  

  DECLARE v_total_enviado_gestor_residuos DECIMAL(50, 6);
  DECLARE v_embalajes_y_etiquetas DECIMAL(50, 6);



  SELECT categoria_1, categoria_1_ui, categoria_1_peso, categoria_1_ia, categoria_1_ie, categoria_2, categoria_2_ui, categoria_2_peso, categoria_2_ia, categoria_2_ie, categoria_3, categoria_3_ui, categoria_3_peso, categoria_3_ia, categoria_3_ie, categoria_4, categoria_4_ui, categoria_4_peso, categoria_4_ia, categoria_4_ie, categoria_5, categoria_5_ui, categoria_5_peso, categoria_5_ia, categoria_5_ie, categoria_6, categoria_6_ui, categoria_6_peso, categoria_6_ia, categoria_6_ie, total_enviado_gestor_residuos, embalajes_y_etiquetas, parametro_4, parametro_5, parametro_10,	parametro_11,	parametro_12,	parametro_13,	parametro_14,	parametro_15,	parametro_16,	parametro_17,	parametro_18,	parametro_19,	parametro_20
  INTO v_categoria_1, v_categoria_1_ui, v_categoria_1_peso, v_categoria_1_ia, v_categoria_1_ie, v_categoria_2, v_categoria_2_ui, v_categoria_2_peso, v_categoria_2_ia, v_categoria_2_ie, v_categoria_3, v_categoria_3_ui, v_categoria_3_peso, v_categoria_3_ia, v_categoria_3_ie, v_categoria_4, v_categoria_4_ui, v_categoria_4_peso, v_categoria_4_ia, v_categoria_4_ie, v_categoria_5, v_categoria_5_ui, v_categoria_5_peso, v_categoria_5_ia, v_categoria_5_ie, v_categoria_6, v_categoria_6_ui, v_categoria_6_peso, v_categoria_6_ia, v_categoria_6_ie, v_total_enviado_gestor_residuos, v_embalajes_y_etiquetas, v_parametro_4, v_parametro_5, v_parametro_10, v_parametro_11, v_parametro_12, v_parametro_13, v_parametro_14, v_parametro_15, v_parametro_16, v_parametro_17, v_parametro_18, v_parametro_19, v_parametro_20
  FROM demostrativo_diario
  WHERE id = v_demostrativo_diario_id;


	IF v_categoria_1 < 0   THEN SET v_categoria_1=v_categoria_1*-1;    END IF;
  IF v_categoria_1_ia < 0   THEN SET v_categoria_1_ia=v_categoria_1_ia*-1;    END IF;
  IF v_categoria_1_ie < 0   THEN SET v_categoria_1_ie=v_categoria_1_ie*-1;    END IF;
  IF v_categoria_1_peso < 0   THEN SET v_categoria_1_peso=v_categoria_1_peso*-1;    END IF;
  IF v_categoria_1_ui < 0   THEN SET v_categoria_1_ui=v_categoria_1_ui*-1;    END IF;
  IF v_categoria_2 < 0   THEN SET v_categoria_2=v_categoria_2*-1;    END IF;
  IF v_categoria_2_ia < 0   THEN SET v_categoria_2_ia=v_categoria_2_ia*-1;    END IF;
  IF v_categoria_2_ie < 0   THEN SET v_categoria_2_ie=v_categoria_2_ie*-1;    END IF;
  IF v_categoria_2_peso < 0   THEN SET v_categoria_2_peso=v_categoria_2_peso*-1;    END IF;
  IF v_categoria_2_ui < 0   THEN SET v_categoria_2_ui=v_categoria_2_ui*-1;    END IF;
  IF v_categoria_3 < 0   THEN SET v_categoria_3=v_categoria_3*-1;    END IF;
  IF v_categoria_3_ia < 0   THEN SET v_categoria_3_ia=v_categoria_3_ia*-1;    END IF;
  IF v_categoria_3_ie < 0   THEN SET v_categoria_3_ie=v_categoria_3_ie*-1;    END IF;
  IF v_categoria_3_peso < 0   THEN SET v_categoria_3_peso=v_categoria_3_peso*-1;    END IF;
  IF v_categoria_3_ui < 0   THEN SET v_categoria_3_ui=v_categoria_3_ui*-1;    END IF;
  IF v_categoria_4 < 0   THEN SET v_categoria_4=v_categoria_4*-1;    END IF;
  IF v_categoria_4_ia < 0   THEN SET v_categoria_4_ia=v_categoria_4_ia*-1;    END IF;
  IF v_categoria_4_ie < 0   THEN SET v_categoria_4_ie=v_categoria_4_ie*-1;    END IF;
  IF v_categoria_4_peso < 0   THEN SET v_categoria_4_peso=v_categoria_4_peso*-1;    END IF;
  IF v_categoria_4_ui < 0   THEN SET v_categoria_4_ui=v_categoria_4_ui*-1;    END IF;
  IF v_categoria_5 < 0   THEN SET v_categoria_5=v_categoria_5*-1;    END IF;
  IF v_categoria_5_ia < 0   THEN SET v_categoria_5_ia=v_categoria_5_ia*-1;    END IF;
  IF v_categoria_5_ie < 0   THEN SET v_categoria_5_ie=v_categoria_5_ie*-1;    END IF;
  IF v_categoria_5_peso < 0   THEN SET v_categoria_5_peso=v_categoria_5_peso*-1;    END IF;
  IF v_categoria_5_ui < 0   THEN SET v_categoria_5_ui=v_categoria_5_ui*-1;    END IF;
  IF v_categoria_6 < 0   THEN SET v_categoria_6=v_categoria_6*-1;    END IF;
  IF v_categoria_6_ia < 0   THEN SET v_categoria_6_ia=v_categoria_6_ia*-1;    END IF;
  IF v_categoria_6_ie < 0   THEN SET v_categoria_6_ie=v_categoria_6_ie*-1;    END IF;
  IF v_categoria_6_peso < 0   THEN SET v_categoria_6_peso=v_categoria_6_peso*-1;    END IF;
  IF v_categoria_6_ui < 0   THEN SET v_categoria_6_ui=v_categoria_6_ui*-1;    END IF;

  
  SET v_categoria_1_ui = v_categoria_1/5.77*100;
  SET v_categoria_1_peso = v_categoria_1*26.7/122;
  SET v_categoria_2_ui = v_categoria_2/2.82*100;
  SET v_categoria_2_peso = v_categoria_2*18.8/1210;
  SET v_categoria_3_ui = v_categoria_3/16.4*100;
  SET v_categoria_3_peso = v_categoria_3*(13.9/448+1.65/448);
  SET v_categoria_4_ui = v_categoria_4/0.0189*100;
  SET v_categoria_4_peso = v_categoria_4*4.92/0.851;
  SET v_categoria_5_ui = v_categoria_5/1.05*100;
  SET v_categoria_5_peso = v_categoria_5*0.278/286;
  SET v_categoria_6_ui = v_categoria_6/3.66*100;
  SET v_categoria_6_peso = v_categoria_6*0.0669/183;
  
  SET v_total_enviado_gestor_residuos =  v_parametro_10 + v_parametro_11 + v_parametro_12 + v_parametro_13 + v_parametro_14 + v_parametro_15 + v_parametro_16 + v_parametro_17 + v_parametro_18 + v_parametro_19 + v_parametro_20;
  SET v_embalajes_y_etiquetas = v_parametro_4 + v_parametro_5;
  
  
  UPDATE demostrativo_diario SET 
    categoria_1 = v_categoria_1,
    categoria_1_ui  = v_categoria_1_ui ,
    categoria_1_peso  = v_categoria_1_peso ,
    categoria_1_ia  = v_categoria_1_ia ,
    categoria_1_ie  = v_categoria_1_ie ,
    categoria_2  = v_categoria_2 ,
    categoria_2_ui  = v_categoria_2_ui ,
    categoria_2_peso = v_categoria_2_peso,
    categoria_2_ia  = v_categoria_2_ia ,
    categoria_2_ie  = v_categoria_2_ie ,
    categoria_3  = v_categoria_3 ,
    categoria_3_ui  = v_categoria_3_ui ,
    categoria_3_peso  = v_categoria_3_peso ,
    categoria_3_ia  = v_categoria_3_ia ,
    categoria_3_ie  = v_categoria_3_ie ,
    categoria_4  = v_categoria_4 ,
    categoria_4_ui  = v_categoria_4_ui ,
    categoria_4_peso  = v_categoria_4_peso ,
    categoria_4_ia  = v_categoria_4_ia ,
    categoria_4_ie  = v_categoria_4_ie ,
    categoria_5  = v_categoria_5 ,
    categoria_5_ui  = v_categoria_5_ui ,
    categoria_5_peso  = v_categoria_5_peso ,
    categoria_5_ia  = v_categoria_5_ia ,
    categoria_5_ie  = v_categoria_5_ie ,
    categoria_6  = v_categoria_6 ,
    categoria_6_ui  = v_categoria_6_ui ,
    categoria_6_peso  = v_categoria_6_peso ,
    categoria_6_ia  = v_categoria_6_ia ,
    categoria_6_ie  = v_categoria_6_ie ,
    total_enviado_gestor_residuos  = v_total_enviado_gestor_residuos ,
    embalajes_y_etiquetas  = v_embalajes_y_etiquetas
    WHERE id = v_demostrativo_diario_id;    
    
    CALL set_dacumulativo_fecha(v_demostrativo_diario_id );
END//
DELIMITER ;
#
# Definition for the `insert_test_data` procedure : 
#
DELIMITER //
CREATE PROCEDURE `insert_test_data`(
        IN `n_dias` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN

DECLARE v_categoria_1 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_1_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_1_ie decimal(25,10) DEFAULT 0;
DECLARE v_categoria_2 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_2_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_2_ie decimal(25,10) DEFAULT 0;
DECLARE v_categoria_3 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_3_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_3_ie decimal(25,10) DEFAULT 0;
DECLARE v_categoria_4 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_4_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_4_ie decimal(25,10) DEFAULT 0;
DECLARE v_categoria_5 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_5_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_5_ie decimal(25,10) DEFAULT 0;
DECLARE v_categoria_6 decimal(25,10) DEFAULT 0;
DECLARE v_categoria_6_ia decimal(25,10) DEFAULT 0;
DECLARE v_categoria_6_ie decimal(25,10) DEFAULT 0;
DECLARE v_equipos_procesados int(11) DEFAULT 0;
DECLARE v_parametro_1 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_10 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_11 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_12 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_13 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_14 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_15 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_16 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_17 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_18 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_19 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_2 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_20 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_21 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_22 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_23 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_24 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_25 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_26 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_27 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_28 decimal(25,10) DEFAULT 0;

DECLARE v_parametro_29 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_30 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_31 decimal(25,10) DEFAULT 0;

/*DECLARE v_parametro_32 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_33 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_34 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_35 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_36 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_37 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_38 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_39 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_10 decimal(25,10) DEFAULT 0;*/

DECLARE v_parametro_3 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_4 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_5 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_6 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_7 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_8 decimal(25,10) DEFAULT 0;
DECLARE v_parametro_9 decimal(25,10) DEFAULT 0;
DECLARE v_user_id int(11);
DECLARE v_date DATE;

DECLARE v_new_demostrativo_diario_id int(11);

DECLARE v_demostrativo_id INT DEFAULT 4;
DECLARE i INT;
DECLARE j INT;

truncate table demostrativo_acumulativo;
truncate table demostrativo_diario;

SET i = 0; 
SET j = 0; 
label1: LOOP   
        
        SET v_demostrativo_id = 4;     
          label2: LOOP   
                SET j = j + 1;
                -- ROUND((RAND() * (max-min))+min)
               
                SET   v_equipos_procesados = ROUND((RAND() * (35-5))+5);  
                SET   v_parametro_1 = v_equipos_procesados + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_2 = v_equipos_procesados * 5 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_3 = v_equipos_procesados * 5.82 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_4 = v_equipos_procesados * 30 / 16 + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_5 = v_equipos_procesados * 1 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_6 = v_equipos_procesados * 100 / 16 + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_7 = v_equipos_procesados * 2.86 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_8 = v_equipos_procesados * 32.14 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_9 = v_equipos_procesados * 33 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_10 = v_equipos_procesados * 72 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_11 = v_equipos_procesados * 15 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_12 = v_equipos_procesados * 45 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_13 = v_equipos_procesados * 2.86 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_14 = v_equipos_procesados * 3 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_15 = v_equipos_procesados * 49.2 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_16 = v_equipos_procesados * 49.2 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_17 = v_equipos_procesados * 24.85 / 16  + ROUND((RAND() * (100-10))+10);
                SET   v_parametro_18 = v_equipos_procesados * 9 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_19 = v_equipos_procesados * 7 / 16  + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_20 = v_equipos_procesados * 4.59 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_21 = v_equipos_procesados * 5 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_22 = v_equipos_procesados * 2 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_23 = v_equipos_procesados * 2 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_24 = v_equipos_procesados * 16 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_25 = v_equipos_procesados * 1 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_26 = v_equipos_procesados * 5 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_27 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_28 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);               
                
                
                SET   v_parametro_29 = v_equipos_procesados * 6.5 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_30 = v_equipos_procesados * 4.6 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_31 = v_equipos_procesados * 8 / 16 + ROUND((RAND() * (10-1))+1);
                
            /*  SET   v_parametro_32 = v_equipos_procesados * 1 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_33 = v_equipos_procesados * 2 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_34 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_35 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_36 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_37 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_38 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_39 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);
                SET   v_parametro_40 = v_equipos_procesados * 3 / 16 + ROUND((RAND() * (10-1))+1);*/
                
                
                SET v_categoria_1_ia = (0.613 * v_parametro_7 + 0.0873 * v_parametro_8 + 0.153 * v_parametro_9 + (v_parametro_7+v_parametro_8+v_parametro_9)/3*0.0602)+(0.0847*v_parametro_10+0.0873*v_parametro_11+0.0873*v_parametro_12+0.0939*v_parametro_13+0.0939*v_parametro_14+0.0873*v_parametro_15+0.0915*v_parametro_16+0.0966*v_parametro_17+0.0104*v_parametro_18+0.0165*v_parametro_19+0.0106*v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20) / 11 * 0.184));
                SET v_categoria_2_ia = (1.06*v_parametro_7+0.0547*v_parametro_8+0.766*v_parametro_9+(v_parametro_7+v_parametro_8+v_parametro_9)/3*0.0456)+(0.0342*v_parametro_10+0.0547*v_parametro_11+0.0547*v_parametro_12+0.0819*v_parametro_13+0.0819*v_parametro_14+0.0547*v_parametro_15+0.064*v_parametro_16+0.0755*v_parametro_17+0.0894*v_parametro_18+0.949*v_parametro_19+0.0995*v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20)/11*0.139));
                SET v_categoria_3_ia = (0.613*v_parametro_7+0.0873*v_parametro_8+0.153*v_parametro_9+(v_parametro_7+v_parametro_8+v_parametro_9)/3*0.0602)+(0.168*v_parametro_10+0.277*v_parametro_11+0.277*v_parametro_12+0.3*v_parametro_13+0.3*v_parametro_14+0.277*v_parametro_15+0.291*v_parametro_16+0.309*v_parametro_17+0.332*v_parametro_18+0.552*v_parametro_19+0.341*v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20)/11*0.521));
                SET v_categoria_4_ia = (0.00499*  v_parametro_7+0.000247*  v_parametro_8+0.00294*  v_parametro_9+(  v_parametro_7+  v_parametro_8+  v_parametro_9)/3*0.000306)+(0.000228*  v_parametro_10+0.000247*  v_parametro_11+0.000247*  v_parametro_12+0.000309*  v_parametro_13+0.000309*  v_parametro_14+0.000247*  v_parametro_15+0.000288*  v_parametro_16+0.000338*  v_parametro_17+0.000406*  v_parametro_18+0.00487*  v_parametro_19+0.000429*  v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20)/11*0.000935));
                SET v_categoria_5_ia = (0.1*  v_parametro_7+0.00777*  v_parametro_8+0.429*  v_parametro_9+(  v_parametro_7+  v_parametro_8+  v_parametro_9)/3*0.0158)+(0.0719*  v_parametro_10+0.00777*  v_parametro_11+0.00777*  v_parametro_12+0.013*  v_parametro_13+0.013*  v_parametro_14+0.00777*  v_parametro_15+0.00881*  v_parametro_16+0.0101*  v_parametro_17+0.0114*  v_parametro_18+0.46*  v_parametro_19+0.0133*  v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20)/11*0.0483));
                SET v_categoria_6_ia = (2.25*v_parametro_7+0.03*v_parametro_8+0.188*v_parametro_9+(v_parametro_7+v_parametro_8+v_parametro_9)/3*0.0364)+(0.0266*v_parametro_10+0.03*v_parametro_11+0.03*v_parametro_12+0.0567*v_parametro_13+0.0567*v_parametro_14+0.03*v_parametro_15+0.0496*v_parametro_16+0.0741*v_parametro_17+0.108*v_parametro_18+0.229*v_parametro_19+0.118*v_parametro_20+((v_parametro_10+v_parametro_11+v_parametro_12+v_parametro_13+v_parametro_14+v_parametro_15+v_parametro_16+v_parametro_17+v_parametro_18+v_parametro_19+v_parametro_20)/11*0.111));
               
                SET v_categoria_1_ie = 3.54*  v_parametro_28+2.5*  v_parametro_21+1.65*  v_parametro_22+40.6*  v_parametro_23+28.2*  v_parametro_24+43.7*  v_parametro_25+3.76*  v_parametro_26+0.712*  v_parametro_27;              
                SET v_categoria_2_ie = 21.2*  v_parametro_28+37.5*  v_parametro_21+18.1*  v_parametro_22+266*  v_parametro_23+469*  v_parametro_24+340*  v_parametro_25+49*  v_parametro_26+11.3*  v_parametro_27;
                SET v_categoria_3_ie = 11.6*  v_parametro_28+8.57*  v_parametro_21+6.13*  v_parametro_22+142*  v_parametro_23+103*  v_parametro_24+168*  v_parametro_25+12.9*  v_parametro_26+2.53*  v_parametro_27;
                SET v_categoria_4_ie = 0.0279*  v_parametro_28+0.0186*  v_parametro_21+0.0122*  v_parametro_22+0.228*  v_parametro_23+0.224*  v_parametro_24+0.325*  v_parametro_25+0.0267*  v_parametro_26+0.00533*  v_parametro_27;
                SET v_categoria_5_ie = 25.8*  v_parametro_28+9.51*  v_parametro_21+4.13*  v_parametro_22+59.1*  v_parametro_23+103*  v_parametro_24+72.7*  v_parametro_25+10.9*  v_parametro_26+2.14*  v_parametro_27;
                SET v_categoria_6_ie = 5.52*  v_parametro_28+3.72*  v_parametro_21+2.52*  v_parametro_22+80.2*  v_parametro_23+43.7*  v_parametro_24+45.7*  v_parametro_25+4.34*  v_parametro_26+1.09*  v_parametro_27;
                
                SET v_categoria_1 = v_categoria_1_ia - v_categoria_1_ie;
                SET v_categoria_2 = v_categoria_2_ia - v_categoria_2_ie;
                SET v_categoria_3 = v_categoria_3_ia - v_categoria_3_ie;
                SET v_categoria_4 = v_categoria_4_ia - v_categoria_4_ie;
                SET v_categoria_5 = v_categoria_5_ia - v_categoria_5_ie;
                SET v_categoria_6 = v_categoria_6_ia - v_categoria_6_ie; 
                
                SET v_user_id = (select id from members where demostrativo_id = v_demostrativo_id LIMIT 1); 
                
                SET v_date =  date_sub(curdate(), interval n_dias-i day);
              
                insert into demostrativo_diario (
                  demostrativo_id
                  ,`date`
                  ,equipos_procesados
                  ,parametro_1
                  ,parametro_2
                  ,parametro_3
                  ,parametro_4
                  ,parametro_5
                  ,parametro_6
                  ,parametro_7
                  ,parametro_8
                  ,parametro_9
                  ,parametro_10
                  ,parametro_11
                  ,parametro_12
                  ,parametro_13
                  ,parametro_14
                  ,parametro_15
                  ,parametro_16
                  ,parametro_17
                  ,parametro_18
                  ,parametro_19
                  ,parametro_20
                  ,parametro_21
                  ,parametro_22
                  ,parametro_23
                  ,parametro_24
                  ,parametro_25
                  ,parametro_26
                  ,parametro_27
                  ,parametro_28
                  
                  ,parametro_29
                  ,parametro_30
                  ,parametro_31
               /*
                ,parametro_32
                ,parametro_33
                ,parametro_34
                ,parametro_35
                ,parametro_36
                ,parametro_37
                ,parametro_38
                ,parametro_39
                ,parametro_40 */
                  
                  ,categoria_1
                  ,categoria_1_ia
                  ,categoria_1_ie
                  ,categoria_2
                  ,categoria_2_ia
                  ,categoria_2_ie
                  ,categoria_3
                  ,categoria_3_ia
                  ,categoria_3_ie
                  ,categoria_4
                  ,categoria_4_ia
                  ,categoria_4_ie
                  ,categoria_5
                  ,categoria_5_ia
                  ,categoria_5_ie
                  ,categoria_6
                  ,categoria_6_ia
                  ,categoria_6_ie
                  ,user_id
                  ,observaciones
              ) VALUES (
                v_demostrativo_id,
                v_date,
                v_equipos_procesados,
                v_parametro_1,
                v_parametro_2,
                v_parametro_3,
                v_parametro_4,
                v_parametro_5,
                v_parametro_6,
                v_parametro_7,
                v_parametro_8,
                v_parametro_9,
                v_parametro_10,
                v_parametro_11,
                v_parametro_12,
                v_parametro_13,
                v_parametro_14,
                v_parametro_15,
                v_parametro_16,
                v_parametro_17,
                v_parametro_18,
                v_parametro_19,
                v_parametro_20,
                v_parametro_21,
                v_parametro_22,
                v_parametro_23,
                v_parametro_24,
                v_parametro_25,
                v_parametro_26,
                v_parametro_27,
                v_parametro_28,
                
                
                v_parametro_29,
                v_parametro_30,
                v_parametro_31,
               /* v_parametro_32,
                v_parametro_33,
                v_parametro_34,
                v_parametro_35,
                v_parametro_36,
                v_parametro_37,
                v_parametro_38,
                v_parametro_39,
                v_parametro_40,*/
                
                
                
                v_categoria_1,
                v_categoria_1_ia,
                v_categoria_1_ie,
                v_categoria_2,
                v_categoria_2_ia,
                v_categoria_2_ie,
                v_categoria_3,
                v_categoria_3_ia,
                v_categoria_3_ie,
                v_categoria_4,
                v_categoria_4_ia,
                v_categoria_4_ie,
                v_categoria_5,
                v_categoria_5_ia,
                v_categoria_5_ie,
                v_categoria_6,
                v_categoria_6_ia,
                v_categoria_6_ie,
                v_user_id,
                CONCAT(j,"_")
              );        
              SELECT id INTO v_new_demostrativo_diario_id FROM demostrativo_diario WHERE observaciones LIKE CONCAT(j,"_");
              CALL check_data_demostrativo_diario(v_new_demostrativo_diario_id);
            
              
              SET v_demostrativo_id = v_demostrativo_id - 1;
        	 
            IF v_demostrativo_id > 0
              THEN ITERATE label2; 
            END IF;
            LEAVE label2;                            
                    
        END LOOP label2;     
                    
    
    SET i = i + 1; 
	 
    IF i < n_dias 
      THEN ITERATE label1; 
      END IF;
    LEAVE label1;
END LOOP label1;   

END//
DELIMITER ;
#
# Definition for the `update_acumulativos_from_date` procedure : 
#
DELIMITER //
CREATE DEFINER = 'energylab_demo'@'%' PROCEDURE `update_acumulativos_from_date`(
        IN `var_demostrativo_id` INTEGER,
        IN `var_date` DATE
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    DECLARE i INT;
    DECLARE last_date DATE;
    DECLARE last_id INT;
    
    UPDATE demostrativo SET is_loading = 1 WHERE id = var_demostrativo_id;
    
    SET i = 0;   
    SET last_date = (SELECT date FROM demostrativo_diario WHERE demostrativo_id = var_demostrativo_id ORDER BY date DESC LIMIT 1);

    DELETE FROM demostrativo_acumulativo
      WHERE demostrativo_id = var_demostrativo_id
      AND `date` >= var_date;  

    label1: LOOP
      SET last_id = (SELECT id FROM demostrativo_diario WHERE demostrativo_id = var_demostrativo_id AND date LIKE date_add(var_date, interval i day));
	  IF last_id > 0 THEN       
	    CALL set_dacumulativo_fecha(last_id); 
      END IF;
      SET i = i + 1;        
      IF date_add(var_date, interval i day) <= last_date 
        THEN ITERATE label1; 
      END IF;
      LEAVE label1;    
    END LOOP label1;
    UPDATE demostrativo SET is_loading = 0 WHERE id = var_demostrativo_id;
 END//
DELIMITER ;
#
# Definition for the `demostrativo_1_diario` view : 
#

CREATE  VIEW `demostrativo_1_diario`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_diario` `d` 
  where 
    (`d`.`demostrativo_id` = 1) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_1` view : 
#

CREATE  VIEW `demostrativo_1`
AS
select 
    `demostrativo_1_diario`.`id` AS `id`,
    `demostrativo_1_diario`.`date` AS `date`,
    `demostrativo_1_diario`.`categoria_1` AS `categoria_1`,
    `demostrativo_1_diario`.`categoria_2` AS `categoria_2`,
    `demostrativo_1_diario`.`categoria_3` AS `categoria_3`,
    `demostrativo_1_diario`.`categoria_4` AS `categoria_4`,
    `demostrativo_1_diario`.`categoria_5` AS `categoria_5`,
    `demostrativo_1_diario`.`categoria_6` AS `categoria_6`,
    `demostrativo_1_diario`.`equipos_procesados` AS `equipos_procesados` 
  from 
    `demostrativo_1_diario`;

#
# Definition for the `demostrativo_1_acumulativo` view : 
#

CREATE  VIEW `demostrativo_1_acumulativo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 1) 
  order by 
    `d`.`date` desc limit 1;

#
# Definition for the `demostrativo_1_acumulativo_todo` view : 
#

CREATE  VIEW `demostrativo_1_acumulativo_todo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_1` AS `parametro_1`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`parametro_4` AS `parametro_4`,
    `d`.`parametro_5` AS `parametro_5`,
    `d`.`parametro_6` AS `parametro_6`,
    `d`.`parametro_7` AS `parametro_7`,
    `d`.`parametro_8` AS `parametro_8`,
    `d`.`parametro_9` AS `parametro_9`,
    `d`.`parametro_10` AS `parametro_10`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    `d`.`parametro_26` AS `parametro_26`,
    `d`.`parametro_27` AS `parametro_27`,
    `d`.`parametro_28` AS `parametro_28`,
    `d`.`parametro_29` AS `parametro_29`,
    `d`.`parametro_30` AS `parametro_30`,
    `d`.`parametro_31` AS `parametro_31`,
    `d`.`parametro_32` AS `parametro_32`,
    `d`.`parametro_33` AS `parametro_33`,
    `d`.`parametro_34` AS `parametro_34`,
    `d`.`parametro_35` AS `parametro_35`,
    `d`.`parametro_36` AS `parametro_36`,
    `d`.`parametro_37` AS `parametro_37`,
    `d`.`parametro_38` AS `parametro_38`,
    `d`.`parametro_39` AS `parametro_39`,
    `d`.`parametro_40` AS `parametro_40`,
    `d`.`categoria_1` AS `categoria_1`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    `d`.`categoria_2` AS `categoria_2`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    `d`.`categoria_3` AS `categoria_3`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    `d`.`categoria_4` AS `categoria_4`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    `d`.`categoria_5` AS `categoria_5`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    `d`.`categoria_6` AS `categoria_6`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 1) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_2_diario` view : 
#

CREATE  VIEW `demostrativo_2_diario`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_diario` `d` 
  where 
    (`d`.`demostrativo_id` = 2) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_2` view : 
#

CREATE  VIEW `demostrativo_2`
AS
select 
    `demostrativo_2_diario`.`id` AS `id`,
    `demostrativo_2_diario`.`date` AS `date`,
    `demostrativo_2_diario`.`categoria_1` AS `categoria_1`,
    `demostrativo_2_diario`.`categoria_2` AS `categoria_2`,
    `demostrativo_2_diario`.`categoria_3` AS `categoria_3`,
    `demostrativo_2_diario`.`categoria_4` AS `categoria_4`,
    `demostrativo_2_diario`.`categoria_5` AS `categoria_5`,
    `demostrativo_2_diario`.`categoria_6` AS `categoria_6`,
    `demostrativo_2_diario`.`equipos_procesados` AS `equipos_procesados` 
  from 
    `demostrativo_2_diario`;

#
# Definition for the `demostrativo_2_acumulativo` view : 
#

CREATE  VIEW `demostrativo_2_acumulativo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 2) 
  order by 
    `d`.`date` desc limit 1;

#
# Definition for the `demostrativo_2_acumulativo_todo` view : 
#

CREATE  VIEW `demostrativo_2_acumulativo_todo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_1` AS `parametro_1`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`parametro_4` AS `parametro_4`,
    `d`.`parametro_5` AS `parametro_5`,
    `d`.`parametro_6` AS `parametro_6`,
    `d`.`parametro_7` AS `parametro_7`,
    `d`.`parametro_8` AS `parametro_8`,
    `d`.`parametro_9` AS `parametro_9`,
    `d`.`parametro_10` AS `parametro_10`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    `d`.`parametro_26` AS `parametro_26`,
    `d`.`parametro_27` AS `parametro_27`,
    `d`.`parametro_28` AS `parametro_28`,
    `d`.`parametro_29` AS `parametro_29`,
    `d`.`parametro_30` AS `parametro_30`,
    `d`.`parametro_31` AS `parametro_31`,
    `d`.`parametro_32` AS `parametro_32`,
    `d`.`parametro_33` AS `parametro_33`,
    `d`.`parametro_34` AS `parametro_34`,
    `d`.`parametro_35` AS `parametro_35`,
    `d`.`parametro_36` AS `parametro_36`,
    `d`.`parametro_37` AS `parametro_37`,
    `d`.`parametro_38` AS `parametro_38`,
    `d`.`parametro_39` AS `parametro_39`,
    `d`.`parametro_40` AS `parametro_40`,
    `d`.`categoria_1` AS `categoria_1`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    `d`.`categoria_2` AS `categoria_2`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    `d`.`categoria_3` AS `categoria_3`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    `d`.`categoria_4` AS `categoria_4`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    `d`.`categoria_5` AS `categoria_5`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    `d`.`categoria_6` AS `categoria_6`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 2) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_3_diario` view : 
#

CREATE  VIEW `demostrativo_3_diario`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_diario` `d` 
  where 
    (`d`.`demostrativo_id` = 3) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_3` view : 
#

CREATE  VIEW `demostrativo_3`
AS
select 
    `demostrativo_3_diario`.`id` AS `id`,
    `demostrativo_3_diario`.`date` AS `date`,
    `demostrativo_3_diario`.`categoria_1` AS `categoria_1`,
    `demostrativo_3_diario`.`categoria_2` AS `categoria_2`,
    `demostrativo_3_diario`.`categoria_3` AS `categoria_3`,
    `demostrativo_3_diario`.`categoria_4` AS `categoria_4`,
    `demostrativo_3_diario`.`categoria_5` AS `categoria_5`,
    `demostrativo_3_diario`.`categoria_6` AS `categoria_6`,
    `demostrativo_3_diario`.`equipos_procesados` AS `equipos_procesados` 
  from 
    `demostrativo_3_diario`;

#
# Definition for the `demostrativo_3_acumulativo` view : 
#

CREATE  VIEW `demostrativo_3_acumulativo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 3) 
  order by 
    `d`.`date` desc limit 1;

#
# Definition for the `demostrativo_3_acumulativo_todo` view : 
#

CREATE  VIEW `demostrativo_3_acumulativo_todo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_1` AS `parametro_1`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`parametro_4` AS `parametro_4`,
    `d`.`parametro_5` AS `parametro_5`,
    `d`.`parametro_6` AS `parametro_6`,
    `d`.`parametro_7` AS `parametro_7`,
    `d`.`parametro_8` AS `parametro_8`,
    `d`.`parametro_9` AS `parametro_9`,
    `d`.`parametro_10` AS `parametro_10`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    `d`.`parametro_26` AS `parametro_26`,
    `d`.`parametro_27` AS `parametro_27`,
    `d`.`parametro_28` AS `parametro_28`,
    `d`.`parametro_29` AS `parametro_29`,
    `d`.`parametro_30` AS `parametro_30`,
    `d`.`parametro_31` AS `parametro_31`,
    `d`.`parametro_32` AS `parametro_32`,
    `d`.`parametro_33` AS `parametro_33`,
    `d`.`parametro_34` AS `parametro_34`,
    `d`.`parametro_35` AS `parametro_35`,
    `d`.`parametro_36` AS `parametro_36`,
    `d`.`parametro_37` AS `parametro_37`,
    `d`.`parametro_38` AS `parametro_38`,
    `d`.`parametro_39` AS `parametro_39`,
    `d`.`parametro_40` AS `parametro_40`,
    `d`.`categoria_1` AS `categoria_1`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    `d`.`categoria_2` AS `categoria_2`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    `d`.`categoria_3` AS `categoria_3`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    `d`.`categoria_4` AS `categoria_4`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    `d`.`categoria_5` AS `categoria_5`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    `d`.`categoria_6` AS `categoria_6`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 3) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_4_diario` view : 
#

CREATE  VIEW `demostrativo_4_diario`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_diario` `d` 
  where 
    (`d`.`demostrativo_id` = 4) 
  order by 
    `d`.`date` desc;

#
# Definition for the `demostrativo_4` view : 
#

CREATE  VIEW `demostrativo_4`
AS
select 
    `demostrativo_4_diario`.`id` AS `id`,
    `demostrativo_4_diario`.`date` AS `date`,
    `demostrativo_4_diario`.`categoria_1` AS `categoria_1`,
    `demostrativo_4_diario`.`categoria_2` AS `categoria_2`,
    `demostrativo_4_diario`.`categoria_3` AS `categoria_3`,
    `demostrativo_4_diario`.`categoria_4` AS `categoria_4`,
    `demostrativo_4_diario`.`categoria_5` AS `categoria_5`,
    `demostrativo_4_diario`.`categoria_6` AS `categoria_6`,
    `demostrativo_4_diario`.`equipos_procesados` AS `equipos_procesados` 
  from 
    `demostrativo_4_diario`;

#
# Definition for the `demostrativo_4_acumulativo` view : 
#

CREATE  VIEW `demostrativo_4_acumulativo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    cast(`d`.`parametro_1` as decimal(25,10)) AS `parametro_1`,
    cast(`d`.`parametro_2` as decimal(25,10)) AS `parametro_2`,
    cast(`d`.`parametro_3` as decimal(25,10)) AS `parametro_3`,
    cast(`d`.`parametro_4` as decimal(25,10)) AS `parametro_4`,
    cast(`d`.`parametro_5` as decimal(25,10)) AS `parametro_5`,
    cast(`d`.`parametro_6` as decimal(25,10)) AS `parametro_6`,
    cast(`d`.`parametro_7` as decimal(25,10)) AS `parametro_7`,
    cast(`d`.`parametro_8` as decimal(25,10)) AS `parametro_8`,
    cast(`d`.`parametro_9` as decimal(25,10)) AS `parametro_9`,
    cast(`d`.`parametro_10` as decimal(25,10)) AS `parametro_10`,
    cast(`d`.`parametro_11` as decimal(25,10)) AS `parametro_11`,
    cast(`d`.`parametro_12` as decimal(25,10)) AS `parametro_12`,
    cast(`d`.`parametro_13` as decimal(25,10)) AS `parametro_13`,
    cast(`d`.`parametro_14` as decimal(25,10)) AS `parametro_14`,
    cast(`d`.`parametro_15` as decimal(25,10)) AS `parametro_15`,
    cast(`d`.`parametro_16` as decimal(25,10)) AS `parametro_16`,
    cast(`d`.`parametro_17` as decimal(25,10)) AS `parametro_17`,
    cast(`d`.`parametro_18` as decimal(25,10)) AS `parametro_18`,
    cast(`d`.`parametro_19` as decimal(25,10)) AS `parametro_19`,
    cast(`d`.`parametro_20` as decimal(25,10)) AS `parametro_20`,
    cast(`d`.`parametro_21` as decimal(25,10)) AS `parametro_21`,
    cast(`d`.`parametro_22` as decimal(25,10)) AS `parametro_22`,
    cast(`d`.`parametro_23` as decimal(25,10)) AS `parametro_23`,
    cast(`d`.`parametro_24` as decimal(25,10)) AS `parametro_24`,
    cast(`d`.`parametro_25` as decimal(25,10)) AS `parametro_25`,
    cast(`d`.`parametro_26` as decimal(25,10)) AS `parametro_26`,
    cast(`d`.`parametro_27` as decimal(25,10)) AS `parametro_27`,
    cast(`d`.`parametro_28` as decimal(25,10)) AS `parametro_28`,
    cast(`d`.`parametro_29` as decimal(25,10)) AS `parametro_29`,
    cast(`d`.`parametro_30` as decimal(25,10)) AS `parametro_30`,
    cast(`d`.`parametro_31` as decimal(25,10)) AS `parametro_31`,
    cast(`d`.`parametro_32` as decimal(25,10)) AS `parametro_32`,
    cast(`d`.`parametro_33` as decimal(25,10)) AS `parametro_33`,
    cast(`d`.`parametro_34` as decimal(25,10)) AS `parametro_34`,
    cast(`d`.`parametro_35` as decimal(25,10)) AS `parametro_35`,
    cast(`d`.`parametro_36` as decimal(25,10)) AS `parametro_36`,
    cast(`d`.`parametro_37` as decimal(25,10)) AS `parametro_37`,
    cast(`d`.`parametro_38` as decimal(25,10)) AS `parametro_38`,
    cast(`d`.`parametro_39` as decimal(25,10)) AS `parametro_39`,
    cast(`d`.`parametro_40` as decimal(25,10)) AS `parametro_40`,
    cast(`d`.`categoria_1` as decimal(25,10)) AS `categoria_1`,
    cast(`d`.`categoria_1_ui` as decimal(25,10)) AS `categoria_1_ui`,
    cast(`d`.`categoria_1_peso` as decimal(25,10)) AS `categoria_1_peso`,
    cast(`d`.`categoria_2` as decimal(25,10)) AS `categoria_2`,
    cast(`d`.`categoria_2_ui` as decimal(25,10)) AS `categoria_2_ui`,
    cast(`d`.`categoria_2_peso` as decimal(25,10)) AS `categoria_2_peso`,
    cast(`d`.`categoria_3` as decimal(25,10)) AS `categoria_3`,
    cast(`d`.`categoria_3_ui` as decimal(25,10)) AS `categoria_3_ui`,
    cast(`d`.`categoria_3_peso` as decimal(25,10)) AS `categoria_3_peso`,
    cast(`d`.`categoria_4` as decimal(25,10)) AS `categoria_4`,
    cast(`d`.`categoria_4_ui` as decimal(25,10)) AS `categoria_4_ui`,
    cast(`d`.`categoria_4_peso` as decimal(25,10)) AS `categoria_4_peso`,
    cast(`d`.`categoria_5` as decimal(25,10)) AS `categoria_5`,
    cast(`d`.`categoria_5_ui` as decimal(25,10)) AS `categoria_5_ui`,
    cast(`d`.`categoria_5_peso` as decimal(25,10)) AS `categoria_5_peso`,
    cast(`d`.`categoria_6` as decimal(25,10)) AS `categoria_6`,
    cast(`d`.`categoria_6_ui` as decimal(25,10)) AS `categoria_6_ui`,
    cast(`d`.`categoria_6_peso` as decimal(25,10)) AS `categoria_6_peso`,
    cast(`d`.`total_enviado_gestor_residuos` as decimal(25,10)) AS `total_enviado_gestor_residuos`,
    cast(`d`.`embalajes_y_etiquetas` as decimal(25,10)) AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 4) 
  order by 
    `d`.`date` desc limit 1;

#
# Definition for the `demostrativo_4_acumulativo_todo` view : 
#

CREATE  VIEW `demostrativo_4_acumulativo_todo`
AS
select 
    `d`.`id` AS `id`,
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_1` AS `parametro_1`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`parametro_4` AS `parametro_4`,
    `d`.`parametro_5` AS `parametro_5`,
    `d`.`parametro_6` AS `parametro_6`,
    `d`.`parametro_7` AS `parametro_7`,
    `d`.`parametro_8` AS `parametro_8`,
    `d`.`parametro_9` AS `parametro_9`,
    `d`.`parametro_10` AS `parametro_10`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    `d`.`parametro_26` AS `parametro_26`,
    `d`.`parametro_27` AS `parametro_27`,
    `d`.`parametro_28` AS `parametro_28`,
    `d`.`parametro_29` AS `parametro_29`,
    `d`.`parametro_30` AS `parametro_30`,
    `d`.`parametro_31` AS `parametro_31`,
    `d`.`parametro_32` AS `parametro_32`,
    `d`.`parametro_33` AS `parametro_33`,
    `d`.`parametro_34` AS `parametro_34`,
    `d`.`parametro_35` AS `parametro_35`,
    `d`.`parametro_36` AS `parametro_36`,
    `d`.`parametro_37` AS `parametro_37`,
    `d`.`parametro_38` AS `parametro_38`,
    `d`.`parametro_39` AS `parametro_39`,
    `d`.`parametro_40` AS `parametro_40`,
    `d`.`categoria_1` AS `categoria_1`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    `d`.`categoria_2` AS `categoria_2`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    `d`.`categoria_3` AS `categoria_3`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    `d`.`categoria_4` AS `categoria_4`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    `d`.`categoria_5` AS `categoria_5`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    `d`.`categoria_6` AS `categoria_6`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas` 
  from 
    `demostrativo_acumulativo` `d` 
  where 
    (`d`.`demostrativo_id` = 4) 
  order by 
    `d`.`date` desc;

#
# Definition for the `td_members` view : 
#

CREATE  VIEW `td_members`
AS
select 
    `m`.`id` AS `id`,
    `m`.`username` AS `username`,
    `m`.`email` AS `email`,
    `r`.`name` AS `role`,
    `r`.`code` AS `role_code`,
    `d`.`name` AS `demostrativo_name`,
    (
  select 
    count(0) 
  from 
    `login_attempts` `la` 
  where 
    (`la`.`user_id` = `m`.`id`)) AS `login_attempts` 
  from 
    ((`members` `m` join `members_role` `r` on((`r`.`id` = `m`.`members_role_id`))) left join `demostrativo` `d` on((`d`.`id` = `m`.`demostrativo_id`)));

#
# Definition for the `vw_check_data_demostrativo_1` view : 
#

CREATE  VIEW `vw_check_data_demostrativo_1`
AS
select 
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`id` AS `id`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    (
  select 
    sum(`x`.`equipos_procesados`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `equipos_procesados_suma`,`da`.`equipos_procesados` AS `equipos_procesados_acumulado`,(
  select 
    (`equipos_procesados_suma` = `equipos_procesados_acumulado`)) AS `equipos_procesados_ok`,
    `d`.`parametro_1` AS `parametro_1`,
    (
  select 
    sum(`x`.`parametro_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_1_suma`,`da`.`parametro_1` AS `parametro_1_acumulado`,(
  select 
    (`parametro_1_suma` = `parametro_1_acumulado`)) AS `parametro_1_ok`,
    `d`.`parametro_2` AS `parametro_2`,
    (
  select 
    sum(`x`.`parametro_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_2_suma`,`da`.`parametro_2` AS `parametro_2_acumulado`,(
  select 
    (`parametro_2_suma` = `parametro_2_acumulado`)) AS `parametro_2_ok`,
    `d`.`parametro_3` AS `parametro_3`,
    (
  select 
    sum(`x`.`parametro_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_3_suma`,`da`.`parametro_3` AS `parametro_3_acumulado`,(
  select 
    (`parametro_3_suma` = `parametro_3_acumulado`)) AS `parametro_3_ok`,
    `d`.`parametro_4` AS `parametro_4`,
    (
  select 
    sum(`x`.`parametro_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_4_suma`,`da`.`parametro_4` AS `parametro_4_acumulado`,(
  select 
    (`parametro_4_suma` = `parametro_4_acumulado`)) AS `parametro_4_ok`,
    `d`.`parametro_5` AS `parametro_5`,
    (
  select 
    sum(`x`.`parametro_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_5_suma`,`da`.`parametro_5` AS `parametro_5_acumulado`,(
  select 
    (`parametro_5_suma` = `parametro_5_acumulado`)) AS `parametro_5_ok`,
    `d`.`parametro_6` AS `parametro_6`,
    (
  select 
    sum(`x`.`parametro_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_6_suma`,`da`.`parametro_6` AS `parametro_6_acumulado`,(
  select 
    (`parametro_6_suma` = `parametro_6_acumulado`)) AS `parametro_6_ok`,
    `d`.`parametro_7` AS `parametro_7`,
    (
  select 
    sum(`x`.`parametro_7`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_7_suma`,`da`.`parametro_7` AS `parametro_7_acumulado`,(
  select 
    (`parametro_7_suma` = `parametro_7_acumulado`)) AS `parametro_7_ok`,
    `d`.`parametro_8` AS `parametro_8`,
    (
  select 
    sum(`x`.`parametro_8`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_8_suma`,`da`.`parametro_8` AS `parametro_8_acumulado`,(
  select 
    (`parametro_8_suma` = `parametro_8_acumulado`)) AS `parametro_8_ok`,
    `d`.`parametro_9` AS `parametro_9`,
    (
  select 
    sum(`x`.`parametro_9`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_9_suma`,`da`.`parametro_9` AS `parametro_9_acumulado`,(
  select 
    (`parametro_9_suma` = `parametro_9_acumulado`)) AS `parametro_9_ok`,
    `d`.`parametro_10` AS `parametro_10`,
    (
  select 
    sum(`x`.`parametro_10`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_10_suma`,`da`.`parametro_10` AS `parametro_10_acumulado`,(
  select 
    (`parametro_10_suma` = `parametro_10_acumulado`)) AS `parametro_10_ok`,
    `d`.`parametro_11` AS `parametro_11`,
    (
  select 
    sum(`x`.`parametro_11`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_11_suma`,`da`.`parametro_11` AS `parametro_11_acumulado`,(
  select 
    (`parametro_11_suma` = `parametro_11_acumulado`)) AS `parametro_11_ok`,
    `d`.`parametro_12` AS `parametro_12`,
    (
  select 
    sum(`x`.`parametro_12`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_12_suma`,`da`.`parametro_12` AS `parametro_12_acumulado`,(
  select 
    (`parametro_12_suma` = `parametro_12_acumulado`)) AS `parametro_12_ok`,
    `d`.`parametro_13` AS `parametro_13`,
    (
  select 
    sum(`x`.`parametro_13`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_13_suma`,`da`.`parametro_13` AS `parametro_13_acumulado`,(
  select 
    (`parametro_13_suma` = `parametro_13_acumulado`)) AS `parametro_13_ok`,
    `d`.`parametro_14` AS `parametro_14`,
    (
  select 
    sum(`x`.`parametro_14`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_14_suma`,`da`.`parametro_14` AS `parametro_14_acumulado`,(
  select 
    (`parametro_14_suma` = `parametro_14_acumulado`)) AS `parametro_14_ok`,
    `d`.`parametro_15` AS `parametro_15`,
    (
  select 
    sum(`x`.`parametro_15`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_15_suma`,`da`.`parametro_15` AS `parametro_15_acumulado`,(
  select 
    (`parametro_15_suma` = `parametro_15_acumulado`)) AS `parametro_15_ok`,
    `d`.`parametro_16` AS `parametro_16`,
    (
  select 
    sum(`x`.`parametro_16`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_16_suma`,`da`.`parametro_16` AS `parametro_16_acumulado`,(
  select 
    (`parametro_16_suma` = `parametro_16_acumulado`)) AS `parametro_16_ok`,
    `d`.`parametro_17` AS `parametro_17`,
    (
  select 
    sum(`x`.`parametro_17`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_17_suma`,`da`.`parametro_17` AS `parametro_17_acumulado`,(
  select 
    (`parametro_17_suma` = `parametro_17_acumulado`)) AS `parametro_17_ok`,
    `d`.`parametro_18` AS `parametro_18`,
    (
  select 
    sum(`x`.`parametro_18`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_18_suma`,`da`.`parametro_18` AS `parametro_18_acumulado`,(
  select 
    (`parametro_18_suma` = `parametro_18_acumulado`)) AS `parametro_18_ok`,
    `d`.`parametro_19` AS `parametro_19`,
    (
  select 
    sum(`x`.`parametro_19`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_19_suma`,`da`.`parametro_19` AS `parametro_19_acumulado`,(
  select 
    (`parametro_19_suma` = `parametro_19_acumulado`)) AS `parametro_19_ok`,
    `d`.`parametro_20` AS `parametro_20`,
    (
  select 
    sum(`x`.`parametro_20`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_20_suma`,`da`.`parametro_20` AS `parametro_20_acumulado`,(
  select 
    (`parametro_20_suma` = `parametro_20_acumulado`)) AS `parametro_20_ok`,
    `d`.`parametro_21` AS `parametro_21`,
    (
  select 
    sum(`x`.`parametro_21`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_21_suma`,`da`.`parametro_21` AS `parametro_21_acumulado`,(
  select 
    (`parametro_21_suma` = `parametro_21_acumulado`)) AS `parametro_21_ok`,
    `d`.`parametro_22` AS `parametro_22`,
    (
  select 
    sum(`x`.`parametro_22`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_22_suma`,`da`.`parametro_22` AS `parametro_22_acumulado`,(
  select 
    (`parametro_22_suma` = `parametro_22_acumulado`)) AS `parametro_22_ok`,
    `d`.`parametro_23` AS `parametro_23`,
    (
  select 
    sum(`x`.`parametro_23`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_23_suma`,`da`.`parametro_23` AS `parametro_23_acumulado`,(
  select 
    (`parametro_23_suma` = `parametro_23_acumulado`)) AS `parametro_23_ok`,
    `d`.`parametro_24` AS `parametro_24`,
    (
  select 
    sum(`x`.`parametro_24`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_24_suma`,`da`.`parametro_24` AS `parametro_24_acumulado`,(
  select 
    (`parametro_24_suma` = `parametro_24_acumulado`)) AS `parametro_24_ok`,
    `d`.`parametro_25` AS `parametro_25`,
    (
  select 
    sum(`x`.`parametro_25`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_25_suma`,`da`.`parametro_25` AS `parametro_25_acumulado`,(
  select 
    (`parametro_25_suma` = `parametro_25_acumulado`)) AS `parametro_25_ok`,
    `d`.`parametro_26` AS `parametro_26`,
    (
  select 
    sum(`x`.`parametro_26`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_26_suma`,`da`.`parametro_26` AS `parametro_26_acumulado`,(
  select 
    (`parametro_26_suma` = `parametro_26_acumulado`)) AS `parametro_26_ok`,
    `d`.`parametro_27` AS `parametro_27`,
    (
  select 
    sum(`x`.`parametro_27`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_27_suma`,`da`.`parametro_27` AS `parametro_27_acumulado`,(
  select 
    (`parametro_27_suma` = `parametro_27_acumulado`)) AS `parametro_27_ok`,
    `d`.`parametro_28` AS `parametro_28`,
    (
  select 
    sum(`x`.`parametro_28`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_28_suma`,`da`.`parametro_28` AS `parametro_28_acumulado`,(
  select 
    (`parametro_28_suma` = `parametro_28_acumulado`)) AS `parametro_28_ok`,
    `d`.`parametro_29` AS `parametro_29`,
    (
  select 
    sum(`x`.`parametro_29`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_29_suma`,`da`.`parametro_29` AS `parametro_29_acumulado`,(
  select 
    (`parametro_29_suma` = `parametro_29_acumulado`)) AS `parametro_29_ok`,
    `d`.`parametro_30` AS `parametro_30`,
    (
  select 
    sum(`x`.`parametro_30`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_30_suma`,`da`.`parametro_30` AS `parametro_30_acumulado`,(
  select 
    (`parametro_30_suma` = `parametro_30_acumulado`)) AS `parametro_30_ok`,
    `d`.`parametro_31` AS `parametro_31`,
    (
  select 
    sum(`x`.`parametro_31`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_31_suma`,`da`.`parametro_31` AS `parametro_31_acumulado`,(
  select 
    (`parametro_31_suma` = `parametro_31_acumulado`)) AS `parametro_31_ok`,
    `d`.`parametro_32` AS `parametro_32`,
    (
  select 
    sum(`x`.`parametro_32`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_32_suma`,`da`.`parametro_32` AS `parametro_32_acumulado`,(
  select 
    (`parametro_32_suma` = `parametro_32_acumulado`)) AS `parametro_32_ok`,
    `d`.`parametro_33` AS `parametro_33`,
    (
  select 
    sum(`x`.`parametro_33`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_33_suma`,`da`.`parametro_33` AS `parametro_33_acumulado`,(
  select 
    (`parametro_33_suma` = `parametro_33_acumulado`)) AS `parametro_33_ok`,
    `d`.`parametro_34` AS `parametro_34`,
    (
  select 
    sum(`x`.`parametro_34`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_34_suma`,`da`.`parametro_34` AS `parametro_34_acumulado`,(
  select 
    (`parametro_34_suma` = `parametro_34_acumulado`)) AS `parametro_34_ok`,
    `d`.`parametro_35` AS `parametro_35`,
    (
  select 
    sum(`x`.`parametro_35`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_35_suma`,`da`.`parametro_35` AS `parametro_35_acumulado`,(
  select 
    (`parametro_35_suma` = `parametro_35_acumulado`)) AS `parametro_35_ok`,
    `d`.`parametro_36` AS `parametro_36`,
    (
  select 
    sum(`x`.`parametro_36`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_36_suma`,`da`.`parametro_36` AS `parametro_36_acumulado`,(
  select 
    (`parametro_36_suma` = `parametro_36_acumulado`)) AS `parametro_36_ok`,
    `d`.`parametro_37` AS `parametro_37`,
    (
  select 
    sum(`x`.`parametro_37`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_37_suma`,`da`.`parametro_37` AS `parametro_37_acumulado`,(
  select 
    (`parametro_37_suma` = `parametro_37_acumulado`)) AS `parametro_37_ok`,
    `d`.`parametro_38` AS `parametro_38`,
    (
  select 
    sum(`x`.`parametro_38`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_38_suma`,`da`.`parametro_38` AS `parametro_38_acumulado`,(
  select 
    (`parametro_38_suma` = `parametro_38_acumulado`)) AS `parametro_38_ok`,
    `d`.`parametro_39` AS `parametro_39`,
    (
  select 
    sum(`x`.`parametro_39`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_39_suma`,`da`.`parametro_39` AS `parametro_39_acumulado`,(
  select 
    (`parametro_39_suma` = `parametro_39_acumulado`)) AS `parametro_39_ok`,
    `d`.`parametro_40` AS `parametro_40`,
    (
  select 
    sum(`x`.`parametro_40`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_40_suma`,`da`.`parametro_40` AS `parametro_40_acumulado`,(
  select 
    (`parametro_40_suma` = `parametro_40_acumulado`)) AS `parametro_40_ok`,
    `d`.`categoria_1` AS `categoria_1`,
    (
  select 
    sum(`x`.`categoria_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_suma`,`da`.`categoria_1` AS `categoria_1_acumulado`,(
  select 
    (`categoria_1_suma` = `categoria_1_acumulado`)) AS `categoria_1_ok`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    (
  select 
    sum(`x`.`categoria_1_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_ui_suma`,`da`.`categoria_1_ui` AS `categoria_1_ui_acumulado`,(
  select 
    (`categoria_1_ui_suma` = `categoria_1_ui_acumulado`)) AS `categoria_1_ui_ok`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    (
  select 
    sum(`x`.`categoria_1_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_peso_suma`,`da`.`categoria_1_peso` AS `categoria_1_peso_acumulado`,(
  select 
    (`categoria_1_peso_suma` = `categoria_1_peso_acumulado`)) AS `categoria_1_peso_ok`,
    `d`.`categoria_2` AS `categoria_2`,
    (
  select 
    sum(`x`.`categoria_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_suma`,`da`.`categoria_2` AS `categoria_2_acumulado`,(
  select 
    (`categoria_2_suma` = `categoria_2_acumulado`)) AS `categoria_2_ok`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    (
  select 
    sum(`x`.`categoria_2_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_ui_suma`,`da`.`categoria_2_ui` AS `categoria_2_ui_acumulado`,(
  select 
    (`categoria_2_ui_suma` = `categoria_2_ui_acumulado`)) AS `categoria_2_ui_ok`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    (
  select 
    sum(`x`.`categoria_2_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_peso_suma`,`da`.`categoria_2_peso` AS `categoria_2_peso_acumulado`,(
  select 
    (`categoria_2_peso_suma` = `categoria_2_peso_acumulado`)) AS `categoria_2_peso_ok`,
    `d`.`categoria_3` AS `categoria_3`,
    (
  select 
    sum(`x`.`categoria_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_suma`,`da`.`categoria_3` AS `categoria_3_acumulado`,(
  select 
    (`categoria_3_suma` = `categoria_3_acumulado`)) AS `categoria_3_ok`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    (
  select 
    sum(`x`.`categoria_3_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_ui_suma`,`da`.`categoria_3_ui` AS `categoria_3_ui_acumulado`,(
  select 
    (`categoria_3_ui_suma` = `categoria_3_ui_acumulado`)) AS `categoria_3_ui_ok`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    (
  select 
    sum(`x`.`categoria_3_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_peso_suma`,`da`.`categoria_3_peso` AS `categoria_3_peso_acumulado`,(
  select 
    (`categoria_3_peso_suma` = `categoria_3_peso_acumulado`)) AS `categoria_3_peso_ok`,
    `d`.`categoria_4` AS `categoria_4`,
    (
  select 
    sum(`x`.`categoria_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_suma`,`da`.`categoria_4` AS `categoria_4_acumulado`,(
  select 
    (`categoria_4_suma` = `categoria_4_acumulado`)) AS `categoria_4_ok`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    (
  select 
    sum(`x`.`categoria_4_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_ui_suma`,`da`.`categoria_4_ui` AS `categoria_4_ui_acumulado`,(
  select 
    (`categoria_4_ui_suma` = `categoria_4_ui_acumulado`)) AS `categoria_4_ui_ok`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    (
  select 
    sum(`x`.`categoria_4_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_peso_suma`,`da`.`categoria_4_peso` AS `categoria_4_peso_acumulado`,(
  select 
    (`categoria_4_peso_suma` = `categoria_4_peso_acumulado`)) AS `categoria_4_peso_ok`,
    `d`.`categoria_5` AS `categoria_5`,
    (
  select 
    sum(`x`.`categoria_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_suma`,`da`.`categoria_5` AS `categoria_5_acumulado`,(
  select 
    (`categoria_5_suma` = `categoria_5_acumulado`)) AS `categoria_5_ok`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    (
  select 
    sum(`x`.`categoria_5_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_ui_suma`,`da`.`categoria_5_ui` AS `categoria_5_ui_acumulado`,(
  select 
    (`categoria_5_ui_suma` = `categoria_5_ui_acumulado`)) AS `categoria_5_ui_ok`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    (
  select 
    sum(`x`.`categoria_5_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_peso_suma`,`da`.`categoria_5_peso` AS `categoria_5_peso_acumulado`,(
  select 
    (`categoria_5_peso_suma` = `categoria_5_peso_acumulado`)) AS `categoria_5_peso_ok`,
    `d`.`categoria_6` AS `categoria_6`,
    (
  select 
    sum(`x`.`categoria_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_suma`,`da`.`categoria_6` AS `categoria_6_acumulado`,(
  select 
    (`categoria_6_suma` = `categoria_6_acumulado`)) AS `categoria_6_ok`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    (
  select 
    sum(`x`.`categoria_6_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_ui_suma`,`da`.`categoria_6_ui` AS `categoria_6_ui_acumulado`,(
  select 
    (`categoria_6_ui_suma` = `categoria_6_ui_acumulado`)) AS `categoria_6_ui_ok`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    (
  select 
    sum(`x`.`categoria_6_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_peso_suma`,`da`.`categoria_6_peso` AS `categoria_6_peso_acumulado`,(
  select 
    (`categoria_6_peso_suma` = `categoria_6_peso_acumulado`)) AS `categoria_6_peso_ok`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    (
  select 
    sum(`x`.`total_enviado_gestor_residuos`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `total_enviado_gestor_residuos_suma`,`da`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos_acumulado`,(
  select 
    (`total_enviado_gestor_residuos_suma` = `total_enviado_gestor_residuos_acumulado`)) AS `total_enviado_gestor_residuos_ok`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    (
  select 
    sum(`x`.`embalajes_y_etiquetas`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `embalajes_y_etiquetas_suma`,`da`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas_acumulado`,(
  select 
    (`embalajes_y_etiquetas_suma` = `embalajes_y_etiquetas_acumulado`)) AS `embalajes_y_etiquetas_ok` 
  from 
    (`demostrativo_diario` `d` join `demostrativo_acumulativo` `da` on((`da`.`demostrativo_diario_id` = `d`.`id`))) 
  where 
    (`d`.`demostrativo_id` = 1) 
  order by 
    `d`.`date`;

#
# Definition for the `vw_check_data_demostrativo_2` view : 
#

CREATE  VIEW `vw_check_data_demostrativo_2`
AS
select 
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`id` AS `id`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    (
  select 
    sum(`x`.`equipos_procesados`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `equipos_procesados_suma`,`da`.`equipos_procesados` AS `equipos_procesados_acumulado`,(
  select 
    (`equipos_procesados_suma` = `equipos_procesados_acumulado`)) AS `equipos_procesados_ok`,
    `d`.`parametro_1` AS `parametro_1`,
    (
  select 
    sum(`x`.`parametro_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_1_suma`,`da`.`parametro_1` AS `parametro_1_acumulado`,(
  select 
    (`parametro_1_suma` = `parametro_1_acumulado`)) AS `parametro_1_ok`,
    `d`.`parametro_2` AS `parametro_2`,
    (
  select 
    sum(`x`.`parametro_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_2_suma`,`da`.`parametro_2` AS `parametro_2_acumulado`,(
  select 
    (`parametro_2_suma` = `parametro_2_acumulado`)) AS `parametro_2_ok`,
    `d`.`parametro_3` AS `parametro_3`,
    (
  select 
    sum(`x`.`parametro_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_3_suma`,`da`.`parametro_3` AS `parametro_3_acumulado`,(
  select 
    (`parametro_3_suma` = `parametro_3_acumulado`)) AS `parametro_3_ok`,
    `d`.`parametro_4` AS `parametro_4`,
    (
  select 
    sum(`x`.`parametro_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_4_suma`,`da`.`parametro_4` AS `parametro_4_acumulado`,(
  select 
    (`parametro_4_suma` = `parametro_4_acumulado`)) AS `parametro_4_ok`,
    `d`.`parametro_5` AS `parametro_5`,
    (
  select 
    sum(`x`.`parametro_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_5_suma`,`da`.`parametro_5` AS `parametro_5_acumulado`,(
  select 
    (`parametro_5_suma` = `parametro_5_acumulado`)) AS `parametro_5_ok`,
    `d`.`parametro_6` AS `parametro_6`,
    (
  select 
    sum(`x`.`parametro_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_6_suma`,`da`.`parametro_6` AS `parametro_6_acumulado`,(
  select 
    (`parametro_6_suma` = `parametro_6_acumulado`)) AS `parametro_6_ok`,
    `d`.`parametro_7` AS `parametro_7`,
    (
  select 
    sum(`x`.`parametro_7`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_7_suma`,`da`.`parametro_7` AS `parametro_7_acumulado`,(
  select 
    (`parametro_7_suma` = `parametro_7_acumulado`)) AS `parametro_7_ok`,
    `d`.`parametro_8` AS `parametro_8`,
    (
  select 
    sum(`x`.`parametro_8`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_8_suma`,`da`.`parametro_8` AS `parametro_8_acumulado`,(
  select 
    (`parametro_8_suma` = `parametro_8_acumulado`)) AS `parametro_8_ok`,
    `d`.`parametro_9` AS `parametro_9`,
    (
  select 
    sum(`x`.`parametro_9`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_9_suma`,`da`.`parametro_9` AS `parametro_9_acumulado`,(
  select 
    (`parametro_9_suma` = `parametro_9_acumulado`)) AS `parametro_9_ok`,
    `d`.`parametro_10` AS `parametro_10`,
    (
  select 
    sum(`x`.`parametro_10`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_10_suma`,`da`.`parametro_10` AS `parametro_10_acumulado`,(
  select 
    (`parametro_10_suma` = `parametro_10_acumulado`)) AS `parametro_10_ok`,
    `d`.`parametro_11` AS `parametro_11`,
    (
  select 
    sum(`x`.`parametro_11`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_11_suma`,`da`.`parametro_11` AS `parametro_11_acumulado`,(
  select 
    (`parametro_11_suma` = `parametro_11_acumulado`)) AS `parametro_11_ok`,
    `d`.`parametro_12` AS `parametro_12`,
    (
  select 
    sum(`x`.`parametro_12`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_12_suma`,`da`.`parametro_12` AS `parametro_12_acumulado`,(
  select 
    (`parametro_12_suma` = `parametro_12_acumulado`)) AS `parametro_12_ok`,
    `d`.`parametro_13` AS `parametro_13`,
    (
  select 
    sum(`x`.`parametro_13`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_13_suma`,`da`.`parametro_13` AS `parametro_13_acumulado`,(
  select 
    (`parametro_13_suma` = `parametro_13_acumulado`)) AS `parametro_13_ok`,
    `d`.`parametro_14` AS `parametro_14`,
    (
  select 
    sum(`x`.`parametro_14`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_14_suma`,`da`.`parametro_14` AS `parametro_14_acumulado`,(
  select 
    (`parametro_14_suma` = `parametro_14_acumulado`)) AS `parametro_14_ok`,
    `d`.`parametro_15` AS `parametro_15`,
    (
  select 
    sum(`x`.`parametro_15`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_15_suma`,`da`.`parametro_15` AS `parametro_15_acumulado`,(
  select 
    (`parametro_15_suma` = `parametro_15_acumulado`)) AS `parametro_15_ok`,
    `d`.`parametro_16` AS `parametro_16`,
    (
  select 
    sum(`x`.`parametro_16`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_16_suma`,`da`.`parametro_16` AS `parametro_16_acumulado`,(
  select 
    (`parametro_16_suma` = `parametro_16_acumulado`)) AS `parametro_16_ok`,
    `d`.`parametro_17` AS `parametro_17`,
    (
  select 
    sum(`x`.`parametro_17`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_17_suma`,`da`.`parametro_17` AS `parametro_17_acumulado`,(
  select 
    (`parametro_17_suma` = `parametro_17_acumulado`)) AS `parametro_17_ok`,
    `d`.`parametro_18` AS `parametro_18`,
    (
  select 
    sum(`x`.`parametro_18`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_18_suma`,`da`.`parametro_18` AS `parametro_18_acumulado`,(
  select 
    (`parametro_18_suma` = `parametro_18_acumulado`)) AS `parametro_18_ok`,
    `d`.`parametro_19` AS `parametro_19`,
    (
  select 
    sum(`x`.`parametro_19`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_19_suma`,`da`.`parametro_19` AS `parametro_19_acumulado`,(
  select 
    (`parametro_19_suma` = `parametro_19_acumulado`)) AS `parametro_19_ok`,
    `d`.`parametro_20` AS `parametro_20`,
    (
  select 
    sum(`x`.`parametro_20`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_20_suma`,`da`.`parametro_20` AS `parametro_20_acumulado`,(
  select 
    (`parametro_20_suma` = `parametro_20_acumulado`)) AS `parametro_20_ok`,
    `d`.`parametro_21` AS `parametro_21`,
    (
  select 
    sum(`x`.`parametro_21`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_21_suma`,`da`.`parametro_21` AS `parametro_21_acumulado`,(
  select 
    (`parametro_21_suma` = `parametro_21_acumulado`)) AS `parametro_21_ok`,
    `d`.`parametro_22` AS `parametro_22`,
    (
  select 
    sum(`x`.`parametro_22`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_22_suma`,`da`.`parametro_22` AS `parametro_22_acumulado`,(
  select 
    (`parametro_22_suma` = `parametro_22_acumulado`)) AS `parametro_22_ok`,
    `d`.`parametro_23` AS `parametro_23`,
    (
  select 
    sum(`x`.`parametro_23`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_23_suma`,`da`.`parametro_23` AS `parametro_23_acumulado`,(
  select 
    (`parametro_23_suma` = `parametro_23_acumulado`)) AS `parametro_23_ok`,
    `d`.`parametro_24` AS `parametro_24`,
    (
  select 
    sum(`x`.`parametro_24`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_24_suma`,`da`.`parametro_24` AS `parametro_24_acumulado`,(
  select 
    (`parametro_24_suma` = `parametro_24_acumulado`)) AS `parametro_24_ok`,
    `d`.`parametro_25` AS `parametro_25`,
    (
  select 
    sum(`x`.`parametro_25`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_25_suma`,`da`.`parametro_25` AS `parametro_25_acumulado`,(
  select 
    (`parametro_25_suma` = `parametro_25_acumulado`)) AS `parametro_25_ok`,
    `d`.`parametro_26` AS `parametro_26`,
    (
  select 
    sum(`x`.`parametro_26`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_26_suma`,`da`.`parametro_26` AS `parametro_26_acumulado`,(
  select 
    (`parametro_26_suma` = `parametro_26_acumulado`)) AS `parametro_26_ok`,
    `d`.`parametro_27` AS `parametro_27`,
    (
  select 
    sum(`x`.`parametro_27`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_27_suma`,`da`.`parametro_27` AS `parametro_27_acumulado`,(
  select 
    (`parametro_27_suma` = `parametro_27_acumulado`)) AS `parametro_27_ok`,
    `d`.`parametro_28` AS `parametro_28`,
    (
  select 
    sum(`x`.`parametro_28`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_28_suma`,`da`.`parametro_28` AS `parametro_28_acumulado`,(
  select 
    (`parametro_28_suma` = `parametro_28_acumulado`)) AS `parametro_28_ok`,
    `d`.`parametro_29` AS `parametro_29`,
    (
  select 
    sum(`x`.`parametro_29`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_29_suma`,`da`.`parametro_29` AS `parametro_29_acumulado`,(
  select 
    (`parametro_29_suma` = `parametro_29_acumulado`)) AS `parametro_29_ok`,
    `d`.`parametro_30` AS `parametro_30`,
    (
  select 
    sum(`x`.`parametro_30`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_30_suma`,`da`.`parametro_30` AS `parametro_30_acumulado`,(
  select 
    (`parametro_30_suma` = `parametro_30_acumulado`)) AS `parametro_30_ok`,
    `d`.`parametro_31` AS `parametro_31`,
    (
  select 
    sum(`x`.`parametro_31`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_31_suma`,`da`.`parametro_31` AS `parametro_31_acumulado`,(
  select 
    (`parametro_31_suma` = `parametro_31_acumulado`)) AS `parametro_31_ok`,
    `d`.`parametro_32` AS `parametro_32`,
    (
  select 
    sum(`x`.`parametro_32`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_32_suma`,`da`.`parametro_32` AS `parametro_32_acumulado`,(
  select 
    (`parametro_32_suma` = `parametro_32_acumulado`)) AS `parametro_32_ok`,
    `d`.`parametro_33` AS `parametro_33`,
    (
  select 
    sum(`x`.`parametro_33`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_33_suma`,`da`.`parametro_33` AS `parametro_33_acumulado`,(
  select 
    (`parametro_33_suma` = `parametro_33_acumulado`)) AS `parametro_33_ok`,
    `d`.`parametro_34` AS `parametro_34`,
    (
  select 
    sum(`x`.`parametro_34`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_34_suma`,`da`.`parametro_34` AS `parametro_34_acumulado`,(
  select 
    (`parametro_34_suma` = `parametro_34_acumulado`)) AS `parametro_34_ok`,
    `d`.`parametro_35` AS `parametro_35`,
    (
  select 
    sum(`x`.`parametro_35`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_35_suma`,`da`.`parametro_35` AS `parametro_35_acumulado`,(
  select 
    (`parametro_35_suma` = `parametro_35_acumulado`)) AS `parametro_35_ok`,
    `d`.`parametro_36` AS `parametro_36`,
    (
  select 
    sum(`x`.`parametro_36`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_36_suma`,`da`.`parametro_36` AS `parametro_36_acumulado`,(
  select 
    (`parametro_36_suma` = `parametro_36_acumulado`)) AS `parametro_36_ok`,
    `d`.`parametro_37` AS `parametro_37`,
    (
  select 
    sum(`x`.`parametro_37`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_37_suma`,`da`.`parametro_37` AS `parametro_37_acumulado`,(
  select 
    (`parametro_37_suma` = `parametro_37_acumulado`)) AS `parametro_37_ok`,
    `d`.`parametro_38` AS `parametro_38`,
    (
  select 
    sum(`x`.`parametro_38`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_38_suma`,`da`.`parametro_38` AS `parametro_38_acumulado`,(
  select 
    (`parametro_38_suma` = `parametro_38_acumulado`)) AS `parametro_38_ok`,
    `d`.`parametro_39` AS `parametro_39`,
    (
  select 
    sum(`x`.`parametro_39`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_39_suma`,`da`.`parametro_39` AS `parametro_39_acumulado`,(
  select 
    (`parametro_39_suma` = `parametro_39_acumulado`)) AS `parametro_39_ok`,
    `d`.`parametro_40` AS `parametro_40`,
    (
  select 
    sum(`x`.`parametro_40`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_40_suma`,`da`.`parametro_40` AS `parametro_40_acumulado`,(
  select 
    (`parametro_40_suma` = `parametro_40_acumulado`)) AS `parametro_40_ok`,
    `d`.`categoria_1` AS `categoria_1`,
    (
  select 
    sum(`x`.`categoria_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_suma`,`da`.`categoria_1` AS `categoria_1_acumulado`,(
  select 
    (`categoria_1_suma` = `categoria_1_acumulado`)) AS `categoria_1_ok`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    (
  select 
    sum(`x`.`categoria_1_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_ui_suma`,`da`.`categoria_1_ui` AS `categoria_1_ui_acumulado`,(
  select 
    (`categoria_1_ui_suma` = `categoria_1_ui_acumulado`)) AS `categoria_1_ui_ok`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    (
  select 
    sum(`x`.`categoria_1_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_peso_suma`,`da`.`categoria_1_peso` AS `categoria_1_peso_acumulado`,(
  select 
    (`categoria_1_peso_suma` = `categoria_1_peso_acumulado`)) AS `categoria_1_peso_ok`,
    `d`.`categoria_2` AS `categoria_2`,
    (
  select 
    sum(`x`.`categoria_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_suma`,`da`.`categoria_2` AS `categoria_2_acumulado`,(
  select 
    (`categoria_2_suma` = `categoria_2_acumulado`)) AS `categoria_2_ok`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    (
  select 
    sum(`x`.`categoria_2_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_ui_suma`,`da`.`categoria_2_ui` AS `categoria_2_ui_acumulado`,(
  select 
    (`categoria_2_ui_suma` = `categoria_2_ui_acumulado`)) AS `categoria_2_ui_ok`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    (
  select 
    sum(`x`.`categoria_2_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_peso_suma`,`da`.`categoria_2_peso` AS `categoria_2_peso_acumulado`,(
  select 
    (`categoria_2_peso_suma` = `categoria_2_peso_acumulado`)) AS `categoria_2_peso_ok`,
    `d`.`categoria_3` AS `categoria_3`,
    (
  select 
    sum(`x`.`categoria_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_suma`,`da`.`categoria_3` AS `categoria_3_acumulado`,(
  select 
    (`categoria_3_suma` = `categoria_3_acumulado`)) AS `categoria_3_ok`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    (
  select 
    sum(`x`.`categoria_3_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_ui_suma`,`da`.`categoria_3_ui` AS `categoria_3_ui_acumulado`,(
  select 
    (`categoria_3_ui_suma` = `categoria_3_ui_acumulado`)) AS `categoria_3_ui_ok`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    (
  select 
    sum(`x`.`categoria_3_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_peso_suma`,`da`.`categoria_3_peso` AS `categoria_3_peso_acumulado`,(
  select 
    (`categoria_3_peso_suma` = `categoria_3_peso_acumulado`)) AS `categoria_3_peso_ok`,
    `d`.`categoria_4` AS `categoria_4`,
    (
  select 
    sum(`x`.`categoria_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_suma`,`da`.`categoria_4` AS `categoria_4_acumulado`,(
  select 
    (`categoria_4_suma` = `categoria_4_acumulado`)) AS `categoria_4_ok`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    (
  select 
    sum(`x`.`categoria_4_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_ui_suma`,`da`.`categoria_4_ui` AS `categoria_4_ui_acumulado`,(
  select 
    (`categoria_4_ui_suma` = `categoria_4_ui_acumulado`)) AS `categoria_4_ui_ok`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    (
  select 
    sum(`x`.`categoria_4_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_peso_suma`,`da`.`categoria_4_peso` AS `categoria_4_peso_acumulado`,(
  select 
    (`categoria_4_peso_suma` = `categoria_4_peso_acumulado`)) AS `categoria_4_peso_ok`,
    `d`.`categoria_5` AS `categoria_5`,
    (
  select 
    sum(`x`.`categoria_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_suma`,`da`.`categoria_5` AS `categoria_5_acumulado`,(
  select 
    (`categoria_5_suma` = `categoria_5_acumulado`)) AS `categoria_5_ok`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    (
  select 
    sum(`x`.`categoria_5_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_ui_suma`,`da`.`categoria_5_ui` AS `categoria_5_ui_acumulado`,(
  select 
    (`categoria_5_ui_suma` = `categoria_5_ui_acumulado`)) AS `categoria_5_ui_ok`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    (
  select 
    sum(`x`.`categoria_5_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_peso_suma`,`da`.`categoria_5_peso` AS `categoria_5_peso_acumulado`,(
  select 
    (`categoria_5_peso_suma` = `categoria_5_peso_acumulado`)) AS `categoria_5_peso_ok`,
    `d`.`categoria_6` AS `categoria_6`,
    (
  select 
    sum(`x`.`categoria_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_suma`,`da`.`categoria_6` AS `categoria_6_acumulado`,(
  select 
    (`categoria_6_suma` = `categoria_6_acumulado`)) AS `categoria_6_ok`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    (
  select 
    sum(`x`.`categoria_6_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_ui_suma`,`da`.`categoria_6_ui` AS `categoria_6_ui_acumulado`,(
  select 
    (`categoria_6_ui_suma` = `categoria_6_ui_acumulado`)) AS `categoria_6_ui_ok`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    (
  select 
    sum(`x`.`categoria_6_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_peso_suma`,`da`.`categoria_6_peso` AS `categoria_6_peso_acumulado`,(
  select 
    (`categoria_6_peso_suma` = `categoria_6_peso_acumulado`)) AS `categoria_6_peso_ok`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    (
  select 
    sum(`x`.`total_enviado_gestor_residuos`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `total_enviado_gestor_residuos_suma`,`da`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos_acumulado`,(
  select 
    (`total_enviado_gestor_residuos_suma` = `total_enviado_gestor_residuos_acumulado`)) AS `total_enviado_gestor_residuos_ok`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    (
  select 
    sum(`x`.`embalajes_y_etiquetas`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `embalajes_y_etiquetas_suma`,`da`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas_acumulado`,(
  select 
    (`embalajes_y_etiquetas_suma` = `embalajes_y_etiquetas_acumulado`)) AS `embalajes_y_etiquetas_ok` 
  from 
    (`demostrativo_diario` `d` join `demostrativo_acumulativo` `da` on((`da`.`demostrativo_diario_id` = `d`.`id`))) 
  where 
    (`d`.`demostrativo_id` = 2) 
  order by 
    `d`.`date`;

#
# Definition for the `vw_check_data_demostrativo_3` view : 
#

CREATE  VIEW `vw_check_data_demostrativo_3`
AS
select 
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`id` AS `id`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    (
  select 
    sum(`x`.`equipos_procesados`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `equipos_procesados_suma`,`da`.`equipos_procesados` AS `equipos_procesados_acumulado`,(
  select 
    (`equipos_procesados_suma` = `equipos_procesados_acumulado`)) AS `equipos_procesados_ok`,
    `d`.`parametro_1` AS `parametro_1`,
    (
  select 
    sum(`x`.`parametro_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_1_suma`,`da`.`parametro_1` AS `parametro_1_acumulado`,(
  select 
    (`parametro_1_suma` = `parametro_1_acumulado`)) AS `parametro_1_ok`,
    `d`.`parametro_2` AS `parametro_2`,
    (
  select 
    sum(`x`.`parametro_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_2_suma`,`da`.`parametro_2` AS `parametro_2_acumulado`,(
  select 
    (`parametro_2_suma` = `parametro_2_acumulado`)) AS `parametro_2_ok`,
    `d`.`parametro_3` AS `parametro_3`,
    (
  select 
    sum(`x`.`parametro_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_3_suma`,`da`.`parametro_3` AS `parametro_3_acumulado`,(
  select 
    (`parametro_3_suma` = `parametro_3_acumulado`)) AS `parametro_3_ok`,
    `d`.`parametro_4` AS `parametro_4`,
    (
  select 
    sum(`x`.`parametro_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_4_suma`,`da`.`parametro_4` AS `parametro_4_acumulado`,(
  select 
    (`parametro_4_suma` = `parametro_4_acumulado`)) AS `parametro_4_ok`,
    `d`.`parametro_5` AS `parametro_5`,
    (
  select 
    sum(`x`.`parametro_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_5_suma`,`da`.`parametro_5` AS `parametro_5_acumulado`,(
  select 
    (`parametro_5_suma` = `parametro_5_acumulado`)) AS `parametro_5_ok`,
    `d`.`parametro_6` AS `parametro_6`,
    (
  select 
    sum(`x`.`parametro_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_6_suma`,`da`.`parametro_6` AS `parametro_6_acumulado`,(
  select 
    (`parametro_6_suma` = `parametro_6_acumulado`)) AS `parametro_6_ok`,
    `d`.`parametro_7` AS `parametro_7`,
    (
  select 
    sum(`x`.`parametro_7`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_7_suma`,`da`.`parametro_7` AS `parametro_7_acumulado`,(
  select 
    (`parametro_7_suma` = `parametro_7_acumulado`)) AS `parametro_7_ok`,
    `d`.`parametro_8` AS `parametro_8`,
    (
  select 
    sum(`x`.`parametro_8`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_8_suma`,`da`.`parametro_8` AS `parametro_8_acumulado`,(
  select 
    (`parametro_8_suma` = `parametro_8_acumulado`)) AS `parametro_8_ok`,
    `d`.`parametro_9` AS `parametro_9`,
    (
  select 
    sum(`x`.`parametro_9`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_9_suma`,`da`.`parametro_9` AS `parametro_9_acumulado`,(
  select 
    (`parametro_9_suma` = `parametro_9_acumulado`)) AS `parametro_9_ok`,
    `d`.`parametro_10` AS `parametro_10`,
    (
  select 
    sum(`x`.`parametro_10`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_10_suma`,`da`.`parametro_10` AS `parametro_10_acumulado`,(
  select 
    (`parametro_10_suma` = `parametro_10_acumulado`)) AS `parametro_10_ok`,
    `d`.`parametro_11` AS `parametro_11`,
    (
  select 
    sum(`x`.`parametro_11`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_11_suma`,`da`.`parametro_11` AS `parametro_11_acumulado`,(
  select 
    (`parametro_11_suma` = `parametro_11_acumulado`)) AS `parametro_11_ok`,
    `d`.`parametro_12` AS `parametro_12`,
    (
  select 
    sum(`x`.`parametro_12`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_12_suma`,`da`.`parametro_12` AS `parametro_12_acumulado`,(
  select 
    (`parametro_12_suma` = `parametro_12_acumulado`)) AS `parametro_12_ok`,
    `d`.`parametro_13` AS `parametro_13`,
    (
  select 
    sum(`x`.`parametro_13`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_13_suma`,`da`.`parametro_13` AS `parametro_13_acumulado`,(
  select 
    (`parametro_13_suma` = `parametro_13_acumulado`)) AS `parametro_13_ok`,
    `d`.`parametro_14` AS `parametro_14`,
    (
  select 
    sum(`x`.`parametro_14`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_14_suma`,`da`.`parametro_14` AS `parametro_14_acumulado`,(
  select 
    (`parametro_14_suma` = `parametro_14_acumulado`)) AS `parametro_14_ok`,
    `d`.`parametro_15` AS `parametro_15`,
    (
  select 
    sum(`x`.`parametro_15`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_15_suma`,`da`.`parametro_15` AS `parametro_15_acumulado`,(
  select 
    (`parametro_15_suma` = `parametro_15_acumulado`)) AS `parametro_15_ok`,
    `d`.`parametro_16` AS `parametro_16`,
    (
  select 
    sum(`x`.`parametro_16`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_16_suma`,`da`.`parametro_16` AS `parametro_16_acumulado`,(
  select 
    (`parametro_16_suma` = `parametro_16_acumulado`)) AS `parametro_16_ok`,
    `d`.`parametro_17` AS `parametro_17`,
    (
  select 
    sum(`x`.`parametro_17`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_17_suma`,`da`.`parametro_17` AS `parametro_17_acumulado`,(
  select 
    (`parametro_17_suma` = `parametro_17_acumulado`)) AS `parametro_17_ok`,
    `d`.`parametro_18` AS `parametro_18`,
    (
  select 
    sum(`x`.`parametro_18`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_18_suma`,`da`.`parametro_18` AS `parametro_18_acumulado`,(
  select 
    (`parametro_18_suma` = `parametro_18_acumulado`)) AS `parametro_18_ok`,
    `d`.`parametro_19` AS `parametro_19`,
    (
  select 
    sum(`x`.`parametro_19`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_19_suma`,`da`.`parametro_19` AS `parametro_19_acumulado`,(
  select 
    (`parametro_19_suma` = `parametro_19_acumulado`)) AS `parametro_19_ok`,
    `d`.`parametro_20` AS `parametro_20`,
    (
  select 
    sum(`x`.`parametro_20`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_20_suma`,`da`.`parametro_20` AS `parametro_20_acumulado`,(
  select 
    (`parametro_20_suma` = `parametro_20_acumulado`)) AS `parametro_20_ok`,
    `d`.`parametro_21` AS `parametro_21`,
    (
  select 
    sum(`x`.`parametro_21`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_21_suma`,`da`.`parametro_21` AS `parametro_21_acumulado`,(
  select 
    (`parametro_21_suma` = `parametro_21_acumulado`)) AS `parametro_21_ok`,
    `d`.`parametro_22` AS `parametro_22`,
    (
  select 
    sum(`x`.`parametro_22`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_22_suma`,`da`.`parametro_22` AS `parametro_22_acumulado`,(
  select 
    (`parametro_22_suma` = `parametro_22_acumulado`)) AS `parametro_22_ok`,
    `d`.`parametro_23` AS `parametro_23`,
    (
  select 
    sum(`x`.`parametro_23`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_23_suma`,`da`.`parametro_23` AS `parametro_23_acumulado`,(
  select 
    (`parametro_23_suma` = `parametro_23_acumulado`)) AS `parametro_23_ok`,
    `d`.`parametro_24` AS `parametro_24`,
    (
  select 
    sum(`x`.`parametro_24`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_24_suma`,`da`.`parametro_24` AS `parametro_24_acumulado`,(
  select 
    (`parametro_24_suma` = `parametro_24_acumulado`)) AS `parametro_24_ok`,
    `d`.`parametro_25` AS `parametro_25`,
    (
  select 
    sum(`x`.`parametro_25`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_25_suma`,`da`.`parametro_25` AS `parametro_25_acumulado`,(
  select 
    (`parametro_25_suma` = `parametro_25_acumulado`)) AS `parametro_25_ok`,
    `d`.`parametro_26` AS `parametro_26`,
    (
  select 
    sum(`x`.`parametro_26`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_26_suma`,`da`.`parametro_26` AS `parametro_26_acumulado`,(
  select 
    (`parametro_26_suma` = `parametro_26_acumulado`)) AS `parametro_26_ok`,
    `d`.`parametro_27` AS `parametro_27`,
    (
  select 
    sum(`x`.`parametro_27`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_27_suma`,`da`.`parametro_27` AS `parametro_27_acumulado`,(
  select 
    (`parametro_27_suma` = `parametro_27_acumulado`)) AS `parametro_27_ok`,
    `d`.`parametro_28` AS `parametro_28`,
    (
  select 
    sum(`x`.`parametro_28`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_28_suma`,`da`.`parametro_28` AS `parametro_28_acumulado`,(
  select 
    (`parametro_28_suma` = `parametro_28_acumulado`)) AS `parametro_28_ok`,
    `d`.`parametro_29` AS `parametro_29`,
    (
  select 
    sum(`x`.`parametro_29`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_29_suma`,`da`.`parametro_29` AS `parametro_29_acumulado`,(
  select 
    (`parametro_29_suma` = `parametro_29_acumulado`)) AS `parametro_29_ok`,
    `d`.`parametro_30` AS `parametro_30`,
    (
  select 
    sum(`x`.`parametro_30`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_30_suma`,`da`.`parametro_30` AS `parametro_30_acumulado`,(
  select 
    (`parametro_30_suma` = `parametro_30_acumulado`)) AS `parametro_30_ok`,
    `d`.`parametro_31` AS `parametro_31`,
    (
  select 
    sum(`x`.`parametro_31`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_31_suma`,`da`.`parametro_31` AS `parametro_31_acumulado`,(
  select 
    (`parametro_31_suma` = `parametro_31_acumulado`)) AS `parametro_31_ok`,
    `d`.`parametro_32` AS `parametro_32`,
    (
  select 
    sum(`x`.`parametro_32`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_32_suma`,`da`.`parametro_32` AS `parametro_32_acumulado`,(
  select 
    (`parametro_32_suma` = `parametro_32_acumulado`)) AS `parametro_32_ok`,
    `d`.`parametro_33` AS `parametro_33`,
    (
  select 
    sum(`x`.`parametro_33`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_33_suma`,`da`.`parametro_33` AS `parametro_33_acumulado`,(
  select 
    (`parametro_33_suma` = `parametro_33_acumulado`)) AS `parametro_33_ok`,
    `d`.`parametro_34` AS `parametro_34`,
    (
  select 
    sum(`x`.`parametro_34`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_34_suma`,`da`.`parametro_34` AS `parametro_34_acumulado`,(
  select 
    (`parametro_34_suma` = `parametro_34_acumulado`)) AS `parametro_34_ok`,
    `d`.`parametro_35` AS `parametro_35`,
    (
  select 
    sum(`x`.`parametro_35`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_35_suma`,`da`.`parametro_35` AS `parametro_35_acumulado`,(
  select 
    (`parametro_35_suma` = `parametro_35_acumulado`)) AS `parametro_35_ok`,
    `d`.`parametro_36` AS `parametro_36`,
    (
  select 
    sum(`x`.`parametro_36`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_36_suma`,`da`.`parametro_36` AS `parametro_36_acumulado`,(
  select 
    (`parametro_36_suma` = `parametro_36_acumulado`)) AS `parametro_36_ok`,
    `d`.`parametro_37` AS `parametro_37`,
    (
  select 
    sum(`x`.`parametro_37`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_37_suma`,`da`.`parametro_37` AS `parametro_37_acumulado`,(
  select 
    (`parametro_37_suma` = `parametro_37_acumulado`)) AS `parametro_37_ok`,
    `d`.`parametro_38` AS `parametro_38`,
    (
  select 
    sum(`x`.`parametro_38`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_38_suma`,`da`.`parametro_38` AS `parametro_38_acumulado`,(
  select 
    (`parametro_38_suma` = `parametro_38_acumulado`)) AS `parametro_38_ok`,
    `d`.`parametro_39` AS `parametro_39`,
    (
  select 
    sum(`x`.`parametro_39`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_39_suma`,`da`.`parametro_39` AS `parametro_39_acumulado`,(
  select 
    (`parametro_39_suma` = `parametro_39_acumulado`)) AS `parametro_39_ok`,
    `d`.`parametro_40` AS `parametro_40`,
    (
  select 
    sum(`x`.`parametro_40`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_40_suma`,`da`.`parametro_40` AS `parametro_40_acumulado`,(
  select 
    (`parametro_40_suma` = `parametro_40_acumulado`)) AS `parametro_40_ok`,
    `d`.`categoria_1` AS `categoria_1`,
    (
  select 
    sum(`x`.`categoria_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_suma`,`da`.`categoria_1` AS `categoria_1_acumulado`,(
  select 
    (`categoria_1_suma` = `categoria_1_acumulado`)) AS `categoria_1_ok`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    (
  select 
    sum(`x`.`categoria_1_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_ui_suma`,`da`.`categoria_1_ui` AS `categoria_1_ui_acumulado`,(
  select 
    (`categoria_1_ui_suma` = `categoria_1_ui_acumulado`)) AS `categoria_1_ui_ok`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    (
  select 
    sum(`x`.`categoria_1_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_peso_suma`,`da`.`categoria_1_peso` AS `categoria_1_peso_acumulado`,(
  select 
    (`categoria_1_peso_suma` = `categoria_1_peso_acumulado`)) AS `categoria_1_peso_ok`,
    `d`.`categoria_2` AS `categoria_2`,
    (
  select 
    sum(`x`.`categoria_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_suma`,`da`.`categoria_2` AS `categoria_2_acumulado`,(
  select 
    (`categoria_2_suma` = `categoria_2_acumulado`)) AS `categoria_2_ok`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    (
  select 
    sum(`x`.`categoria_2_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_ui_suma`,`da`.`categoria_2_ui` AS `categoria_2_ui_acumulado`,(
  select 
    (`categoria_2_ui_suma` = `categoria_2_ui_acumulado`)) AS `categoria_2_ui_ok`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    (
  select 
    sum(`x`.`categoria_2_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_peso_suma`,`da`.`categoria_2_peso` AS `categoria_2_peso_acumulado`,(
  select 
    (`categoria_2_peso_suma` = `categoria_2_peso_acumulado`)) AS `categoria_2_peso_ok`,
    `d`.`categoria_3` AS `categoria_3`,
    (
  select 
    sum(`x`.`categoria_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_suma`,`da`.`categoria_3` AS `categoria_3_acumulado`,(
  select 
    (`categoria_3_suma` = `categoria_3_acumulado`)) AS `categoria_3_ok`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    (
  select 
    sum(`x`.`categoria_3_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_ui_suma`,`da`.`categoria_3_ui` AS `categoria_3_ui_acumulado`,(
  select 
    (`categoria_3_ui_suma` = `categoria_3_ui_acumulado`)) AS `categoria_3_ui_ok`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    (
  select 
    sum(`x`.`categoria_3_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_peso_suma`,`da`.`categoria_3_peso` AS `categoria_3_peso_acumulado`,(
  select 
    (`categoria_3_peso_suma` = `categoria_3_peso_acumulado`)) AS `categoria_3_peso_ok`,
    `d`.`categoria_4` AS `categoria_4`,
    (
  select 
    sum(`x`.`categoria_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_suma`,`da`.`categoria_4` AS `categoria_4_acumulado`,(
  select 
    (`categoria_4_suma` = `categoria_4_acumulado`)) AS `categoria_4_ok`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    (
  select 
    sum(`x`.`categoria_4_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_ui_suma`,`da`.`categoria_4_ui` AS `categoria_4_ui_acumulado`,(
  select 
    (`categoria_4_ui_suma` = `categoria_4_ui_acumulado`)) AS `categoria_4_ui_ok`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    (
  select 
    sum(`x`.`categoria_4_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_peso_suma`,`da`.`categoria_4_peso` AS `categoria_4_peso_acumulado`,(
  select 
    (`categoria_4_peso_suma` = `categoria_4_peso_acumulado`)) AS `categoria_4_peso_ok`,
    `d`.`categoria_5` AS `categoria_5`,
    (
  select 
    sum(`x`.`categoria_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_suma`,`da`.`categoria_5` AS `categoria_5_acumulado`,(
  select 
    (`categoria_5_suma` = `categoria_5_acumulado`)) AS `categoria_5_ok`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    (
  select 
    sum(`x`.`categoria_5_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_ui_suma`,`da`.`categoria_5_ui` AS `categoria_5_ui_acumulado`,(
  select 
    (`categoria_5_ui_suma` = `categoria_5_ui_acumulado`)) AS `categoria_5_ui_ok`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    (
  select 
    sum(`x`.`categoria_5_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_peso_suma`,`da`.`categoria_5_peso` AS `categoria_5_peso_acumulado`,(
  select 
    (`categoria_5_peso_suma` = `categoria_5_peso_acumulado`)) AS `categoria_5_peso_ok`,
    `d`.`categoria_6` AS `categoria_6`,
    (
  select 
    sum(`x`.`categoria_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_suma`,`da`.`categoria_6` AS `categoria_6_acumulado`,(
  select 
    (`categoria_6_suma` = `categoria_6_acumulado`)) AS `categoria_6_ok`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    (
  select 
    sum(`x`.`categoria_6_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_ui_suma`,`da`.`categoria_6_ui` AS `categoria_6_ui_acumulado`,(
  select 
    (`categoria_6_ui_suma` = `categoria_6_ui_acumulado`)) AS `categoria_6_ui_ok`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    (
  select 
    sum(`x`.`categoria_6_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_peso_suma`,`da`.`categoria_6_peso` AS `categoria_6_peso_acumulado`,(
  select 
    (`categoria_6_peso_suma` = `categoria_6_peso_acumulado`)) AS `categoria_6_peso_ok`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    (
  select 
    sum(`x`.`total_enviado_gestor_residuos`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `total_enviado_gestor_residuos_suma`,`da`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos_acumulado`,(
  select 
    (`total_enviado_gestor_residuos_suma` = `total_enviado_gestor_residuos_acumulado`)) AS `total_enviado_gestor_residuos_ok`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    (
  select 
    sum(`x`.`embalajes_y_etiquetas`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `embalajes_y_etiquetas_suma`,`da`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas_acumulado`,(
  select 
    (`embalajes_y_etiquetas_suma` = `embalajes_y_etiquetas_acumulado`)) AS `embalajes_y_etiquetas_ok` 
  from 
    (`demostrativo_diario` `d` join `demostrativo_acumulativo` `da` on((`da`.`demostrativo_diario_id` = `d`.`id`))) 
  where 
    (`d`.`demostrativo_id` = 3) 
  order by 
    `d`.`date`;

#
# Definition for the `vw_check_data_demostrativo_4` view : 
#

CREATE  VIEW `vw_check_data_demostrativo_4`
AS
select 
    `d`.`demostrativo_id` AS `demostrativo_id`,
    `d`.`date` AS `date`,
    `d`.`id` AS `id`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    (
  select 
    sum(`x`.`equipos_procesados`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `equipos_procesados_suma`,`da`.`equipos_procesados` AS `equipos_procesados_acumulado`,(
  select 
    (`equipos_procesados_suma` = `equipos_procesados_acumulado`)) AS `equipos_procesados_ok`,
    `d`.`parametro_1` AS `parametro_1`,
    (
  select 
    sum(`x`.`parametro_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_1_suma`,`da`.`parametro_1` AS `parametro_1_acumulado`,(
  select 
    (`parametro_1_suma` = `parametro_1_acumulado`)) AS `parametro_1_ok`,
    `d`.`parametro_2` AS `parametro_2`,
    (
  select 
    sum(`x`.`parametro_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_2_suma`,`da`.`parametro_2` AS `parametro_2_acumulado`,(
  select 
    (`parametro_2_suma` = `parametro_2_acumulado`)) AS `parametro_2_ok`,
    `d`.`parametro_3` AS `parametro_3`,
    (
  select 
    sum(`x`.`parametro_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_3_suma`,`da`.`parametro_3` AS `parametro_3_acumulado`,(
  select 
    (`parametro_3_suma` = `parametro_3_acumulado`)) AS `parametro_3_ok`,
    `d`.`parametro_4` AS `parametro_4`,
    (
  select 
    sum(`x`.`parametro_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_4_suma`,`da`.`parametro_4` AS `parametro_4_acumulado`,(
  select 
    (`parametro_4_suma` = `parametro_4_acumulado`)) AS `parametro_4_ok`,
    `d`.`parametro_5` AS `parametro_5`,
    (
  select 
    sum(`x`.`parametro_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_5_suma`,`da`.`parametro_5` AS `parametro_5_acumulado`,(
  select 
    (`parametro_5_suma` = `parametro_5_acumulado`)) AS `parametro_5_ok`,
    `d`.`parametro_6` AS `parametro_6`,
    (
  select 
    sum(`x`.`parametro_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_6_suma`,`da`.`parametro_6` AS `parametro_6_acumulado`,(
  select 
    (`parametro_6_suma` = `parametro_6_acumulado`)) AS `parametro_6_ok`,
    `d`.`parametro_7` AS `parametro_7`,
    (
  select 
    sum(`x`.`parametro_7`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_7_suma`,`da`.`parametro_7` AS `parametro_7_acumulado`,(
  select 
    (`parametro_7_suma` = `parametro_7_acumulado`)) AS `parametro_7_ok`,
    `d`.`parametro_8` AS `parametro_8`,
    (
  select 
    sum(`x`.`parametro_8`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_8_suma`,`da`.`parametro_8` AS `parametro_8_acumulado`,(
  select 
    (`parametro_8_suma` = `parametro_8_acumulado`)) AS `parametro_8_ok`,
    `d`.`parametro_9` AS `parametro_9`,
    (
  select 
    sum(`x`.`parametro_9`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_9_suma`,`da`.`parametro_9` AS `parametro_9_acumulado`,(
  select 
    (`parametro_9_suma` = `parametro_9_acumulado`)) AS `parametro_9_ok`,
    `d`.`parametro_10` AS `parametro_10`,
    (
  select 
    sum(`x`.`parametro_10`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_10_suma`,`da`.`parametro_10` AS `parametro_10_acumulado`,(
  select 
    (`parametro_10_suma` = `parametro_10_acumulado`)) AS `parametro_10_ok`,
    `d`.`parametro_11` AS `parametro_11`,
    (
  select 
    sum(`x`.`parametro_11`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_11_suma`,`da`.`parametro_11` AS `parametro_11_acumulado`,(
  select 
    (`parametro_11_suma` = `parametro_11_acumulado`)) AS `parametro_11_ok`,
    `d`.`parametro_12` AS `parametro_12`,
    (
  select 
    sum(`x`.`parametro_12`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_12_suma`,`da`.`parametro_12` AS `parametro_12_acumulado`,(
  select 
    (`parametro_12_suma` = `parametro_12_acumulado`)) AS `parametro_12_ok`,
    `d`.`parametro_13` AS `parametro_13`,
    (
  select 
    sum(`x`.`parametro_13`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_13_suma`,`da`.`parametro_13` AS `parametro_13_acumulado`,(
  select 
    (`parametro_13_suma` = `parametro_13_acumulado`)) AS `parametro_13_ok`,
    `d`.`parametro_14` AS `parametro_14`,
    (
  select 
    sum(`x`.`parametro_14`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_14_suma`,`da`.`parametro_14` AS `parametro_14_acumulado`,(
  select 
    (`parametro_14_suma` = `parametro_14_acumulado`)) AS `parametro_14_ok`,
    `d`.`parametro_15` AS `parametro_15`,
    (
  select 
    sum(`x`.`parametro_15`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_15_suma`,`da`.`parametro_15` AS `parametro_15_acumulado`,(
  select 
    (`parametro_15_suma` = `parametro_15_acumulado`)) AS `parametro_15_ok`,
    `d`.`parametro_16` AS `parametro_16`,
    (
  select 
    sum(`x`.`parametro_16`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_16_suma`,`da`.`parametro_16` AS `parametro_16_acumulado`,(
  select 
    (`parametro_16_suma` = `parametro_16_acumulado`)) AS `parametro_16_ok`,
    `d`.`parametro_17` AS `parametro_17`,
    (
  select 
    sum(`x`.`parametro_17`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_17_suma`,`da`.`parametro_17` AS `parametro_17_acumulado`,(
  select 
    (`parametro_17_suma` = `parametro_17_acumulado`)) AS `parametro_17_ok`,
    `d`.`parametro_18` AS `parametro_18`,
    (
  select 
    sum(`x`.`parametro_18`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_18_suma`,`da`.`parametro_18` AS `parametro_18_acumulado`,(
  select 
    (`parametro_18_suma` = `parametro_18_acumulado`)) AS `parametro_18_ok`,
    `d`.`parametro_19` AS `parametro_19`,
    (
  select 
    sum(`x`.`parametro_19`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_19_suma`,`da`.`parametro_19` AS `parametro_19_acumulado`,(
  select 
    (`parametro_19_suma` = `parametro_19_acumulado`)) AS `parametro_19_ok`,
    `d`.`parametro_20` AS `parametro_20`,
    (
  select 
    sum(`x`.`parametro_20`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_20_suma`,`da`.`parametro_20` AS `parametro_20_acumulado`,(
  select 
    (`parametro_20_suma` = `parametro_20_acumulado`)) AS `parametro_20_ok`,
    `d`.`parametro_21` AS `parametro_21`,
    (
  select 
    sum(`x`.`parametro_21`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_21_suma`,`da`.`parametro_21` AS `parametro_21_acumulado`,(
  select 
    (`parametro_21_suma` = `parametro_21_acumulado`)) AS `parametro_21_ok`,
    `d`.`parametro_22` AS `parametro_22`,
    (
  select 
    sum(`x`.`parametro_22`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_22_suma`,`da`.`parametro_22` AS `parametro_22_acumulado`,(
  select 
    (`parametro_22_suma` = `parametro_22_acumulado`)) AS `parametro_22_ok`,
    `d`.`parametro_23` AS `parametro_23`,
    (
  select 
    sum(`x`.`parametro_23`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_23_suma`,`da`.`parametro_23` AS `parametro_23_acumulado`,(
  select 
    (`parametro_23_suma` = `parametro_23_acumulado`)) AS `parametro_23_ok`,
    `d`.`parametro_24` AS `parametro_24`,
    (
  select 
    sum(`x`.`parametro_24`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_24_suma`,`da`.`parametro_24` AS `parametro_24_acumulado`,(
  select 
    (`parametro_24_suma` = `parametro_24_acumulado`)) AS `parametro_24_ok`,
    `d`.`parametro_25` AS `parametro_25`,
    (
  select 
    sum(`x`.`parametro_25`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_25_suma`,`da`.`parametro_25` AS `parametro_25_acumulado`,(
  select 
    (`parametro_25_suma` = `parametro_25_acumulado`)) AS `parametro_25_ok`,
    `d`.`parametro_26` AS `parametro_26`,
    (
  select 
    sum(`x`.`parametro_26`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_26_suma`,`da`.`parametro_26` AS `parametro_26_acumulado`,(
  select 
    (`parametro_26_suma` = `parametro_26_acumulado`)) AS `parametro_26_ok`,
    `d`.`parametro_27` AS `parametro_27`,
    (
  select 
    sum(`x`.`parametro_27`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_27_suma`,`da`.`parametro_27` AS `parametro_27_acumulado`,(
  select 
    (`parametro_27_suma` = `parametro_27_acumulado`)) AS `parametro_27_ok`,
    `d`.`parametro_28` AS `parametro_28`,
    (
  select 
    sum(`x`.`parametro_28`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_28_suma`,`da`.`parametro_28` AS `parametro_28_acumulado`,(
  select 
    (`parametro_28_suma` = `parametro_28_acumulado`)) AS `parametro_28_ok`,
    `d`.`parametro_29` AS `parametro_29`,
    (
  select 
    sum(`x`.`parametro_29`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_29_suma`,`da`.`parametro_29` AS `parametro_29_acumulado`,(
  select 
    (`parametro_29_suma` = `parametro_29_acumulado`)) AS `parametro_29_ok`,
    `d`.`parametro_30` AS `parametro_30`,
    (
  select 
    sum(`x`.`parametro_30`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_30_suma`,`da`.`parametro_30` AS `parametro_30_acumulado`,(
  select 
    (`parametro_30_suma` = `parametro_30_acumulado`)) AS `parametro_30_ok`,
    `d`.`parametro_31` AS `parametro_31`,
    (
  select 
    sum(`x`.`parametro_31`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_31_suma`,`da`.`parametro_31` AS `parametro_31_acumulado`,(
  select 
    (`parametro_31_suma` = `parametro_31_acumulado`)) AS `parametro_31_ok`,
    `d`.`parametro_32` AS `parametro_32`,
    (
  select 
    sum(`x`.`parametro_32`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_32_suma`,`da`.`parametro_32` AS `parametro_32_acumulado`,(
  select 
    (`parametro_32_suma` = `parametro_32_acumulado`)) AS `parametro_32_ok`,
    `d`.`parametro_33` AS `parametro_33`,
    (
  select 
    sum(`x`.`parametro_33`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_33_suma`,`da`.`parametro_33` AS `parametro_33_acumulado`,(
  select 
    (`parametro_33_suma` = `parametro_33_acumulado`)) AS `parametro_33_ok`,
    `d`.`parametro_34` AS `parametro_34`,
    (
  select 
    sum(`x`.`parametro_34`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_34_suma`,`da`.`parametro_34` AS `parametro_34_acumulado`,(
  select 
    (`parametro_34_suma` = `parametro_34_acumulado`)) AS `parametro_34_ok`,
    `d`.`parametro_35` AS `parametro_35`,
    (
  select 
    sum(`x`.`parametro_35`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_35_suma`,`da`.`parametro_35` AS `parametro_35_acumulado`,(
  select 
    (`parametro_35_suma` = `parametro_35_acumulado`)) AS `parametro_35_ok`,
    `d`.`parametro_36` AS `parametro_36`,
    (
  select 
    sum(`x`.`parametro_36`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_36_suma`,`da`.`parametro_36` AS `parametro_36_acumulado`,(
  select 
    (`parametro_36_suma` = `parametro_36_acumulado`)) AS `parametro_36_ok`,
    `d`.`parametro_37` AS `parametro_37`,
    (
  select 
    sum(`x`.`parametro_37`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_37_suma`,`da`.`parametro_37` AS `parametro_37_acumulado`,(
  select 
    (`parametro_37_suma` = `parametro_37_acumulado`)) AS `parametro_37_ok`,
    `d`.`parametro_38` AS `parametro_38`,
    (
  select 
    sum(`x`.`parametro_38`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_38_suma`,`da`.`parametro_38` AS `parametro_38_acumulado`,(
  select 
    (`parametro_38_suma` = `parametro_38_acumulado`)) AS `parametro_38_ok`,
    `d`.`parametro_39` AS `parametro_39`,
    (
  select 
    sum(`x`.`parametro_39`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_39_suma`,`da`.`parametro_39` AS `parametro_39_acumulado`,(
  select 
    (`parametro_39_suma` = `parametro_39_acumulado`)) AS `parametro_39_ok`,
    `d`.`parametro_40` AS `parametro_40`,
    (
  select 
    sum(`x`.`parametro_40`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `parametro_40_suma`,`da`.`parametro_40` AS `parametro_40_acumulado`,(
  select 
    (`parametro_40_suma` = `parametro_40_acumulado`)) AS `parametro_40_ok`,
    `d`.`categoria_1` AS `categoria_1`,
    (
  select 
    sum(`x`.`categoria_1`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_suma`,`da`.`categoria_1` AS `categoria_1_acumulado`,(
  select 
    (`categoria_1_suma` = `categoria_1_acumulado`)) AS `categoria_1_ok`,
    `d`.`categoria_1_ui` AS `categoria_1_ui`,
    (
  select 
    sum(`x`.`categoria_1_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_ui_suma`,`da`.`categoria_1_ui` AS `categoria_1_ui_acumulado`,(
  select 
    (`categoria_1_ui_suma` = `categoria_1_ui_acumulado`)) AS `categoria_1_ui_ok`,
    `d`.`categoria_1_peso` AS `categoria_1_peso`,
    (
  select 
    sum(`x`.`categoria_1_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_1_peso_suma`,`da`.`categoria_1_peso` AS `categoria_1_peso_acumulado`,(
  select 
    (`categoria_1_peso_suma` = `categoria_1_peso_acumulado`)) AS `categoria_1_peso_ok`,
    `d`.`categoria_2` AS `categoria_2`,
    (
  select 
    sum(`x`.`categoria_2`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_suma`,`da`.`categoria_2` AS `categoria_2_acumulado`,(
  select 
    (`categoria_2_suma` = `categoria_2_acumulado`)) AS `categoria_2_ok`,
    `d`.`categoria_2_ui` AS `categoria_2_ui`,
    (
  select 
    sum(`x`.`categoria_2_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_ui_suma`,`da`.`categoria_2_ui` AS `categoria_2_ui_acumulado`,(
  select 
    (`categoria_2_ui_suma` = `categoria_2_ui_acumulado`)) AS `categoria_2_ui_ok`,
    `d`.`categoria_2_peso` AS `categoria_2_peso`,
    (
  select 
    sum(`x`.`categoria_2_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_2_peso_suma`,`da`.`categoria_2_peso` AS `categoria_2_peso_acumulado`,(
  select 
    (`categoria_2_peso_suma` = `categoria_2_peso_acumulado`)) AS `categoria_2_peso_ok`,
    `d`.`categoria_3` AS `categoria_3`,
    (
  select 
    sum(`x`.`categoria_3`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_suma`,`da`.`categoria_3` AS `categoria_3_acumulado`,(
  select 
    (`categoria_3_suma` = `categoria_3_acumulado`)) AS `categoria_3_ok`,
    `d`.`categoria_3_ui` AS `categoria_3_ui`,
    (
  select 
    sum(`x`.`categoria_3_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_ui_suma`,`da`.`categoria_3_ui` AS `categoria_3_ui_acumulado`,(
  select 
    (`categoria_3_ui_suma` = `categoria_3_ui_acumulado`)) AS `categoria_3_ui_ok`,
    `d`.`categoria_3_peso` AS `categoria_3_peso`,
    (
  select 
    sum(`x`.`categoria_3_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_3_peso_suma`,`da`.`categoria_3_peso` AS `categoria_3_peso_acumulado`,(
  select 
    (`categoria_3_peso_suma` = `categoria_3_peso_acumulado`)) AS `categoria_3_peso_ok`,
    `d`.`categoria_4` AS `categoria_4`,
    (
  select 
    sum(`x`.`categoria_4`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_suma`,`da`.`categoria_4` AS `categoria_4_acumulado`,(
  select 
    (`categoria_4_suma` = `categoria_4_acumulado`)) AS `categoria_4_ok`,
    `d`.`categoria_4_ui` AS `categoria_4_ui`,
    (
  select 
    sum(`x`.`categoria_4_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_ui_suma`,`da`.`categoria_4_ui` AS `categoria_4_ui_acumulado`,(
  select 
    (`categoria_4_ui_suma` = `categoria_4_ui_acumulado`)) AS `categoria_4_ui_ok`,
    `d`.`categoria_4_peso` AS `categoria_4_peso`,
    (
  select 
    sum(`x`.`categoria_4_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_4_peso_suma`,`da`.`categoria_4_peso` AS `categoria_4_peso_acumulado`,(
  select 
    (`categoria_4_peso_suma` = `categoria_4_peso_acumulado`)) AS `categoria_4_peso_ok`,
    `d`.`categoria_5` AS `categoria_5`,
    (
  select 
    sum(`x`.`categoria_5`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_suma`,`da`.`categoria_5` AS `categoria_5_acumulado`,(
  select 
    (`categoria_5_suma` = `categoria_5_acumulado`)) AS `categoria_5_ok`,
    `d`.`categoria_5_ui` AS `categoria_5_ui`,
    (
  select 
    sum(`x`.`categoria_5_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_ui_suma`,`da`.`categoria_5_ui` AS `categoria_5_ui_acumulado`,(
  select 
    (`categoria_5_ui_suma` = `categoria_5_ui_acumulado`)) AS `categoria_5_ui_ok`,
    `d`.`categoria_5_peso` AS `categoria_5_peso`,
    (
  select 
    sum(`x`.`categoria_5_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_5_peso_suma`,`da`.`categoria_5_peso` AS `categoria_5_peso_acumulado`,(
  select 
    (`categoria_5_peso_suma` = `categoria_5_peso_acumulado`)) AS `categoria_5_peso_ok`,
    `d`.`categoria_6` AS `categoria_6`,
    (
  select 
    sum(`x`.`categoria_6`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_suma`,`da`.`categoria_6` AS `categoria_6_acumulado`,(
  select 
    (`categoria_6_suma` = `categoria_6_acumulado`)) AS `categoria_6_ok`,
    `d`.`categoria_6_ui` AS `categoria_6_ui`,
    (
  select 
    sum(`x`.`categoria_6_ui`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_ui_suma`,`da`.`categoria_6_ui` AS `categoria_6_ui_acumulado`,(
  select 
    (`categoria_6_ui_suma` = `categoria_6_ui_acumulado`)) AS `categoria_6_ui_ok`,
    `d`.`categoria_6_peso` AS `categoria_6_peso`,
    (
  select 
    sum(`x`.`categoria_6_peso`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `categoria_6_peso_suma`,`da`.`categoria_6_peso` AS `categoria_6_peso_acumulado`,(
  select 
    (`categoria_6_peso_suma` = `categoria_6_peso_acumulado`)) AS `categoria_6_peso_ok`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    (
  select 
    sum(`x`.`total_enviado_gestor_residuos`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `total_enviado_gestor_residuos_suma`,`da`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos_acumulado`,(
  select 
    (`total_enviado_gestor_residuos_suma` = `total_enviado_gestor_residuos_acumulado`)) AS `total_enviado_gestor_residuos_ok`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    (
  select 
    sum(`x`.`embalajes_y_etiquetas`) 
  from 
    `demostrativo_diario` `x` 
  where 
    ((`x`.`date` <= `d`.`date`) and (`d`.`demostrativo_id` = `x`.`demostrativo_id`))) AS `embalajes_y_etiquetas_suma`,`da`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas_acumulado`,(
  select 
    (`embalajes_y_etiquetas_suma` = `embalajes_y_etiquetas_acumulado`)) AS `embalajes_y_etiquetas_ok` 
  from 
    (`demostrativo_diario` `d` join `demostrativo_acumulativo` `da` on((`da`.`demostrativo_diario_id` = `d`.`id`))) 
  where 
    (`d`.`demostrativo_id` = 4) 
  order by 
    `d`.`date`;

#
# Definition for the `vw_demostrativo_bubble_vars` view : 
#

CREATE  VIEW `vw_demostrativo_bubble_vars`
AS
select 
    `COLUMNS`.`COLUMN_NAME` AS `COLUMN_NAME` 
  from 
    `information_schema`.`COLUMNS` 
  where 
    ((`COLUMNS`.`TABLE_SCHEMA` = 'energylab_demostrativos') and (`COLUMNS`.`TABLE_NAME` = 'demostrativo_acumulativo') and (`COLUMNS`.`COLUMN_NAME` like 'categoria_%') and (`COLUMNS`.`COLUMN_NAME` like '%_peso'));

#
# Definition for the `vw_demostrativo_campos_linechart` view : 
#

CREATE  VIEW `vw_demostrativo_campos_linechart`
AS
select 
    `COLUMNS`.`COLUMN_NAME` AS `COLUMN_NAME` 
  from 
    `information_schema`.`COLUMNS` 
  where 
    ((`COLUMNS`.`TABLE_SCHEMA` = 'energylab_demostrativos') and (`COLUMNS`.`TABLE_NAME` = 'demostrativo_acumulativo') and ((`COLUMNS`.`COLUMN_NAME` in ('equipos_procesados','parametro_2','total_enviado_gestor_residuos','parametro_3','embalajes_y_etiquetas','parametro_6')) or ((`COLUMNS`.`COLUMN_NAME` like 'categoria_%') and (not((`COLUMNS`.`COLUMN_NAME` like '%_peso'))) and (not((`COLUMNS`.`COLUMN_NAME` like '%_ia'))) and (not((`COLUMNS`.`COLUMN_NAME` like '%_ie'))))));

#
# Definition for the `vw_demostrativo_categorias` view : 
#

CREATE  VIEW `vw_demostrativo_categorias`
AS
select 
    `COLUMNS`.`COLUMN_NAME` AS `COLUMN_NAME` 
  from 
    `information_schema`.`COLUMNS` 
  where 
    ((`COLUMNS`.`TABLE_SCHEMA` = 'energylab_demostrativos') and (`COLUMNS`.`TABLE_NAME` = 'demostrativo_acumulativo') and (`COLUMNS`.`COLUMN_NAME` like 'categoria_%') and (length(`COLUMNS`.`COLUMN_NAME`) = 11));

#
# Definition for the `vw_demostrativo_parametros` view : 
#

CREATE  VIEW `vw_demostrativo_parametros`
AS
select 
    `COLUMNS`.`COLUMN_NAME` AS `COLUMN_NAME` 
  from 
    `information_schema`.`COLUMNS` 
  where 
    ((`COLUMNS`.`TABLE_SCHEMA` = 'energylab_demostrativos') and (`COLUMNS`.`TABLE_NAME` = 'demostrativo_acumulativo') and (`COLUMNS`.`COLUMN_NAME` like 'parametro_%'));

#
# Definition for the `vw_max_demostrativo_acumulativo` view : 
#

CREATE  VIEW `vw_max_demostrativo_acumulativo`
AS
(
  select 
    `dd3`.`demostrativo_id` AS `demostrativo_id`,
    min(`dd3`.`date`) AS `fecha_desde`,
    max(`dd3`.`date`) AS `fecha_hasta`,
    ((
  select 
    (to_days(max(`dd3`.`date`)) - to_days(min(`dd3`.`date`)))) + 1) AS `dias_transcurridos`,
    (
  select 
    count(0) 
  from 
    `demostrativo_acumulativo` `dcount` 
  where 
    (`dcount`.`demostrativo_id` = `dd3`.`demostrativo_id`)) AS `dias_registrados`,max(`dd3`.`parametro_1`) AS `parametro_1`,max(`dd3`.`parametro_2`) AS `parametro_2`,max(`dd3`.`parametro_3`) AS `parametro_3`,max(`dd3`.`parametro_4`) AS `parametro_4`,max(`dd3`.`parametro_5`) AS `parametro_5`,max(`dd3`.`parametro_6`) AS `parametro_6`,max(`dd3`.`parametro_7`) AS `parametro_7`,max(`dd3`.`parametro_8`) AS `parametro_8`,max(`dd3`.`parametro_9`) AS `parametro_9`,max(`dd3`.`parametro_10`) AS `parametro_10`,max(`dd3`.`parametro_11`) AS `parametro_11`,max(`dd3`.`parametro_12`) AS `parametro_12`,max(`dd3`.`parametro_13`) AS `parametro_13`,max(`dd3`.`parametro_14`) AS `parametro_14`,max(`dd3`.`parametro_15`) AS `parametro_15`,max(`dd3`.`parametro_16`) AS `parametro_16`,max(`dd3`.`parametro_17`) AS `parametro_17`,max(`dd3`.`parametro_18`) AS `parametro_18`,max(`dd3`.`parametro_19`) AS `parametro_19`,max(`dd3`.`parametro_20`) AS `parametro_20`,max(`dd3`.`parametro_21`) AS `parametro_21`,max(`dd3`.`parametro_22`) AS `parametro_22`,max(`dd3`.`parametro_23`) AS `parametro_23`,max(`dd3`.`parametro_24`) AS `parametro_24`,max(`dd3`.`parametro_25`) AS `parametro_25`,max(`dd3`.`parametro_26`) AS `parametro_26`,max(`dd3`.`parametro_27`) AS `parametro_27`,max(`dd3`.`parametro_28`) AS `parametro_28`,max(`dd3`.`parametro_29`) AS `parametro_29`,max(`dd3`.`parametro_30`) AS `parametro_30`,max(`dd3`.`parametro_31`) AS `parametro_31`,max(`dd3`.`parametro_32`) AS `parametro_32`,max(`dd3`.`parametro_33`) AS `parametro_33`,max(`dd3`.`parametro_34`) AS `parametro_34`,max(`dd3`.`parametro_35`) AS `parametro_35`,max(`dd3`.`parametro_36`) AS `parametro_36`,max(`dd3`.`parametro_37`) AS `parametro_37`,max(`dd3`.`parametro_38`) AS `parametro_38`,max(`dd3`.`parametro_39`) AS `parametro_39`,max(`dd3`.`parametro_40`) AS `parametro_40`,max(`dd3`.`categoria_1`) AS `categoria_1`,max(`dd3`.`categoria_1_ui`) AS `categoria_1_ui`,max(`dd3`.`categoria_1_peso`) AS `categoria_1_peso`,max(`dd3`.`categoria_2`) AS `categoria_2`,max(`dd3`.`categoria_2_ui`) AS `categoria_2_ui`,max(`dd3`.`categoria_2_peso`) AS `categoria_2_peso`,max(`dd3`.`categoria_3`) AS `categoria_3`,max(`dd3`.`categoria_3_ui`) AS `categoria_3_ui`,max(`dd3`.`categoria_3_peso`) AS `categoria_3_peso`,max(`dd3`.`categoria_4`) AS `categoria_4`,max(`dd3`.`categoria_4_ui`) AS `categoria_4_ui`,max(`dd3`.`categoria_4_peso`) AS `categoria_4_peso`,max(`dd3`.`categoria_5`) AS `categoria_5`,max(`dd3`.`categoria_5_ui`) AS `categoria_5_ui`,max(`dd3`.`categoria_5_peso`) AS `categoria_5_peso`,max(`dd3`.`categoria_6`) AS `categoria_6`,max(`dd3`.`categoria_6_ui`) AS `categoria_6_ui`,max(`dd3`.`categoria_6_peso`) AS `categoria_6_peso`,max(`dd3`.`total_enviado_gestor_residuos`) AS `total_enviado_gestor_residuos`,max(`dd3`.`embalajes_y_etiquetas`) AS `embalajes_y_etiquetas`,max(`dd3`.`equipos_procesados`) AS `equipos_procesados` 
  from 
    `demostrativo_acumulativo` `dd3` 
  group by 
    `dd3`.`demostrativo_id`);

#
# Definition for the `vw_salida_demostrativo_1` view : 
#

CREATE  VIEW `vw_salida_demostrativo_1`
AS
select 
    `d`.`id` AS `id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    (`d`.`categoria_1` * -(1)) AS `categoria_1`,
    (`d`.`categoria_1_ui` * -(1)) AS `categoria_1_ui`,
    (`d`.`categoria_1_peso` * -(1)) AS `categoria_1_peso`,
    (`d`.`categoria_2` * -(1)) AS `categoria_2`,
    (`d`.`categoria_2_ui` * -(1)) AS `categoria_2_ui`,
    (`d`.`categoria_2_peso` * -(1)) AS `categoria_2_peso`,
    (`d`.`categoria_3` * -(1)) AS `categoria_3`,
    (`d`.`categoria_3_ui` * -(1)) AS `categoria_3_ui`,
    (`d`.`categoria_3_peso` * -(1)) AS `categoria_3_peso`,
    (`d`.`categoria_4` * -(1)) AS `categoria_4`,
    (`d`.`categoria_4_ui` * -(1)) AS `categoria_4_ui`,
    (`d`.`categoria_4_peso` * -(1)) AS `categoria_4_peso`,
    (`d`.`categoria_5` * -(1)) AS `categoria_5`,
    (`d`.`categoria_5_ui` * -(1)) AS `categoria_5_ui`,
    (`d`.`categoria_5_peso` * -(1)) AS `categoria_5_peso`,
    (`d`.`categoria_6` * -(1)) AS `categoria_6`,
    (`d`.`categoria_6_ui` * -(1)) AS `categoria_6_ui`,
    (`d`.`categoria_6_peso` * -(1)) AS `categoria_6_peso`,
    `members`.`username` AS `h_gestor_name`,
    `members`.`email` AS `h_gestor_email`,
    concat('DEMOSTRATIVO ',`d`.`demostrativo_id`) AS `h_nombre_demostrativo` 
  from 
    (`demostrativo_diario` `d` join `members` on((`members`.`id` = `d`.`user_id`))) 
  where 
    (`d`.`demostrativo_id` = 1) 
  order by 
    `d`.`date` desc;

#
# Definition for the `vw_salida_demostrativo_2` view : 
#

CREATE  VIEW `vw_salida_demostrativo_2`
AS
select 
    `d`.`id` AS `id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    (`d`.`categoria_1` * -(1)) AS `categoria_1`,
    (`d`.`categoria_1_ui` * -(1)) AS `categoria_1_ui`,
    (`d`.`categoria_1_peso` * -(1)) AS `categoria_1_peso`,
    (`d`.`categoria_2` * -(1)) AS `categoria_2`,
    (`d`.`categoria_2_ui` * -(1)) AS `categoria_2_ui`,
    (`d`.`categoria_2_peso` * -(1)) AS `categoria_2_peso`,
    (`d`.`categoria_3` * -(1)) AS `categoria_3`,
    (`d`.`categoria_3_ui` * -(1)) AS `categoria_3_ui`,
    (`d`.`categoria_3_peso` * -(1)) AS `categoria_3_peso`,
    (`d`.`categoria_4` * -(1)) AS `categoria_4`,
    (`d`.`categoria_4_ui` * -(1)) AS `categoria_4_ui`,
    (`d`.`categoria_4_peso` * -(1)) AS `categoria_4_peso`,
    (`d`.`categoria_5` * -(1)) AS `categoria_5`,
    (`d`.`categoria_5_ui` * -(1)) AS `categoria_5_ui`,
    (`d`.`categoria_5_peso` * -(1)) AS `categoria_5_peso`,
    (`d`.`categoria_6` * -(1)) AS `categoria_6`,
    (`d`.`categoria_6_ui` * -(1)) AS `categoria_6_ui`,
    (`d`.`categoria_6_peso` * -(1)) AS `categoria_6_peso`,
    `members`.`username` AS `h_gestor_name`,
    `members`.`email` AS `h_gestor_email`,
    concat('DEMOSTRATIVO ',`d`.`demostrativo_id`) AS `h_nombre_demostrativo` 
  from 
    (`demostrativo_diario` `d` join `members` on((`members`.`id` = `d`.`user_id`))) 
  where 
    (`d`.`demostrativo_id` = 2) 
  order by 
    `d`.`date` desc;

#
# Definition for the `vw_salida_demostrativo_3` view : 
#

CREATE  VIEW `vw_salida_demostrativo_3`
AS
select 
    `d`.`id` AS `id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    (`d`.`categoria_1` * -(1)) AS `categoria_1`,
    (`d`.`categoria_1_ui` * -(1)) AS `categoria_1_ui`,
    (`d`.`categoria_1_peso` * -(1)) AS `categoria_1_peso`,
    (`d`.`categoria_2` * -(1)) AS `categoria_2`,
    (`d`.`categoria_2_ui` * -(1)) AS `categoria_2_ui`,
    (`d`.`categoria_2_peso` * -(1)) AS `categoria_2_peso`,
    (`d`.`categoria_3` * -(1)) AS `categoria_3`,
    (`d`.`categoria_3_ui` * -(1)) AS `categoria_3_ui`,
    (`d`.`categoria_3_peso` * -(1)) AS `categoria_3_peso`,
    (`d`.`categoria_4` * -(1)) AS `categoria_4`,
    (`d`.`categoria_4_ui` * -(1)) AS `categoria_4_ui`,
    (`d`.`categoria_4_peso` * -(1)) AS `categoria_4_peso`,
    (`d`.`categoria_5` * -(1)) AS `categoria_5`,
    (`d`.`categoria_5_ui` * -(1)) AS `categoria_5_ui`,
    (`d`.`categoria_5_peso` * -(1)) AS `categoria_5_peso`,
    (`d`.`categoria_6` * -(1)) AS `categoria_6`,
    (`d`.`categoria_6_ui` * -(1)) AS `categoria_6_ui`,
    (`d`.`categoria_6_peso` * -(1)) AS `categoria_6_peso`,
    `members`.`username` AS `h_gestor_name`,
    `members`.`email` AS `h_gestor_email`,
    concat('DEMOSTRATIVO ',`d`.`demostrativo_id`) AS `h_nombre_demostrativo` 
  from 
    (`demostrativo_diario` `d` join `members` on((`members`.`id` = `d`.`user_id`))) 
  where 
    (`d`.`demostrativo_id` = 3) 
  order by 
    `d`.`date` desc;

#
# Definition for the `vw_salida_demostrativo_4` view : 
#

CREATE  VIEW `vw_salida_demostrativo_4`
AS
select 
    `d`.`id` AS `id`,
    `d`.`date` AS `date`,
    `d`.`equipos_procesados` AS `equipos_procesados`,
    `d`.`parametro_2` AS `parametro_2`,
    `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
    `d`.`parametro_3` AS `parametro_3`,
    `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
    `d`.`parametro_11` AS `parametro_11`,
    `d`.`parametro_12` AS `parametro_12`,
    `d`.`parametro_13` AS `parametro_13`,
    `d`.`parametro_14` AS `parametro_14`,
    `d`.`parametro_15` AS `parametro_15`,
    `d`.`parametro_16` AS `parametro_16`,
    `d`.`parametro_17` AS `parametro_17`,
    `d`.`parametro_18` AS `parametro_18`,
    `d`.`parametro_19` AS `parametro_19`,
    `d`.`parametro_20` AS `parametro_20`,
    `d`.`parametro_21` AS `parametro_21`,
    `d`.`parametro_22` AS `parametro_22`,
    `d`.`parametro_23` AS `parametro_23`,
    `d`.`parametro_24` AS `parametro_24`,
    `d`.`parametro_25` AS `parametro_25`,
    (`d`.`categoria_1` * -(1)) AS `categoria_1`,
    (`d`.`categoria_1_ui` * -(1)) AS `categoria_1_ui`,
    (`d`.`categoria_1_peso` * -(1)) AS `categoria_1_peso`,
    (`d`.`categoria_2` * -(1)) AS `categoria_2`,
    (`d`.`categoria_2_ui` * -(1)) AS `categoria_2_ui`,
    (`d`.`categoria_2_peso` * -(1)) AS `categoria_2_peso`,
    (`d`.`categoria_3` * -(1)) AS `categoria_3`,
    (`d`.`categoria_3_ui` * -(1)) AS `categoria_3_ui`,
    (`d`.`categoria_3_peso` * -(1)) AS `categoria_3_peso`,
    (`d`.`categoria_4` * -(1)) AS `categoria_4`,
    (`d`.`categoria_4_ui` * -(1)) AS `categoria_4_ui`,
    (`d`.`categoria_4_peso` * -(1)) AS `categoria_4_peso`,
    (`d`.`categoria_5` * -(1)) AS `categoria_5`,
    (`d`.`categoria_5_ui` * -(1)) AS `categoria_5_ui`,
    (`d`.`categoria_5_peso` * -(1)) AS `categoria_5_peso`,
    (`d`.`categoria_6` * -(1)) AS `categoria_6`,
    (`d`.`categoria_6_ui` * -(1)) AS `categoria_6_ui`,
    (`d`.`categoria_6_peso` * -(1)) AS `categoria_6_peso`,
    `members`.`username` AS `h_gestor_name`,
    `members`.`email` AS `h_gestor_email`,
    concat('DEMOSTRATIVO ',`d`.`demostrativo_id`) AS `h_nombre_demostrativo` 
  from 
    (`demostrativo_diario` `d` join `members` on((`members`.`id` = `d`.`user_id`))) 
  where 
    (`d`.`demostrativo_id` = 4) 
  order by 
    `d`.`date` desc;

#
# Definition for the `vw_suma_demostrativo_diario` view : 
#

CREATE  VIEW `vw_suma_demostrativo_diario`
AS
(
  select 
    `d`.`id` AS `demostrativo_id`,
    min(`dd3`.`date`) AS `fecha_desde`,
    max(`dd3`.`date`) AS `fecha_hasta`,
    ((
  select 
    (to_days(max(`dd3`.`date`)) - to_days(min(`dd3`.`date`)))) + 1) AS `dias_transcurridos`,
    (
  select 
    count(0) 
  from 
    `demostrativo_diario` `dcount` 
  where 
    (`dcount`.`demostrativo_id` = `d`.`id`)) AS `dias_registrados`,sum(`dd3`.`parametro_1`) AS `parametro_1`,sum(`dd3`.`parametro_2`) AS `parametro_2`,sum(`dd3`.`parametro_3`) AS `parametro_3`,sum(`dd3`.`parametro_4`) AS `parametro_4`,sum(`dd3`.`parametro_5`) AS `parametro_5`,sum(`dd3`.`parametro_6`) AS `parametro_6`,sum(`dd3`.`parametro_7`) AS `parametro_7`,sum(`dd3`.`parametro_8`) AS `parametro_8`,sum(`dd3`.`parametro_9`) AS `parametro_9`,sum(`dd3`.`parametro_10`) AS `parametro_10`,sum(`dd3`.`parametro_11`) AS `parametro_11`,sum(`dd3`.`parametro_12`) AS `parametro_12`,sum(`dd3`.`parametro_13`) AS `parametro_13`,sum(`dd3`.`parametro_14`) AS `parametro_14`,sum(`dd3`.`parametro_15`) AS `parametro_15`,sum(`dd3`.`parametro_16`) AS `parametro_16`,sum(`dd3`.`parametro_17`) AS `parametro_17`,sum(`dd3`.`parametro_18`) AS `parametro_18`,sum(`dd3`.`parametro_19`) AS `parametro_19`,sum(`dd3`.`parametro_20`) AS `parametro_20`,sum(`dd3`.`parametro_21`) AS `parametro_21`,sum(`dd3`.`parametro_22`) AS `parametro_22`,sum(`dd3`.`parametro_23`) AS `parametro_23`,sum(`dd3`.`parametro_24`) AS `parametro_24`,sum(`dd3`.`parametro_25`) AS `parametro_25`,sum(`dd3`.`parametro_26`) AS `parametro_26`,sum(`dd3`.`parametro_27`) AS `parametro_27`,sum(`dd3`.`parametro_28`) AS `parametro_28`,sum(`dd3`.`parametro_29`) AS `parametro_29`,sum(`dd3`.`parametro_30`) AS `parametro_30`,sum(`dd3`.`parametro_31`) AS `parametro_31`,sum(`dd3`.`parametro_32`) AS `parametro_32`,sum(`dd3`.`parametro_33`) AS `parametro_33`,sum(`dd3`.`parametro_34`) AS `parametro_34`,sum(`dd3`.`parametro_35`) AS `parametro_35`,sum(`dd3`.`parametro_36`) AS `parametro_36`,sum(`dd3`.`parametro_37`) AS `parametro_37`,sum(`dd3`.`parametro_38`) AS `parametro_38`,sum(`dd3`.`parametro_39`) AS `parametro_39`,sum(`dd3`.`parametro_40`) AS `parametro_40`,sum(`dd3`.`categoria_1`) AS `categoria_1`,sum(`dd3`.`categoria_1_ui`) AS `categoria_1_ui`,sum(`dd3`.`categoria_1_peso`) AS `categoria_1_peso`,sum(`dd3`.`categoria_2`) AS `categoria_2`,sum(`dd3`.`categoria_2_ui`) AS `categoria_2_ui`,sum(`dd3`.`categoria_2_peso`) AS `categoria_2_peso`,sum(`dd3`.`categoria_3`) AS `categoria_3`,sum(`dd3`.`categoria_3_ui`) AS `categoria_3_ui`,sum(`dd3`.`categoria_3_peso`) AS `categoria_3_peso`,sum(`dd3`.`categoria_4`) AS `categoria_4`,sum(`dd3`.`categoria_4_ui`) AS `categoria_4_ui`,sum(`dd3`.`categoria_4_peso`) AS `categoria_4_peso`,sum(`dd3`.`categoria_5`) AS `categoria_5`,sum(`dd3`.`categoria_5_ui`) AS `categoria_5_ui`,sum(`dd3`.`categoria_5_peso`) AS `categoria_5_peso`,sum(`dd3`.`categoria_6`) AS `categoria_6`,sum(`dd3`.`categoria_6_ui`) AS `categoria_6_ui`,sum(`dd3`.`categoria_6_peso`) AS `categoria_6_peso`,sum(`dd3`.`total_enviado_gestor_residuos`) AS `total_enviado_gestor_residuos`,sum(`dd3`.`embalajes_y_etiquetas`) AS `embalajes_y_etiquetas`,sum(`dd3`.`equipos_procesados`) AS `equipos_procesados` 
  from 
    (`demostrativo` `d` join `demostrativo_diario` `dd3` on((`d`.`id` = `dd3`.`demostrativo_id`))) 
  group by 
    `d`.`id`);

#
# Data for the `demostrativo` table  (LIMIT -495,500)
#

INSERT INTO `demostrativo` (`id`, `name`, `description`, `is_enabled`, `is_loading`) VALUES

  (1,'Sistema de control de aire acondicionado e iluminación','Uso de componentes de un PC genérico de oficina como unidad central en la adquisición de datos y control de mecanismos en un sistema distribuido.',1,0),
  (2,'Cluster de ordenadores para procesamiento en grid','Diseño y construcción de equipamiento estándar para computación distribuida a partir de componentes de un PC de propósito genérico.',1,0),
  (3,'Dispositivos de seguridad perimetral para intranet','Creación de sistemas de seguridad perimetral para la protección de la intranet de una organización. ',1,0),
  (4,'Ordenadores de propósito genérico','Tratamiento de equipos ofimáticos con el objetivo de generar nuevos puestos informáticos completos.',1,0);
COMMIT;



INSERT INTO `members_role` (`id`, `name`, `code`) VALUES
  (1,'user','USER'),
  (2,'administrator','ADMIN');
COMMIT;


INSERT INTO `members` (`id`, `username`, `email`, `password`, `salt`, `members_role_id`, `demostrativo_id`) VALUES
  (1,'Carlos Gutierrez','carlos.gutierrez@energylab.es','92015c34c5780dab099928c8d9e28a5cbe0d56a01108306588c5bd6e3c2ca45768ab0a47b0f12d61b85499115d17de9e2a51120d84a0c79cb0507dae1fb29ab8','8ab206858fc165c083ec036afb4011b45bdb289851d0922d0b82ae36fab1a5d88f3e0467f8764c35ae8cbaa476d69eece9a1acbe0fcc7253bd0dea5003fdd66b',2,4),
  (13,'Gestor demostrativo 1','demo1@example.com','ac8a1e53d1afdbcf6fad62ce9322946e21d01e160a60fbcb7568798b8c42fc06a552c3afc81843d91aff94b2efca2a8f20c85c1bd196c95a8c7f58622cc1583e','a0d3d225d88d4c45d9acd982a0a6af761ad87865bd170f0937ed65439c2a0326c222995e3943d5248cab0063a7801c037c0a1544db6b5c828a6caa32458eac36',1,1),
  (14,'Gestor demostrativo 2','demo2@example.com','7e4608c4e67a19797a640a68ccdb5135764c4128d2fd6f85045a34ff69d6bd58c596274eddc5f4a232a64021f088bb2e3d4af1c67dbda64e3363985027b9c2d7','686f5d5f9650b811fd40e6e7bcef1be2c48cad49518bc4d14d7e891e869b4f9e6e80ee3a328e3eb17fa1c5f6973f2286a35e0df307fd13475616b1eb6424e736',1,2),
  (15,'Gestor demostrativo 3','demo3@example.com','bfaed63b0056a139d0954392bf5a14b5f9b5fd130676d4a29e470e36d06a84ae835ffeaf9b0c8d5fdc6e23f558b8a46ca852b1fd96f93fda0ce640011f545f04','0a2b629337a0fd7582d8e2bbd06f4740165ccf166e3c0f8d180278c8df5e59a0e15f14a3a71f37fc7766b7e4ef4b600d53f6f3f2a135f5a03deda09e4eb40720',1,3),
  (17,'Gestor demostrativo 4','demo4@discalis.com','53a42ab4493f5fb075942791e8350d2ba73a8267b7d55e982422c35d821ff8e679f1f586a7983dfccd81946b8923e1535e2a769d6551b39b34173cbe9cc32595','8142d3733104896ed0d6414bb40cf0d1f64de3287945e39703bc070902c36a27f3518c69e614e464ec6d7c909a8631065911d47370b5e0a9dd962c4e175aad8d',1,4);
COMMIT;


DROP PROCEDURE IF EXISTS energylab_demostrativos.check_data_demostrativo_diario;
DELIMITER //
CREATE PROCEDURE energylab_demostrativos.`check_data_demostrativo_diario`(
        IN `v_demostrativo_diario_id` INTEGER
    )
BEGIN  
  DECLARE v_categoria_1 DECIMAL(25, 10);
  DECLARE v_categoria_1_ia DECIMAL(25, 10);
  DECLARE v_categoria_1_ie DECIMAL(25, 10);
  DECLARE v_categoria_1_peso DECIMAL(25, 10);
  DECLARE v_categoria_1_ui DECIMAL(25, 10);

  DECLARE v_categoria_2 DECIMAL(25, 10);
  DECLARE v_categoria_2_ia DECIMAL(25, 10);
  DECLARE v_categoria_2_ie DECIMAL(25, 10);
  DECLARE v_categoria_2_peso DECIMAL(25, 10);
  DECLARE v_categoria_2_ui DECIMAL(25, 10);

  DECLARE v_categoria_3 DECIMAL(25, 10);
  DECLARE v_categoria_3_ia DECIMAL(25, 10);
  DECLARE v_categoria_3_ie DECIMAL(25, 10);
  DECLARE v_categoria_3_peso DECIMAL(25, 10);
  DECLARE v_categoria_3_ui DECIMAL(25, 10);

  DECLARE v_categoria_4 DECIMAL(25, 10);
  DECLARE v_categoria_4_ia DECIMAL(25, 10);
  DECLARE v_categoria_4_ie DECIMAL(25, 10);
  DECLARE v_categoria_4_peso DECIMAL(25, 10);
  DECLARE v_categoria_4_ui DECIMAL(25, 10);

  DECLARE v_categoria_5 DECIMAL(25, 10);
  DECLARE v_categoria_5_ia DECIMAL(25, 10);
  DECLARE v_categoria_5_ie DECIMAL(25, 10);
  DECLARE v_categoria_5_peso DECIMAL(25, 10);
  DECLARE v_categoria_5_ui DECIMAL(25, 10);

  DECLARE v_categoria_6 DECIMAL(25, 10);
  DECLARE v_categoria_6_ia DECIMAL(25, 10);
  DECLARE v_categoria_6_ie DECIMAL(25, 10);
  DECLARE v_categoria_6_peso DECIMAL(25, 10);
  DECLARE v_categoria_6_ui DECIMAL(25, 10);
  
  
  DECLARE v_parametro_10 DECIMAL(25, 10);
  DECLARE v_parametro_11 DECIMAL(25, 10);
  DECLARE v_parametro_12 DECIMAL(25, 10);
  DECLARE v_parametro_13 DECIMAL(25, 10);
  DECLARE v_parametro_14 DECIMAL(25, 10);
  DECLARE v_parametro_15 DECIMAL(25, 10);
  DECLARE v_parametro_16 DECIMAL(25, 10);
  DECLARE v_parametro_17 DECIMAL(25, 10);
  DECLARE v_parametro_18 DECIMAL(25, 10);
  DECLARE v_parametro_19 DECIMAL(25, 10);
  DECLARE v_parametro_20 DECIMAL(25, 10);
  DECLARE v_parametro_4 DECIMAL(25, 10);
  DECLARE v_parametro_5 DECIMAL(25, 10);  

  DECLARE v_total_enviado_gestor_residuos DECIMAL(25, 10);
  DECLARE v_embalajes_y_etiquetas DECIMAL(25, 10);



  SELECT categoria_1, categoria_1_ui, categoria_1_peso, categoria_1_ia, categoria_1_ie, categoria_2, categoria_2_ui, categoria_2_peso, categoria_2_ia, categoria_2_ie, categoria_3, categoria_3_ui, categoria_3_peso, categoria_3_ia, categoria_3_ie, categoria_4, categoria_4_ui, categoria_4_peso, categoria_4_ia, categoria_4_ie, categoria_5, categoria_5_ui, categoria_5_peso, categoria_5_ia, categoria_5_ie, categoria_6, categoria_6_ui, categoria_6_peso, categoria_6_ia, categoria_6_ie, total_enviado_gestor_residuos, embalajes_y_etiquetas, parametro_4, parametro_5, parametro_10,	parametro_11,	parametro_12,	parametro_13,	parametro_14,	parametro_15,	parametro_16,	parametro_17,	parametro_18,	parametro_19,	parametro_20
  INTO v_categoria_1, v_categoria_1_ui, v_categoria_1_peso, v_categoria_1_ia, v_categoria_1_ie, v_categoria_2, v_categoria_2_ui, v_categoria_2_peso, v_categoria_2_ia, v_categoria_2_ie, v_categoria_3, v_categoria_3_ui, v_categoria_3_peso, v_categoria_3_ia, v_categoria_3_ie, v_categoria_4, v_categoria_4_ui, v_categoria_4_peso, v_categoria_4_ia, v_categoria_4_ie, v_categoria_5, v_categoria_5_ui, v_categoria_5_peso, v_categoria_5_ia, v_categoria_5_ie, v_categoria_6, v_categoria_6_ui, v_categoria_6_peso, v_categoria_6_ia, v_categoria_6_ie, v_total_enviado_gestor_residuos, v_embalajes_y_etiquetas, v_parametro_4, v_parametro_5, v_parametro_10, v_parametro_11, v_parametro_12, v_parametro_13, v_parametro_14, v_parametro_15, v_parametro_16, v_parametro_17, v_parametro_18, v_parametro_19, v_parametro_20
  FROM demostrativo_diario
  WHERE id = v_demostrativo_diario_id;


	IF v_categoria_1 < 0   THEN SET v_categoria_1=v_categoria_1*-1;    END IF;
  IF v_categoria_1_ia < 0   THEN SET v_categoria_1_ia=v_categoria_1_ia*-1;    END IF;
  IF v_categoria_1_ie < 0   THEN SET v_categoria_1_ie=v_categoria_1_ie*-1;    END IF;
  IF v_categoria_1_peso < 0   THEN SET v_categoria_1_peso=v_categoria_1_peso*-1;    END IF;
  IF v_categoria_1_ui < 0   THEN SET v_categoria_1_ui=v_categoria_1_ui*-1;    END IF;
  IF v_categoria_2 < 0   THEN SET v_categoria_2=v_categoria_2*-1;    END IF;
  IF v_categoria_2_ia < 0   THEN SET v_categoria_2_ia=v_categoria_2_ia*-1;    END IF;
  IF v_categoria_2_ie < 0   THEN SET v_categoria_2_ie=v_categoria_2_ie*-1;    END IF;
  IF v_categoria_2_peso < 0   THEN SET v_categoria_2_peso=v_categoria_2_peso*-1;    END IF;
  IF v_categoria_2_ui < 0   THEN SET v_categoria_2_ui=v_categoria_2_ui*-1;    END IF;
  IF v_categoria_3 < 0   THEN SET v_categoria_3=v_categoria_3*-1;    END IF;
  IF v_categoria_3_ia < 0   THEN SET v_categoria_3_ia=v_categoria_3_ia*-1;    END IF;
  IF v_categoria_3_ie < 0   THEN SET v_categoria_3_ie=v_categoria_3_ie*-1;    END IF;
  IF v_categoria_3_peso < 0   THEN SET v_categoria_3_peso=v_categoria_3_peso*-1;    END IF;
  IF v_categoria_3_ui < 0   THEN SET v_categoria_3_ui=v_categoria_3_ui*-1;    END IF;
  IF v_categoria_4 < 0   THEN SET v_categoria_4=v_categoria_4*-1;    END IF;
  IF v_categoria_4_ia < 0   THEN SET v_categoria_4_ia=v_categoria_4_ia*-1;    END IF;
  IF v_categoria_4_ie < 0   THEN SET v_categoria_4_ie=v_categoria_4_ie*-1;    END IF;
  IF v_categoria_4_peso < 0   THEN SET v_categoria_4_peso=v_categoria_4_peso*-1;    END IF;
  IF v_categoria_4_ui < 0   THEN SET v_categoria_4_ui=v_categoria_4_ui*-1;    END IF;
  IF v_categoria_5 < 0   THEN SET v_categoria_5=v_categoria_5*-1;    END IF;
  IF v_categoria_5_ia < 0   THEN SET v_categoria_5_ia=v_categoria_5_ia*-1;    END IF;
  IF v_categoria_5_ie < 0   THEN SET v_categoria_5_ie=v_categoria_5_ie*-1;    END IF;
  IF v_categoria_5_peso < 0   THEN SET v_categoria_5_peso=v_categoria_5_peso*-1;    END IF;
  IF v_categoria_5_ui < 0   THEN SET v_categoria_5_ui=v_categoria_5_ui*-1;    END IF;
  IF v_categoria_6 < 0   THEN SET v_categoria_6=v_categoria_6*-1;    END IF;
  IF v_categoria_6_ia < 0   THEN SET v_categoria_6_ia=v_categoria_6_ia*-1;    END IF;
  IF v_categoria_6_ie < 0   THEN SET v_categoria_6_ie=v_categoria_6_ie*-1;    END IF;
  IF v_categoria_6_peso < 0   THEN SET v_categoria_6_peso=v_categoria_6_peso*-1;    END IF;
  IF v_categoria_6_ui < 0   THEN SET v_categoria_6_ui=v_categoria_6_ui*-1;    END IF;

  
  SET v_categoria_1_ui = v_categoria_1/5.77*100;
  SET v_categoria_1_peso = v_categoria_1*26.7/122;
  SET v_categoria_2_ui = v_categoria_2/2.82*100;
  SET v_categoria_2_peso = v_categoria_2*18.8/1210;
  SET v_categoria_3_ui = v_categoria_3/16.4*100;
  SET v_categoria_3_peso = v_categoria_3*( (13.9000000/448) + (1.65000000/448) );
  SET v_categoria_4_ui = v_categoria_4/0.0189*100;
  SET v_categoria_4_peso = v_categoria_4*4.92/0.851;
  SET v_categoria_5_ui = v_categoria_5/1.05*100;
  SET v_categoria_5_peso = v_categoria_5*0.278/286;
  SET v_categoria_6_ui = v_categoria_6/3.66*100;
  SET v_categoria_6_peso = v_categoria_6*0.0669/183;
  
  SET v_total_enviado_gestor_residuos =  v_parametro_10 + v_parametro_11 + v_parametro_12 + v_parametro_13 + v_parametro_14 + v_parametro_15 + v_parametro_16 + v_parametro_17 + v_parametro_18 + v_parametro_19 + v_parametro_20;
  SET v_embalajes_y_etiquetas = v_parametro_4 + v_parametro_5;
  
  
  UPDATE demostrativo_diario SET 
    categoria_1 = v_categoria_1,
    categoria_1_ui  = v_categoria_1_ui ,
    categoria_1_peso  = v_categoria_1_peso ,
    categoria_1_ia  = v_categoria_1_ia ,
    categoria_1_ie  = v_categoria_1_ie ,
    categoria_2  = v_categoria_2 ,
    categoria_2_ui  = v_categoria_2_ui ,
    categoria_2_peso = v_categoria_2_peso,
    categoria_2_ia  = v_categoria_2_ia ,
    categoria_2_ie  = v_categoria_2_ie ,
    categoria_3  = v_categoria_3 ,
    categoria_3_ui  = v_categoria_3_ui ,
    categoria_3_peso  = v_categoria_3_peso ,
    categoria_3_ia  = v_categoria_3_ia ,
    categoria_3_ie  = v_categoria_3_ie ,
    categoria_4  = v_categoria_4 ,
    categoria_4_ui  = v_categoria_4_ui ,
    categoria_4_peso  = v_categoria_4_peso ,
    categoria_4_ia  = v_categoria_4_ia ,
    categoria_4_ie  = v_categoria_4_ie ,
    categoria_5  = v_categoria_5 ,
    categoria_5_ui  = v_categoria_5_ui ,
    categoria_5_peso  = v_categoria_5_peso ,
    categoria_5_ia  = v_categoria_5_ia ,
    categoria_5_ie  = v_categoria_5_ie ,
    categoria_6  = v_categoria_6 ,
    categoria_6_ui  = v_categoria_6_ui ,
    categoria_6_peso  = v_categoria_6_peso ,
    categoria_6_ia  = v_categoria_6_ia ,
    categoria_6_ie  = v_categoria_6_ie ,
    total_enviado_gestor_residuos  = v_total_enviado_gestor_residuos ,
    embalajes_y_etiquetas  = v_embalajes_y_etiquetas
    WHERE id = v_demostrativo_diario_id;    
    
    CALL set_dacumulativo_fecha(v_demostrativo_diario_id );
END//
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


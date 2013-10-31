<?php
require_once '../conf/configuration.php';
$sTable = $_REQUEST['table'];

$sWhereRaw .= " `d`.`date` BETWEEN '".to_mysql_date($_REQUEST['dtFrom'])."' AND '".to_mysql_date($_REQUEST['dtTo'])."' ";			

$query = "SELECT `d`.`demostrativo_id` AS `demostrativo_id`,
       `d`.`date` AS `date`,
       `d`.`id` AS `id`,
       `d`.`equipos_procesados` AS `equipos_procesados`,
       (SELECT sum(`x`.`equipos_procesados`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `equipos_procesados_suma`,
       `da`.`equipos_procesados` AS `equipos_procesados_acumulado`,
       (SELECT (`equipos_procesados_suma` = `equipos_procesados_acumulado`))
          AS `equipos_procesados_ok`,
       `d`.`parametro_1` AS `parametro_1`,
       (SELECT sum(`x`.`parametro_1`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_1_suma`,
       `da`.`parametro_1` AS `parametro_1_acumulado`,
       (SELECT (`parametro_1_suma` = `parametro_1_acumulado`))
          AS `parametro_1_ok`,
       `d`.`parametro_2` AS `parametro_2`,
       (SELECT sum(`x`.`parametro_2`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_2_suma`,
       `da`.`parametro_2` AS `parametro_2_acumulado`,
       (SELECT (`parametro_2_suma` = `parametro_2_acumulado`))
          AS `parametro_2_ok`,
       `d`.`parametro_3` AS `parametro_3`,
       (SELECT sum(`x`.`parametro_3`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_3_suma`,
       `da`.`parametro_3` AS `parametro_3_acumulado`,
       (SELECT (`parametro_3_suma` = `parametro_3_acumulado`))
          AS `parametro_3_ok`,
       `d`.`parametro_4` AS `parametro_4`,
       (SELECT sum(`x`.`parametro_4`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_4_suma`,
       `da`.`parametro_4` AS `parametro_4_acumulado`,
       (SELECT (`parametro_4_suma` = `parametro_4_acumulado`))
          AS `parametro_4_ok`,
       `d`.`parametro_5` AS `parametro_5`,
       (SELECT sum(`x`.`parametro_5`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_5_suma`,
       `da`.`parametro_5` AS `parametro_5_acumulado`,
       (SELECT (`parametro_5_suma` = `parametro_5_acumulado`))
          AS `parametro_5_ok`,
       `d`.`parametro_6` AS `parametro_6`,
       (SELECT sum(`x`.`parametro_6`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_6_suma`,
       `da`.`parametro_6` AS `parametro_6_acumulado`,
       (SELECT (`parametro_6_suma` = `parametro_6_acumulado`))
          AS `parametro_6_ok`,
       `d`.`parametro_7` AS `parametro_7`,
       (SELECT sum(`x`.`parametro_7`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_7_suma`,
       `da`.`parametro_7` AS `parametro_7_acumulado`,
       (SELECT (`parametro_7_suma` = `parametro_7_acumulado`))
          AS `parametro_7_ok`,
       `d`.`parametro_8` AS `parametro_8`,
       (SELECT sum(`x`.`parametro_8`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_8_suma`,
       `da`.`parametro_8` AS `parametro_8_acumulado`,
       (SELECT (`parametro_8_suma` = `parametro_8_acumulado`))
          AS `parametro_8_ok`,
       `d`.`parametro_9` AS `parametro_9`,
       (SELECT sum(`x`.`parametro_9`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_9_suma`,
       `da`.`parametro_9` AS `parametro_9_acumulado`,
       (SELECT (`parametro_9_suma` = `parametro_9_acumulado`))
          AS `parametro_9_ok`,
       `d`.`parametro_10` AS `parametro_10`,
       (SELECT sum(`x`.`parametro_10`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_10_suma`,
       `da`.`parametro_10` AS `parametro_10_acumulado`,
       (SELECT (`parametro_10_suma` = `parametro_10_acumulado`))
          AS `parametro_10_ok`,
       `d`.`parametro_11` AS `parametro_11`,
       (SELECT sum(`x`.`parametro_11`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_11_suma`,
       `da`.`parametro_11` AS `parametro_11_acumulado`,
       (SELECT (`parametro_11_suma` = `parametro_11_acumulado`))
          AS `parametro_11_ok`,
       `d`.`parametro_12` AS `parametro_12`,
       (SELECT sum(`x`.`parametro_12`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_12_suma`,
       `da`.`parametro_12` AS `parametro_12_acumulado`,
       (SELECT (`parametro_12_suma` = `parametro_12_acumulado`))
          AS `parametro_12_ok`,
       `d`.`parametro_13` AS `parametro_13`,
       (SELECT sum(`x`.`parametro_13`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_13_suma`,
       `da`.`parametro_13` AS `parametro_13_acumulado`,
       (SELECT (`parametro_13_suma` = `parametro_13_acumulado`))
          AS `parametro_13_ok`,
       `d`.`parametro_14` AS `parametro_14`,
       (SELECT sum(`x`.`parametro_14`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_14_suma`,
       `da`.`parametro_14` AS `parametro_14_acumulado`,
       (SELECT (`parametro_14_suma` = `parametro_14_acumulado`))
          AS `parametro_14_ok`,
       `d`.`parametro_15` AS `parametro_15`,
       (SELECT sum(`x`.`parametro_15`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_15_suma`,
       `da`.`parametro_15` AS `parametro_15_acumulado`,
       (SELECT (`parametro_15_suma` = `parametro_15_acumulado`))
          AS `parametro_15_ok`,
       `d`.`parametro_16` AS `parametro_16`,
       (SELECT sum(`x`.`parametro_16`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_16_suma`,
       `da`.`parametro_16` AS `parametro_16_acumulado`,
       (SELECT (`parametro_16_suma` = `parametro_16_acumulado`))
          AS `parametro_16_ok`,
       `d`.`parametro_17` AS `parametro_17`,
       (SELECT sum(`x`.`parametro_17`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_17_suma`,
       `da`.`parametro_17` AS `parametro_17_acumulado`,
       (SELECT (`parametro_17_suma` = `parametro_17_acumulado`))
          AS `parametro_17_ok`,
       `d`.`parametro_18` AS `parametro_18`,
       (SELECT sum(`x`.`parametro_18`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_18_suma`,
       `da`.`parametro_18` AS `parametro_18_acumulado`,
       (SELECT (`parametro_18_suma` = `parametro_18_acumulado`))
          AS `parametro_18_ok`,
       `d`.`parametro_19` AS `parametro_19`,
       (SELECT sum(`x`.`parametro_19`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_19_suma`,
       `da`.`parametro_19` AS `parametro_19_acumulado`,
       (SELECT (`parametro_19_suma` = `parametro_19_acumulado`))
          AS `parametro_19_ok`,
       `d`.`parametro_20` AS `parametro_20`,
       (SELECT sum(`x`.`parametro_20`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_20_suma`,
       `da`.`parametro_20` AS `parametro_20_acumulado`,
       (SELECT (`parametro_20_suma` = `parametro_20_acumulado`))
          AS `parametro_20_ok`,
       `d`.`parametro_21` AS `parametro_21`,
       (SELECT sum(`x`.`parametro_21`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_21_suma`,
       `da`.`parametro_21` AS `parametro_21_acumulado`,
       (SELECT (`parametro_21_suma` = `parametro_21_acumulado`))
          AS `parametro_21_ok`,
       `d`.`parametro_22` AS `parametro_22`,
       (SELECT sum(`x`.`parametro_22`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_22_suma`,
       `da`.`parametro_22` AS `parametro_22_acumulado`,
       (SELECT (`parametro_22_suma` = `parametro_22_acumulado`))
          AS `parametro_22_ok`,
       `d`.`parametro_23` AS `parametro_23`,
       (SELECT sum(`x`.`parametro_23`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_23_suma`,
       `da`.`parametro_23` AS `parametro_23_acumulado`,
       (SELECT (`parametro_23_suma` = `parametro_23_acumulado`))
          AS `parametro_23_ok`,
       `d`.`parametro_24` AS `parametro_24`,
       (SELECT sum(`x`.`parametro_24`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_24_suma`,
       `da`.`parametro_24` AS `parametro_24_acumulado`,
       (SELECT (`parametro_24_suma` = `parametro_24_acumulado`))
          AS `parametro_24_ok`,
       `d`.`parametro_25` AS `parametro_25`,
       (SELECT sum(`x`.`parametro_25`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_25_suma`,
       `da`.`parametro_25` AS `parametro_25_acumulado`,
       (SELECT (`parametro_25_suma` = `parametro_25_acumulado`))
          AS `parametro_25_ok`,
       `d`.`parametro_26` AS `parametro_26`,
       (SELECT sum(`x`.`parametro_26`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_26_suma`,
       `da`.`parametro_26` AS `parametro_26_acumulado`,
       (SELECT (`parametro_26_suma` = `parametro_26_acumulado`))
          AS `parametro_26_ok`,
       `d`.`parametro_27` AS `parametro_27`,
       (SELECT sum(`x`.`parametro_27`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_27_suma`,
       `da`.`parametro_27` AS `parametro_27_acumulado`,
       (SELECT (`parametro_27_suma` = `parametro_27_acumulado`))
          AS `parametro_27_ok`,
       `d`.`parametro_28` AS `parametro_28`,
       (SELECT sum(`x`.`parametro_28`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_28_suma`,
       `da`.`parametro_28` AS `parametro_28_acumulado`,
       (SELECT (`parametro_28_suma` = `parametro_28_acumulado`))
          AS `parametro_28_ok`,
       `d`.`parametro_29` AS `parametro_29`,
       (SELECT sum(`x`.`parametro_29`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_29_suma`,
       `da`.`parametro_29` AS `parametro_29_acumulado`,
       (SELECT (`parametro_29_suma` = `parametro_29_acumulado`))
          AS `parametro_29_ok`,
       `d`.`parametro_30` AS `parametro_30`,
       (SELECT sum(`x`.`parametro_30`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `parametro_30_suma`,
       `da`.`parametro_30` AS `parametro_30_acumulado`,
       (SELECT (`parametro_30_suma` = `parametro_30_acumulado`))
          AS `parametro_30_ok`,
       `d`.`categoria_1` AS `categoria_1`,
       (SELECT sum(`x`.`categoria_1`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_1_suma`,
       `da`.`categoria_1` AS `categoria_1_acumulado`,
       (SELECT (`categoria_1_suma` = `categoria_1_acumulado`))
          AS `categoria_1_ok`,
       `d`.`categoria_1_ui` AS `categoria_1_ui`,
       (SELECT sum(`x`.`categoria_1_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_1_ui_suma`,
       `da`.`categoria_1_ui` AS `categoria_1_ui_acumulado`,
       (SELECT (`categoria_1_ui_suma` = `categoria_1_ui_acumulado`))
          AS `categoria_1_ui_ok`,
       `d`.`categoria_1_peso` AS `categoria_1_peso`,
       (SELECT sum(`x`.`categoria_1_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_1_peso_suma`,
       `da`.`categoria_1_peso` AS `categoria_1_peso_acumulado`,
       (SELECT (`categoria_1_peso_suma` = `categoria_1_peso_acumulado`))
          AS `categoria_1_peso_ok`,
       `d`.`categoria_2` AS `categoria_2`,
       (SELECT sum(`x`.`categoria_2`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_2_suma`,
       `da`.`categoria_2` AS `categoria_2_acumulado`,
       (SELECT (`categoria_2_suma` = `categoria_2_acumulado`))
          AS `categoria_2_ok`,
       `d`.`categoria_2_ui` AS `categoria_2_ui`,
       (SELECT sum(`x`.`categoria_2_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_2_ui_suma`,
       `da`.`categoria_2_ui` AS `categoria_2_ui_acumulado`,
       (SELECT (`categoria_2_ui_suma` = `categoria_2_ui_acumulado`))
          AS `categoria_2_ui_ok`,
       `d`.`categoria_2_peso` AS `categoria_2_peso`,
       (SELECT sum(`x`.`categoria_2_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_2_peso_suma`,
       `da`.`categoria_2_peso` AS `categoria_2_peso_acumulado`,
       (SELECT (`categoria_2_peso_suma` = `categoria_2_peso_acumulado`))
          AS `categoria_2_peso_ok`,
       `d`.`categoria_3` AS `categoria_3`,
       (SELECT sum(`x`.`categoria_3`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_3_suma`,
       `da`.`categoria_3` AS `categoria_3_acumulado`,
       (SELECT (`categoria_3_suma` = `categoria_3_acumulado`))
          AS `categoria_3_ok`,
       `d`.`categoria_3_ui` AS `categoria_3_ui`,
       (SELECT sum(`x`.`categoria_3_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_3_ui_suma`,
       `da`.`categoria_3_ui` AS `categoria_3_ui_acumulado`,
       (SELECT (`categoria_3_ui_suma` = `categoria_3_ui_acumulado`))
          AS `categoria_3_ui_ok`,
       `d`.`categoria_3_peso` AS `categoria_3_peso`,
       (SELECT sum(`x`.`categoria_3_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_3_peso_suma`,
       `da`.`categoria_3_peso` AS `categoria_3_peso_acumulado`,
       (SELECT (`categoria_3_peso_suma` = `categoria_3_peso_acumulado`))
          AS `categoria_3_peso_ok`,
       `d`.`categoria_4` AS `categoria_4`,
       (SELECT sum(`x`.`categoria_4`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_4_suma`,
       `da`.`categoria_4` AS `categoria_4_acumulado`,
       (SELECT (`categoria_4_suma` = `categoria_4_acumulado`))
          AS `categoria_4_ok`,
       `d`.`categoria_4_ui` AS `categoria_4_ui`,
       (SELECT sum(`x`.`categoria_4_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_4_ui_suma`,
       `da`.`categoria_4_ui` AS `categoria_4_ui_acumulado`,
       (SELECT (`categoria_4_ui_suma` = `categoria_4_ui_acumulado`))
          AS `categoria_4_ui_ok`,
       `d`.`categoria_4_peso` AS `categoria_4_peso`,
       (SELECT sum(`x`.`categoria_4_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_4_peso_suma`,
       `da`.`categoria_4_peso` AS `categoria_4_peso_acumulado`,
       (SELECT (`categoria_4_peso_suma` = `categoria_4_peso_acumulado`))
          AS `categoria_4_peso_ok`,
       `d`.`categoria_5` AS `categoria_5`,
       (SELECT sum(`x`.`categoria_5`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_5_suma`,
       `da`.`categoria_5` AS `categoria_5_acumulado`,
       (SELECT (`categoria_5_suma` = `categoria_5_acumulado`))
          AS `categoria_5_ok`,
       `d`.`categoria_5_ui` AS `categoria_5_ui`,
       (SELECT sum(`x`.`categoria_5_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_5_ui_suma`,
       `da`.`categoria_5_ui` AS `categoria_5_ui_acumulado`,
       (SELECT (`categoria_5_ui_suma` = `categoria_5_ui_acumulado`))
          AS `categoria_5_ui_ok`,
       `d`.`categoria_5_peso` AS `categoria_5_peso`,
       (SELECT sum(`x`.`categoria_5_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_5_peso_suma`,
       `da`.`categoria_5_peso` AS `categoria_5_peso_acumulado`,
       (SELECT (`categoria_5_peso_suma` = `categoria_5_peso_acumulado`))
          AS `categoria_5_peso_ok`,
       `d`.`categoria_6` AS `categoria_6`,
       (SELECT sum(`x`.`categoria_6`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_6_suma`,
       `da`.`categoria_6` AS `categoria_6_acumulado`,
       (SELECT (`categoria_6_suma` = `categoria_6_acumulado`))
          AS `categoria_6_ok`,
       `d`.`categoria_6_ui` AS `categoria_6_ui`,
       (SELECT sum(`x`.`categoria_6_ui`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_6_ui_suma`,
       `da`.`categoria_6_ui` AS `categoria_6_ui_acumulado`,
       (SELECT (`categoria_6_ui_suma` = `categoria_6_ui_acumulado`))
          AS `categoria_6_ui_ok`,
       `d`.`categoria_6_peso` AS `categoria_6_peso`,
       (SELECT sum(`x`.`categoria_6_peso`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `categoria_6_peso_suma`,
       `da`.`categoria_6_peso` AS `categoria_6_peso_acumulado`,
       (SELECT (`categoria_6_peso_suma` = `categoria_6_peso_acumulado`))
          AS `categoria_6_peso_ok`,
       `d`.`total_enviado_gestor_residuos` AS `total_enviado_gestor_residuos`,
       (SELECT sum(`x`.`total_enviado_gestor_residuos`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `total_enviado_gestor_residuos_suma`,
       `da`.`total_enviado_gestor_residuos`
          AS `total_enviado_gestor_residuos_acumulado`,
       (SELECT (`total_enviado_gestor_residuos_suma` =
                   `total_enviado_gestor_residuos_acumulado`))
          AS `total_enviado_gestor_residuos_ok`,
       `d`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas`,
       (SELECT sum(`x`.`embalajes_y_etiquetas`)
          FROM `energylab_demostrativos`.`demostrativo_diario` `x`
         WHERE (    (`x`.`date` <= `d`.`date`)
                AND (`d`.`demostrativo_id` = `x`.`demostrativo_id`)))
          AS `embalajes_y_etiquetas_suma`,
       `da`.`embalajes_y_etiquetas` AS `embalajes_y_etiquetas_acumulado`,
       (SELECT (`embalajes_y_etiquetas_suma` =
                   `embalajes_y_etiquetas_acumulado`))
          AS `embalajes_y_etiquetas_ok`
  FROM (   `energylab_demostrativos`.`demostrativo_diario` `d`
        JOIN
           `energylab_demostrativos`.`demostrativo_acumulativo` `da`
        ON ((`da`.`demostrativo_diario_id` = `d`.`id`)))
 WHERE (`d`.`demostrativo_id` = 1)
 AND ".$sWhereRaw."
 ORDER BY `d`.`date` ;";
<?php 
  include_once "_header.php";
  include_once "LogicaBdd.php";    

  $aMissing[1] = LogicaBdd::get_missing_dates(1);
  $aMissing[2] = LogicaBdd::get_missing_dates(2);
  $aMissing[3] = LogicaBdd::get_missing_dates(3);
  $aMissing[4] = LogicaBdd::get_missing_dates(4);
 
 ?>
  <div class="container">

    <div class="row-fluid margin-top-xl">
      <div class="span3">
        <?php
           include_once "_lateral_demostrativo.php";
        ?>
      </div>
    <div class="span9">
          <div class="span11">  
              <h3>
                Analizar resumen de datos
              </h3>
          </div>

         <div class="span11" id="dres">  
         </div>

          <div class="span11" id="resultados_exec"></div>
          <div class="span11" >

              <p>
                <h4>¿Qu&eacute; es esto?</h4> Dentro de la aplicaci&oacute;n, los gestores de cada uno de los Demostrativos subir&aacute;n una hoja de c&aacute;lculo diaria con los datos estad&iacute;sticos de su demostrativo.</br></br>
                Por cada uno de los documentos subidos, en la base de datos de la aplicaci&oacute;n se guardar&aacute;:
                <ul>
                  <li> un <strong>registro diario</strong> con los datos de cada par&aacute;metro del documento</li>
                  <li> un <strong>registro diario con el c&aacute;lculo del valor acumulado de cada par&aacute;metro</strong> hasta el d&iacute;a a&ntilde;adido / desde el d&iacute;a eliminado</li>
                </ul>
              </p>
              <br>
              <p>
                <h4>¿Por qu&eacute; podr&iacute;an producirse errores?</h4>
                <ul>
                  <li> <strong>Perdidas de datos por indisponibilidad del servidor:</strong> Aunque los datos diarios (&#x2211;) son fidelignos, para agilizar las consultas, los datos acumulados (<i class="icon-hdd"></i>) se calcular&aacute;n y almacenar&aacute;n en base datos cada vez que se modifican los datos de un demostrativo.
                  Aunque el c&aacute;lculo se realiza de forma autom&aacute;tica, desde este apartado se pod&aacute; volver a recalcular y guardar en base de datos todos los valores acumulados: para ello existe un bot&oacute;n al pie de la columna de cada demostrativo que realizar&aacute; este proceso.</li>
                  <li> <strong>Olvidos a la hora de introducir los registros de una fecha concreta:</strong> Desde este apartado tambi&eacute;n se podr&aacute; visualizar si existen fechas sin datos.</li>                  
                </ul>
                



              </p>
              <br>

              <span class="label label-important">Importante! hasta que termine la ejecuci&oacute;n del rec&aacute;lculo de totales los datos mostrados por la aplicaci&oacute;n no ser&aacute;n cocherentes<br> por lo que es recomendable restringir temporalmente el acceso p&uacute;blico al apartado de visualizaci&oacute;n de gr&aacute;ficas de la p&aacute;gina  web.</span>
          </div>

  </div> <!-- ./span9 -->
</div>
</div><!-- ./row-->
      <!-- FOOTER -->

</div><!-- ./container-->

<?php 
  include_once "_js_footer.php";
?>

<script>
    var aMissing = Array();
    <?php 
    parametrosDemostrativo::printArrayJs("aParametros", "ES", 1);

    foreach ($aMissing as $demo_id=>$aData){
      echo " aMissing[".$demo_id."] = Array(); 
      ";
      foreach ($aData as $k=>$v){
        echo " aMissing[".$demo_id."]['".$k."'] ='".$v."'; 
        ";
      }
    }
    ?>

    function updateAllData (id) {

      var date_from = $("#tr_fecha_desde td.suma"+id).html();
      var date_to = $("#tr_fecha_hasta td.suma"+id).html();

      alert("ATENCION: solo usuarios avanzados deberían ejecutar esta opción, y únicamente si se producen incoherencias en los datos totales acumulados. Si el rango de fechas es muy amplio la ejecución de esta opción podría tardar mucho. \nSe recalcularán todos los valores acumulados generados entre el "+date_from+ " y el "+date_to);
      if( confirm("¿Seguro que desea continuar? si es así por favor, inhabilite temporalmente el acceso púbico a la página web.") ){
        $("#resultados_exec").html('');
        
          $("#resultados_exec").html('<img src="../img/loader.gif" /><br>loading...');
          $.ajax({
            type: "DELETE",
            url: '../ajax/recalcular_acumulados.php?demostrativo_id='+id+'&date_from='+date_from,
            success: function(data){
                $('#resultados_exec').html('<div class="alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button><strong>OK: </strong>OK '+$("#ndias").val()+' días</div>');
            },
            error: function(request, settings){
                $('#resultados_exec').html('<div class="alert alert-error"><button class="close" data-dismiss="alert" type="button">×</button><strong>KO:</strong> '+request.responseText +'</div>');
            }
          });
        
      }
    }

$(document).ready(function(){
     $.ajax( "../ajax/get_tcolumns.php?table=vw_suma_demostrativo_diario")
       .done(function(data)
        {
          var parametros = jQuery.parseJSON(data);

          $("#dres").html("<table cellpadding='0' cellspacing='0' border='0' class='table table-bordered tresumen' id='tdata'></table>");
          var tcolgroup = $('<colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup><colgroup></colgroup>');
          var thh1 = $('<thead><tr><th rowspan="2">PAR&Aacute;METRO</th><th colspan="2"> DEMOSTRATIVO 1</th> <th colspan="2"> DEMOSTRATIVO 2</th><th colspan="2"> DEMOSTRATIVO 3</th> <th colspan="2"> DEMOSTRATIVO 4</th></tr>  <tr> <th title="Sumatorio de valores diarios">&#x2211;</th><th title="Valor acumulado calculado guardado en base de datos"><i class="icon-hdd"></i></th><th title="Sumatorio de valores diarios">&#x2211;</th><th title="Valor acumulado calculado guardado en base de datos"><i class="icon-hdd"></i></th><th title="Sumatorio de valores diarios">&#x2211;</th><th title="Valor acumulado calculado guardado en base de datos"><i class="icon-hdd"></i></th><th title="Sumatorio de valores diarios">&#x2211;</th><th title="Valor acumulado calculado guardado en base de datos"><i class="icon-hdd"></i></th> </tr></thead>'); 
          var thh2 = $('<tr><th></th><th colspan="2"><button class="btn btn-warning" onclick="updateAllData(1);"> Recalcular Acumulados Demostrativo 1</button></th><th colspan="2"><button class="btn btn-warning" onclick="updateAllData(2);"> Recalcular Acumulados Demostrativo 2</button></th><th colspan="2"><button class="btn btn-warning" onclick="updateAllData(3);"> Recalcular Acumulados Demostrativo 3</button></th><th colspan="2"><button class="btn btn-warning" onclick="updateAllData(4);"> Recalcular Acumulados Demostrativo 4</button></th></tr>');
          var tr = $('<tr></tr>');
          var tfoot = $('<tfoot></tfoot>');
          var trb = $('<tbody></tbody>'); 
          var field = "";

          $.each(parametros, function(index, column)
          {
              field = column['Field'];
              $('<tr id="tr_'+field+'"><th>' + (field).replace("_", " ") +'</th> <td class="suma1">-</td><td class="acum1">-</td><td class="suma2">-</td><td class="acum2">-</td><td class="suma3">-</td><td class="acum3">-</td><td class="suma4">-</td><td class="acum4">-</td></tr>').appendTo(trb);
              
          });   

          trb.prependTo('#tdata'); 

          var tr_demo = $('<tr></tr>'); 
          $.ajax( "../ajax/get_tdata.php?table=vw_suma_demostrativo_diario")
               .done(function(data)
                {
                  var parametros_diarios = jQuery.parseJSON(data);                 
                  $.each(parametros_diarios, function(index, column){
                    //aMissing[column["demostrativo_id"]]['dias_habiles']

                      if(aMissing[column["demostrativo_id"]]['dias_habiles'] != column["dias_registrados"]){
                          $("#tr_dias_registrados td.suma"+column['demostrativo_id']).addClass("dwarning");
                          column["dias_registrados"] = '<a href="#" class="apopover" data-toggle="popover" data-placement="bottom" data-content="' + (aMissing[column["demostrativo_id"]]['fechas_faltantes']).replace(",", ",  ") +'" data-original-title="No hay registro de datos de las siguientes '+aMissing[column["demostrativo_id"]]['n_fechas_faltantes']+' fechas:">'+column["dias_registrados"]+'</a>';
                      }  
                      $.each(column, function(index2, column2)
                      {
                        //$('<td id="td_diario_'+index+'_'+index2+'">'+column['demostrativo_id']+" /"+column2+'</td>').appendTo(tr_demo); 
                        if(index2 == "dias_transcurridos")
                            $("#tr_"+index2+" td.suma"+column['demostrativo_id']).html(aMissing[column["demostrativo_id"]]['dias_habiles']);
                        else 
                            $("#tr_"+index2+" td.suma"+column['demostrativo_id']).html(column2);
                      });
                  });  

                  $.ajax( "../ajax/get_tdata.php?table=vw_max_demostrativo_acumulativo")
                     .done(function(data)
                      {
                        var parametros_acumulados = jQuery.parseJSON(data);                 
                        $.each(parametros_acumulados, function(index, column){
                            if(aMissing[column["demostrativo_id"]]['dias_habiles'] != column["dias_registrados"]){
                                $("#tr_dias_registrados td.acum"+column['demostrativo_id']).addClass("dwarning");
                                column["dias_registrados"] = '<a href="#" class="apopover" data-toggle="popover" data-placement="bottom" data-content="' + (aMissing[column["demostrativo_id"]]['fechas_faltantes']).replace(",", ",  ") +'" data-original-title="No hay registro de datos de las siguientes '+aMissing[column["demostrativo_id"]]['n_fechas_faltantes']+' fechas:">'+column["dias_registrados"]+'</a>';
                            }              
                            $.each(column, function(index2, column2)
                            {
                              if(index2 == "dias_transcurridos")
                                $("#tr_"+index2+" td.acum"+column['demostrativo_id']).html(aMissing[column["demostrativo_id"]]['dias_habiles']);
                              else 
                                $("#tr_"+index2+" td.acum"+column['demostrativo_id']).html(column2);
                              if( $("#tr_"+index2+" td.acum"+column['demostrativo_id']).html() !=  $("#tr_"+index2+" td.suma"+column['demostrativo_id']).html() ){
                                $("#tr_"+index2+" td.suma"+column['demostrativo_id']).addClass("derror");
                                $("#tr_"+index2+" td.acum"+column['demostrativo_id']).addClass("derror");
                              }
                              //console.log($("#tr_"+index2+" td.suma"+column['demostrativo_id']).html() + " VS " + $("#tr_"+index2+" td.acum"+column['demostrativo_id']).html() );
                            });
                        });  
      
                     
                      ///////////////////// EFECTOS ///////////////////// 
                      $('.apopover').mouseenter(function(){
                          $(this).popover('show')
                      });
                      
                      $('.apopover').mouseleave(function(){
                          $(this).popover('hide')
                      });


                       $("table").delegate('td','mouseover mouseleave', function(e) {
                        if (e.type == 'mouseover') {
                          $(this).parent().addClass("hover");
                          $("colgroup").eq($(this).index()).addClass("hover");
                        }
                        else {
                          $(this).parent().removeClass("hover");
                          $("colgroup").eq($(this).index()).removeClass("hover");
                        }
                    });
                });   
          });      
        
          tcolgroup.prependTo('#tdata');   
          thh1.prependTo('#tdata');   
          thh2.appendTo('#tdata');   
          trb.appendTo('#tdata');  
          
    }).fail(function(){ /*alert("error");*/ }) .always(function(){/*alert("complete"); */});
});

</script>


<?php
  include_once "_footer.php";
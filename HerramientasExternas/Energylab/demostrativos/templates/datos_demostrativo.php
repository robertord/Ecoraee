<?php 
  include "_header.php";
  include_once 'Demostrativo.php';
?>

  <div class="container">
    <div class="row-fluid margin-top-xl">
        <div class="span3">
          <?php
             include "_lateral_demostrativo.php";
          ?>
        </div>

        <div class="span9">


        <?php

        if($_SESSION['rol'] == "USER")
          $demostrativo_id = $_SESSION['demostrativo_id'];
        else if ($_SESSION['rol'] == "ADMIN" and isset($_REQUEST['demo']) && in_array($_REQUEST['demo'], array("1","2","3","4")) )
          $demostrativo_id = $_REQUEST['demo'];
        else 
          $demostrativo_id = 1;

        $dataTable = "vw_salida_demostrativo_".$demostrativo_id;
        $demostrativo = $demostrativo_id;
        $lang = $_SESSION['lang'];

        $objDemostrativo = new Demostrativo($demostrativo_id);
      // TODO : forzar errores y ver como capturarlos
        $min_date = $objDemostrativo->getMinDate();
        $max_date = $objDemostrativo->getMaxDate();

        $aDemostrativos = energylabDemostrativo::getArray();
        try{
          set_time_limit (5000000);
        }catch(Exception $e){
          echo "timeout";
        }

        if( strlen($min_date)>0 && strlen($max_date)>0 ){
	        $_date_default_from  = date('01/m/Y', strtotime('-3 months', $max_date) );
	        $_date_default_to = date("d/m/Y" ,$max_date);
        }
        ?>
              <div class="span12">
                <ul class="breadcrumb">
                  <li class="active">Gesti&oacute;n de datos del demostrativo</li>
                </ul>
                <div class="span11">               
                  <h3>Demostrativo <?php echo $demostrativo_id; ?>: <?php echo energylabDemostrativo::getName("demostrativo_".$demostrativo_id, "ES"); ?></h3>
                  <p>
                    Datos de salida obtenidos a partir de los documentos de entrada de datos del demostrativo <?php echo $demostrativo_id; ?>, para exportar los datos busque por fecha* y pulse el botón "exportar datos de salida ..."
                  </p>
                </div>

              </div>     

                <div class="span11" style="padding-top:1.5em;margin:0;">        

                  <div class="span4" >
                    <div data-date-format="dd/mm/yyyy" data-date="<?php echo $_date_default_from; ?>" id="dt_from" class="input-append date">
                      <input type="text" readonly="" value="<?php echo $_date_default_from; ?>"  id="dt_from_value" size="16" class="input-medium fecha" placeholder="<?php echo $_fecha_desde; ?>">
                      <span class="add-on"><i class="icon-calendar"></i></span>
                    </div>
                  </div>

                   <div class="span4" >
                    <div data-date-format="dd/mm/yyyy" data-date="<?php echo $_date_default_to; ?>" id="dt_to" class="input-append date">
                      <input type="text" readonly="" value="<?php echo $_date_default_to; ?>"  id="dt_to_value"  size="16" class="input-medium fecha" placeholder="<?php echo $_fecha_hasta; ?>">
                      <span class="add-on"><i class="icon-calendar"></i></span>
                    </div>
                  </div>
                  <div class="span4" >
                    <button class="btn btn-primary" onclick="exportarXlsx()"> exportar datos de salida ... </button>
                  </div>
              </div>
              <div class="span11 dtabledemostrativo" id="dres" style="margin:0;max-width:100%;border-bottom:1px solid #ddd;overflow-x:auto;"></div>

              <div class="span11 info_pie_tabla" id="info_pie_tabla">
                  <sub>
                    * Existe registro de datos desde el  <?php echo date("d/m/Y", $min_date); ?>  hasta el  <?php echo date("d/m/Y", $max_date); ?>. Se muestran por defecto los datos de los &uacute;ltimos 3 meses.
                  </sub>
              </div>
        </div><!-- ./span9 -->
        <form method="post" id="frmxlsx" action="../files/xlsx.php">
          <input type="hidden" name="table" value="<?php echo $dataTable ; ?>"/>
          <input type="hidden" name="dtFrom" id="dtFromXlsx" />
          <input type="hidden" name="dtTo" id="dtToXlsx" />
        </form>          

        <div id="loading" style="margin:0;padding:0;"></div>
    </div>
  </div><!-- ./container-->

  <?php 
  include "_js_footer.php";
  ?>

  <script type="text/javascript" src="../js/jquery.dataTables.js"></script>
  <script type="text/javascript" src="../js/ColVis.min.js"></script>
  <script type="text/javascript" src="../js/DT_bootstrap.js"></script>
  
  <script type="text/javascript">
      $('head').append('<link rel="stylesheet" href="../css/DT_bootstrap.css" type="text/css" />'); 
      $('head').append('<link rel="stylesheet" href="../css/datepicker.css" type="text/css" />'); 
      $('head').append('<link rel="stylesheet" href="../css/ColVis.css" type="text/css" />'); 



      var g_dtFrom = "";
      var g_dtTo = "";
      var gType = "";

      var nowTemp = new Date();
      var dateFrom = new Date("2007", "01", "01", 0, 0, 0, 0);
      var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
      var myDataTable;
       
      var checkin = $('#dt_from').datepicker({
          format: "dd/mm/yyyy",
          onRender: function(date) {
              return date.valueOf() < dateFrom.valueOf() ? 'disabled' : '';
          }
      }).on('changeDate', function(ev) {
          if (ev.date.valueOf() > checkout.date.valueOf()) {
              var newDate = new Date(ev.date)
              newDate.setDate(newDate.getDate() + 1);
              checkout.setValue(newDate);
          }
          checkin.hide();
          setTable();
      }).data('datepicker');

      var checkout = $('#dt_to').datepicker({
          format: "dd/mm/yyyy",
          onRender: function(date) {
              return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
          }
      }).on('changeDate', function(ev) {
        checkout.hide();
        setTable();
      }).data('datepicker');

        function exportarXlsx(){
          $(".btn").blur();
          if( $(".dataTable").find('.dataTables_empty').length == 1 ) {
              alert("no hay datos que exportar ...");
              return;
          }          
          $("#dtFromXlsx").val( $('#dt_from_value').val() );
          $("#dtToXlsx").val( $('#dt_to_value').val() );
          $("#frmxlsx").submit();
        }

        function setTable(){
          $.ajax({
            url: "../ajax/get_tcolumns.php",
            timeout: 99999999,
            data: "table=<?php echo $dataTable; ?>",
            beforeSend: function (  ) {
              $("#dres").html("Buscando resultados ...");
            }
          }).done(function ( data ) {

                var parsed = jQuery.parseJSON(data);
                $("#dres").html("<table cellpadding='0' cellspacing='0' border='0' class='table table-striped table-bordered' id='tdata'></table>");
                var thh1 = $('<tr></tr>');   
                var thh2 = $('<tr></tr>');   
                var thf = $('<tr></tr>'); 
                var thead = $('<thead></thead>');
                var tfoot = $('<tfoot></tfoot>');
                var sTh = "";
                var i = 0;
                var j = 3;     
                var demostrativo_id  = <?php echo $demostrativo_id; ?>;
                
              <?php parametrosDemostrativo::printArrayJs("aParametros", "ES", $demostrativo_id); ?>


                $.each(parsed, function(index,column) 
                {
                  if(column.PK+"" != "1")
                  {             
                    //$('<th id="th_'+column.Field+'">'+aParametros[column.Field]['nombre']+'</th>').appendTo(thh);         
                   // aParametros[column.Field]['unidades'] =  "-";//aParametros[column.Field]['unidades']"  ";  
                     if(i<22){
                          if( aParametros[column.Field]['unidades'] && aParametros[column.Field]['unidades'].length > 0)
                            $('<th rowspan="2" id="th_'+column.Field+'">' +aParametros[column.Field]['nombre']+'   ('+aParametros[column.Field]['unidades']+')</th>').appendTo(thh1);         
                          else 
                            $('<th rowspan="2" id="th_'+column.Field+'">' +aParametros[column.Field]['nombre']+'</th>').appendTo(thh1);         
                      }
                      else{
                        if(j == 3){
                          $('<th colspan="3" id="th_'+column.Field+'">' +aParametros[column.Field]['nombre']+'</th>').appendTo(thh1);            
                          j = 0;
                        }
                        if( (aParametros[column.Field]['unidades']+"").length > 0 )
                          $('<th id="th_'+column.Field+'"><span class="columna_nombre_bis">' +aParametros[column.Field]['nombre']+', </span>  ' +aParametros[column.Field]['unidades']+'</th>').appendTo(thh2); 
                        else
                          $('<th id="th_'+column.Field+'">' +aParametros[column.Field]['nombre']+'</th>').appendTo(thh2); 
                        j++;
                      }
                    i++;
                  }
                });   

                $('<th rowspan="2" ></th>').appendTo(thh1);
                $('<th rowspan="2" ></th>').appendTo(thh1);
                
                thh1.appendTo(thead);
                thh2.appendTo(thead);

                thead.prependTo('#tdata'); 
                var trb = $('<tbody><td colspan="'+i+'" class="dataTables_empty">'+i+'</td></tbody>');            
                trb.appendTo('#tdata');  
                /*thf.appendTo(tfoot);
                tfoot.appendTo('#tdata');    */

                 myDataTable = $('#tdata').dataTable({
                    "iDisplayLength": 10,
                    "bProcessing": true,
                    "bServerSide": true,
                    "bDeferRender": true,
                    "sAjaxSource": "../ajax/get_dt_tdata.php",
                     "oLanguage": {                 
                          "sProcessing":  "Cargando datos...",         
                          "sLoadingRecords": "Cargando resultados...",
                          "sZeroRecords": "No hay datos",
                           "oPaginate": {
                              "sFirst":    "Primero",
                              "sLast":     "Último",
                              "sNext":     "Siguiente",
                              "sPrevious": "Anterior"
                          },
                          "sInfo": "Mostrando registros de _START_ a _END_ de _TOTAL_ resultados (de un total de _MAX_ registros)",
                          "sInfoEmpty": "No hay datos",
                          "sInfoFiltered": ""
                    },
                    "aoColumnDefs": [
                        { "bSearchable": false, "bVisible": false, "aTargets": [  0,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21 ] },
                        // { "bSearchable": false, "bVisible": false, "aTargets": [ 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 ] },

                      //  { "bSearchable": false, "bSortable" : false, "aTargets": [ 0 ] },
                      //  { "bSearchable": false, "bSortable" : false, "aTargets": [ 1 ] },
                        { "bSearchable": false, "bVisible": true, "bSortable" : false, "aTargets": [ i-1, i, i+1 ] },
                        {
                            "aTargets": [i],
                            "mData": null,
                            "mRender": function (data, type, aData) { 
                               var aDate = aData[1].split("-");
                                var file = "../files/demostrativo_<?php echo $demostrativo  ?>/"+aDate[0]+"/"+ aDate[1]+"/demostrativo_<?php echo $demostrativo  ?>_"+aDate[0]+aDate[1]+aDate[2]+".xlsx";
                                return '<a target="_blank" href="'+file+'" class="btn btn-mini" title="Descargar documento de entrada asociado..."><i class="icon-download-alt"></i></a>';
                            }
                        },
                        {
                            "aTargets": [i+1],
                            "mData": null,
                            "mRender": function (data, type, aData) {
                                return '<button type="button" class="btn btn-mini"  title="Eliminar entrada asociada..." onclick="if(confirm(\'Eliminar demostrativo de entrada asociado...\\n¿Desea continuar?\')) if(confirm(\'También se eliminará el documento XLSX de entrada asociado.\\n\\nNo se podrán recuperar los datos eliminados\\n¿Seguro que desea eliminar el registro seleccionado?\')) removeDemo('+aData[0]+');" style="margin-top:5px;margin-bottom:5px;"><i class="icon-remove"></i></button>';
                            }
                        }
                    ],
                    "oColVis": {
                      "buttonText": "Seleccionar columnas a visualizar en la tabla  ...",
                      "aiExclude": [0, i, i+1]
                    },
                    "aaSorting": [[ 1, "desc" ]],
                    "sDom": 'C<"clear">rtip',
                          
                    "fnRowCallback": function( nRow, aData, iDisplayIndex ) {

                        $('#tdata_length').hide();
                        $('#tdata_filter').hide();
                        $('th span.columna_nombre_bis').css("display", "none");

$("div.ColVis").css("display","none");
$("div.ColVis").css("float","left");
$("div.ColVis *").css("font-size","90%");
$("div.ColVis *").css("color","#555");
$("div.ColVis").css("border","0");
$("button.ColVis_Button").css("border","0");
                     },
                    "fnServerData": function ( sSource, aoData, fnCallback ) {
                      /* Add some extra data to the sender */
                      //aoData = new Array();
                        aoData.push( { "name": "table", "value": "<?php echo $dataTable; ?>" } );
                        aoData.push( { "name": "dtFrom", "value": $('#dt_from_value').val() } );
                        aoData.push( { "name": "dtTo", "value": $('#dt_to_value').val() } );
                        
                        /*aoData.push( { "name": "url_str", "value": "" } );*/
                        $.getJSON( sSource, aoData, function (json) 
                        {
                            /* Do whatever additional processing you want on the callback, then tell DataTables */      
                            $.each(json, function(key, value)
                            {
                              if(key=="url_str")
                              {
                                server_str_url = value;
                              }
                            });
                            fnCallback(json)
                        } );                            
                    }
                });   
                oSettings = myDataTable.fnSettings();
            });
        }

    $(document).ready(function() {
      setTable();
    });

    function removeDemo (id) {
    var pos = $("#dres").position();
    var pos_pie = $("#info_pie_tabla").position();
    $("#loading").css("position", "relative");

    $("#loading").css("height", "200px" );
    $("#loading").css("width", $("#info_pie_tabla").css("width") );
    $("#loading").css("top", pos.top );
    $("#loading").css("left", pos_pie.left );
    $("#loading").css("background-image", "url(../img/loader.gif)" );
    $("#loading").css("background-repeat", "no-repeat" );
    $("#loading").css("background-position", "center center" );

    $("#loading").css("display", "block" );
    $("#dres").fadeTo("slow", 0.33);
    $("#dres .btn").attr('disabled', true);

      if(isNaN(id)){
        alert("error en el formato de llamada al procedimiento de borrado de demostrativos...");
        return;
      }

      $.ajax({
        type: 'DELETE',
        url: '../ajax/delete_demostrativo.php?id=' + id,
        success: function(data){
            myDataTable.fnClearTable( 0 );
            myDataTable.fnDraw();
            $(".info_pie_tabla sub").html("");

    $("#loading").css("display", "none" );
    $("#dres").fadeTo("slow", 1);
    $("#dres .btn").attr('disabled', false);
        },
        error: function(request, settings){
          alert("Error al intentar eliminar los datos del demostrativo: " + request.responseText  );
          myDataTable.fnDraw();

    $("#loading").css("display", "none" );
    $("#dres").fadeTo("slow", 1);
    $("#dres .btn").attr('disabled', false);
        }
      });
    }
         

  </script>

  <?php
  include "_footer.php";
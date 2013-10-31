<?php 
  include "_header.php";
?>

  <div class="container">

    <div class="row-fluid margin-top-xl">
      <div class="span3">
        <?php
           include "_lateral_demostrativo.php";
        ?>
      </div>
    <div class="span9 ">             
        <div class="span10"> 
            <h3>
              Gesti&oacute;n de usuarios 
            </h3>
              <p>
                <strong>Gesti&oacute;n de usuarios con acceso a la aplicaci&oacute;n.</strong>Los usuarios gestores de un administrativo tendr&aacute;n el perfil "USER". En la creaci&oacute;n de nuevos usuarios con perfil "USER" se le asignar&aacute; el demostrativo, esta asignaci&oacute;n no se podr&aacute; modificar. 
              </p>
        </div>
        <div class="span11" id="dres"></div>
        <div class="span11">
              <div class="btn-group">               
                <a class="btn btn-primary" href="crear_usuario.php">crear nuevo usuario</a>
              </div>
        </div>
</div><!-- ./span9 -->
      
</div>

  </div><!-- ./container-->

  <?php 
  include "_js_footer.php";
  ?>

  <script type="text/javascript" src="../js/jquery.dataTables.js"></script>
  <script type="text/javascript" src="../js/DT_bootstrap.js"></script>
  
  <script type="text/javascript">
      $('head').append('<link rel="stylesheet" href="../css/DT_bootstrap.css" type="text/css" />'); 

        function setTable(){
          $.ajax({
            url: "../ajax/get_tcolumns.php",
            data: "table=td_members",
            beforeSend: function (  ) {
              $("#dres").html("buscando usuarios ...");
            }
          }).done(function ( data ) {

                var parsed = jQuery.parseJSON(data);
                $("#dres").html("<table cellpadding='0' cellspacing='0' border='0' class='table table-striped table-bordered' id='tdata'></table>");
                var thh = $('<tr></tr>');   
                var thf = $('<tr></tr>'); 
                var thead = $('<thead></thead>');
                var tfoot = $('<tfoot></tfoot>');
                var sTh = "";
                var i = 0;      
                
                $.each(parsed, function(index,column) 
                {   
                  if(column.PK+"" != "1")
                  {             
                    var name = "";
                    switch(column.Field){
                      case "login_attempts":
                        name = "estado";
                        break;
                      case "username":
                        name = "nombre y apellidos";
                        break;
                      case "role":
                        name = "perfil de usuario";
                        break;
                      case "role_code":
                        name = "perfil (código)";
                        break;
                      case "demostrativo_name":
                        name = "demostrativo asignado";
                        break;
                      default:
                        name = column.Field;
                    }

                    $('<th>'+name+'</th>').appendTo(thh);         
                    $('<th>'+name+'</th>').appendTo(thf);
                    i++;
                  }
                });   
                $('<th></th>').appendTo(thh);
                $('<th></th>').appendTo(thh);

                
                thh.appendTo(thead);
                thead.prependTo('#tdata'); 
                var trb = $('<tbody><td colspan="'+i+'" class="dataTables_empty">'+i+'</td></tbody>');            
                trb.appendTo('#tdata');  
                /*thf.appendTo(tfoot);
                tfoot.appendTo('#tdata');    */

                 myDataTable = $('#tdata').dataTable({
                    "bProcessing": true,
                    "bServerSide": true,
                    "bDeferRender": true,
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
                        { "bSearchable": false, "bVisible": false, "aTargets": [ 0 ] },

                        {
                            "aTargets": [6],
                            "mData": null,
                            "mRender": function (data, type, aData) {
                              if(aData[6] > <?php echo $_MAX_LOGIN_ATTEMPS; ?>)
                                return '<strong style="color:#c00;">bloqueado</strong>';//<button type="button" class="btn btn-mini"  title="Eliminar entrada asociada..." onclick="if(confirm(\'Eliminar demostrativo de entrada asociado...\\n¿Desea continuar?\')) if(confirm(\'También se eliminará el documento XLSX de entrada asociado.\\n\\nNo se podrán recuperar los datos eliminados\\n¿Seguro que desea eliminar el registro seleccionado?\')) removeDemo('+aData[2]+');" style="margin-top:5px;margin-bottom:5px;"><i class="icon-remove"></i></button>';
                              else 
                                return '<label style="color:steelblue;">activo</label>';
                            }
                        }
                      ],
                    "sAjaxSource": "../ajax/get_dt_tdata.php",
                    "iDisplayLength": 5,
                    "bFilter": false,

                    "fnRowCallback": function( nRow, aData, iDisplayIndex ) {

                        var tdTempColEdit = $('td:eq('+(aData.length-3)+')', nRow); 
                        $(tdTempColEdit, nRow).addClass("td_buttons");
                        $(tdTempColEdit, nRow).html(' <a class="btn btn-mini" href="editar_usuario.php?id='+aData[0]+'"><i class="icon-pencil"></i></a>');

                        var tdTempColDelete = $('td:eq('+(aData.length-2)+')', nRow); 
                        $(tdTempColDelete, nRow).addClass("td_buttons");
                        $(tdTempColDelete, nRow).html('<button type="button" class="btn btn-mini" onclick="if( confirm(\'¿está seguro de que desea eliminar el usuario del sistema?\') ) removeUser('+aData[0]+'); this.blur();"><i class="icon-remove"></i></button>');
                     },
                    "fnServerData": function ( sSource, aoData, fnCallback ) {
                      /* Add some extra data to the sender */
                        aoData.push( { "name": "table", "value": "td_members" } );
                        aoData.push( { "name": "url_str", "value": "" } );
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

    function removeUser (id) {
      $.ajax({
        type: "DELETE",
        url: '../ajax/delete_user.php?id=' + id,
        success: function(data){
            myDataTable.fnClearTable( 0 );
            myDataTable.fnDraw();
        },
        error: function(request, settings){
          alert("Error al intentar eliminar el usuario: " + request.responseText  );
        }
      });
    }

  </script>

  <?php
  include "_footer.php";
<?php
include_once "_header.php";
?>

  <div class="container">

    <div class="row-fluid margin-top-xl">
      <div class="span3">
        <?php
           include_once "_lateral_demostrativo.php";
        ?>
      </div>

    <div class="span9">
      
      <div class="span10">
        <h3>
          Entrada de datos
        </h3>
        <p>

          <?php
           if( $_SESSION['rol'] == "USER" )
            echo "<h4>".energylabDemostrativo::getName("demostrativo_".$_SESSION['demostrativo_id'], "ES")."</h4>";
          ?>
          Para importar hoja de cálculo de datos diarios del demostrativo seleccione el documento pulsando el bot&oacute;n "Examinar" y a continuación pulse el bot&oacute;n "Importar fichero".<br>El documento debe ser una hoja de c&aacute;lculo con extens&oacute;n XLSX y formato v&aacute;lido.
        </p>
        <br>


        
        <form action="../ajax/get_xslx.php" id="formUploadFile" name="formUploadFile" method="post" enctype="multipart/form-data" >
        <!--    <input type="file" name="myfile[]" multiple><br>
            <input type="submit" value="Upload File to Server">-->


            <input id="xlsFile" name ="xlsFile" multiple type="file" >
              <div class="input-append">
              <!--<input id="xlsFileName" class="input-large" type="text">
              <a class="btn" onclick="$('#xlsFile').click(); return false;">Examinar</a>-->
              <button id="btnUploadFile" class="btn" type="submit" disabled="disabled">Importar fichero</button>
              <?php // <button id="btnUploadFile-" class="btn" type="submit">SUBMIT</button> 
              ?>
            </div>
        </form>
        
        <div class="progress">
            <div class="bar"></div >
            <div class="percent">0%</div >
        </div>
    
        <div id="status"></div>
    </div>
    </div>
</div>
</div>
<?php
include_once "_js_footer.php";
?>
<script type="text/javascript" src="../js/jquery.form.js" id="jquery_form"></script>
<script>
(function() {
    
    var bar = $('.bar');
    var percent = $('.percent');
    var status = $('#status');

      $("#xlsFile").change(function(){
          checkFileType();
      });
       

    function checkFileType(){
        file = $("#xlsFile").val();
        extension = file.substr( (file.lastIndexOf('.') +1) ).toLowerCase();
        switch(extension){
          case "xlsx":
          case "xls":
            $("#xlsFileName").val($("#xlsFile").val());
            $("#btnUploadFile").attr("disabled", "");
            $("#btnUploadFile").removeAttr("disabled");
            return 1;
          default:
            alert ("El formato debe ser: xls o xlsx");
            $("#btnUploadFile").attr("disabled", "disabled");
            $(this).val("");
            return 0;
        }
      }


    $('#formUploadFile').ajaxForm({
        url: '../ajax/get_xslx.php', 
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                $('#progress').show();
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal)
                percent.html(percentVal);
            },
            uploadProgress: function(event, position, total, percentComplete) {
                var percentVal = percentComplete + '%';
                bar.width(percentVal)
                percent.html(percentVal);
            },
            success: function(data) {              
                var percentVal = '100%';
                bar.width(percentVal);
                percent.html(percentVal);
                var dataDecode = $.parseJSON(data);
                if (dataDecode.error) 
                {
                  $('#result').html('<div class="alert alert-error"><button class="close" data-dismiss="alert" type="button">×</button><strong>'+dataDecode.error+' </strong>: el documento no se ha podido subir. </div>');

                }else
                {                 
                  $('#result').html('<div class="alert alert-success"><button class="close" data-dismiss="alert" type="button">×</button><strong>'+dataDecode.table+' </strong>: documento ' + $("#xlsFileName").val() + ' subido con éxito.</div>');
                }
                // OK
                $('#progress').hide();
                status.empty();
                var percentVal = '0%';
                bar.width(percentVal)
                percent.html(percentVal);
                $("#btnUploadFile").blur();
                $('#formUploadFile').each (function(){
                  this.reset();
                });
              $("#btnUploadFile").attr("disabled", "disabled");
            },
            complete: function(xhr) {
              status.html(xhr.responseText);                
            }
    }); 

})();       
</script>
<?php
include_once "_footer.php";
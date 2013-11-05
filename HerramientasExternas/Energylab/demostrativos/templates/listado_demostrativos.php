<?php 
include_once "_header.php";

$demostrativo = $_SESSION['demostrativo_id'];
$total_files = array();
$lang = $_SESSION['lang'];

function dirToArray($dir) {
   $cdir = scandir($dir);
   $result = array();
   foreach ($cdir as $key => $value)
   {
      if (!in_array($value, array(".","..")))
      {
         if (is_dir($dir . DIRECTORY_SEPARATOR . $value))
         {
            $result["DIR_".$value] = dirToArray($dir . DIRECTORY_SEPARATOR . $value);
         }
         else
         {
            $result[$value] = $value;
         }
      }
   }
  
   return $result;
} 

function array_depth(array $array) {
    $max_depth = 1;

    foreach ($array as $value) {
        if (is_array($value)) {
            $depth = array_depth($value) + 1;

            if ($depth > $max_depth) {
                $max_depth = $depth;
            }
        }
    }

    return $max_depth;
}

if( $_SESSION['rol'] == "USER" ){
  $varName = "aRes".$_SESSION['demostrativo_id'];
  $$varName = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/demostrativo_".$_SESSION['demostrativo_id']);
  $i_start = $_SESSION['demostrativo_id'];
  $i_end = $_SESSION['demostrativo_id'];
}
else if( $_SESSION['rol'] == "ADMIN" ){
  $aRes1 = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/demostrativo_1");
  $aRes2 = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/demostrativo_2");
  $aRes3 = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/demostrativo_3");
  $aRes4 = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/demostrativo_4");
  $i_start = 1;
  $i_end = 4;
}

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
              <h3>Ficheros de entrada guardados:</h3>
            </div>


            <div class="span11" style="margin-left:0;"> 

                    <ul class="nav nav-tabs" id="myTab">
                      <?php
                      for($i=$i_start; $i <=$i_end; $i++){
                        $total_files[$i] = 0;
                        echo '<li><a href="#demost'.$i.'" id="'.$i.'" data-toggle="tab" title="'.energylabDemostrativo::getName("demostrativo_".$i, "ES").'">Demostrativo '.$i.'</a></li>';                      
                      }
                      ?>
                    </ul>
                     
                    <div class="tab-content">
                      <?php                       
                      for($i= $i_start; $i <= $i_end; $i++){?>
                            <div class="tab-pane active" id="demost<?php echo $i; ?>" >
                                <h4><?php echo energylabDemostrativo::getName("demostrativo_".$i, "ES"); ?></h4>
                                <br>
                                <div class="span7" style='margin:0'>
                                    <div id='calendar<?php echo $i; ?>' class="dcalendario" style="width:95%;"></div>
                                </div>
                                <div id="list<?php echo $i; ?>" class="span4">            
                                    <div class="css-treeview" id="treeview<?php echo $i; ?>">
                                        <ul>
                                            <?php
                                            $dir = "aRes".$i;
                                            draw_dir_content($$dir, $i);            
                                            ?>
                                        </ul>
                                        <p><br><br>
                                          <?php 
                                          if($total_files[$i] == 0)
                                            echo "No hay ning&uacute;n documento."; 
                                          else
                                            echo "N&ordm; total de documentos: ".$total_files[$i]; 
                                          ?>                                        
                                        </p>
                                    </div>           
                                </div>
                            </div>
                            <?php
                        }?>

                    </div>
              </div>
        </div>
      </div>
  </div>
  <?php

  function draw_dir_content($v, $demostrativo_id=0){
    global $total_files;
      if(is_array($v)){
          foreach($v as $k=>$subv){
              if(strstr($k, "DIR_") !== FALSE){
                  echo'<li><input type="checkbox" id="item-0-0" /><label for="item-'.$i.'-'.$d.'">'.str_replace("DIR_", "", $k).'</label><ul>';
                  echo draw_dir_content($subv, $demostrativo_id); 
                  echo'</ul></li>'; 
                 
              }else{
                  foreach($v as $k=>$file){
                      $a = explode("_", $file);
                      $strtime = $a[2];                    
                      echo '<li><a href="../files/demostrativo_'.$a[1].'/'.substr($strtime, 0, 4) .'/'.substr($strtime, 4, 2) .'/'.$file.'">'.$file.'</a></li>';
                      $total_files[$demostrativo_id] ++;
                  }
                  return;
              }
          }
      }
  }
                
include_once "_js_footer.php";
?>

<script src="../js/fullcalendar.min.js"></script>
<script>

  $('head').append('<link rel="stylesheet" href="../css/tree.css" type="text/css" />'); 
  $('head').append('<link rel="stylesheet" href="../css/fullcalendar.css" type="text/css" />'); 

  $(function () {
      $(".css-treeview").css("display", "none");
      $(".dcalendario").css("display", "none");
      $('#myTab a:first').tab('show'); 
      $('#myTab a:first').click();
  })

  $("#myTab a").show(function() {
      loadCalendar(this.id);
  });

  $("#myTab a").click(function() {
      this.blur();
      console.log("refetchEvents calendario demostrativo "+ this.id);
      $('#calendar'+this.id).fullCalendar('refetchEvents');
  });

  function loadCalendar(demostrativo){
      $('.calendario').html("");
      $('#calendar'+demostrativo).fullCalendar({ 
            buttonText: {
                today: 'hoy'
            },
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            dayNamesShort : ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
            eventSources: [
                {
                    url: '../ajax/get_filespath.php',
                    type: 'POST',
                    data: {
                        demostrativo: demostrativo,
                        name : name
                    },
                    error: function( data ) {                        
                        alert('Error al carga la página');
                    },
                    success: function( data ){ 
                      $(".dcalendario").css("display", "block");
                      $(".css-treeview").css("display", "block");
                    },
                    color: '#3A90BF',
                    textColor: 'white' 
                }
            ],
            eventAfterAllRender: function( view ) {
                if($(".fc-event-inner").size() > 0){
                  $(".fc-event-inner").hide();
                  $(".fc-day-content").addClass("loading");
                  $(".fc-event-inner").html('<i class="icon-arrow-down calendar_downloader" ></i>');
                  $(".fc-header-title h2").css("font-size", "16px");
                  $(".fc-event-inner").attr("title", "Descargar documento...");
                  $(".fc-event-inner").fadeIn("fast", function() {
                      $(".fc-day-content").removeClass("loading");
                  $(".fc-day-content").addClass("empty");
                  });
                }else{
                  $(".fc-day-content").removeClass("loading");
                  $(".fc-day-content").addClass("empty");
                }
            }
      });
  }
<?php 
if($_SESSION['rol'] != "ADMIN"){
  echo '$(".nav-tabs").hide();';
}
?>
</script>
<?php
include_once "_footer.php";
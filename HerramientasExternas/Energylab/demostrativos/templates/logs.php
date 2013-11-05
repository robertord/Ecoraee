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
  die("error de acceso");
}
else if( $_SESSION['rol'] == "ADMIN" ){
  $aRes1 = dirToArray(filesDir::$directory.$_REQUEST['demostrativo']."/logs");
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
            <div class="span11"> 
                <h3>Logs de aplicación:</h3>
            </div>                                  
            <div class="tab-pane active span12" id="demost" >
                <div class="span9" style='margin:0'>
                    <div id='calendar' class="dcalendario" style="width:100%;"></div>
                </div>
            </div>            
        </div>

      </div>
  </div>

  <?php             
  include_once "_js_footer.php";
?>

<script src="../js/fullcalendar.min.js"></script>
<script>
  $('head').append('<link rel="stylesheet" href="../css/fullcalendar.css" type="text/css" />'); 

  $(function () { 
      loadCalendar();
  });
  
  function loadCalendar(){
      $('.calendario').html("");
      $('#calendar').fullCalendar({ 
            buttonText: {
                today: 'hoy'
            },
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            dayNamesShort : ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
            eventSources: [
                {
                    url: '../ajax/get_logspath.php',
                    type: 'POST',
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
                  $(".fc-event-inner").html('<i class="icon-share calendar_downloader" ></i>');
                  $(".fc-header-title h2").css("font-size", "16px");
                  $(".fc-event-inner").attr("title", "Ver registro de log...");

                  $(".fc-event-inner").fadeIn("fast", function() {
                      $(".fc-day-content").removeClass("loading");
                      $(".fc-day-content").addClass("empty");
                  });
                }else{
                  $(".fc-day-content").removeClass("loading");
                  $(".fc-day-content").addClass("empty");
                }
                $("#calendar a").attr("target", "_blank");
            }
      });
  }
</script>
<?php
include_once "_footer.php";
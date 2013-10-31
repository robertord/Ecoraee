<?php 
include_once "_header.php";
include_once "Demostrativo.php";
$dtDemo = array();
$obj_demo_1 = new Demostrativo(1);
$dtDemo[1]['min'] = $obj_demo_1->getMinDate();
$dtDemo[1]['max'] = $obj_demo_1->getMaxDate();
$obj_demo_2 = new Demostrativo(2);
$dtDemo[2]['min'] = $obj_demo_2->getMinDate();
$dtDemo[2]['max'] = $obj_demo_2->getMaxDate();
$obj_demo_3 = new Demostrativo(3);
$dtDemo[3]['min'] = $obj_demo_3->getMinDate();
$dtDemo[3]['max'] = $obj_demo_3->getMaxDate();
$obj_demo_4 = new Demostrativo(4);
$dtDemo[4]['min'] = $obj_demo_4->getMinDate();
$dtDemo[4]['max'] = $obj_demo_4->getMaxDate();


function showDate($aDates){
  if( !strlen($aDates['min']) || !strlen($aDates['min']) ) {
    global $_no_data;
    echo $_no_data;
    return;
  }
  global $_lang;
  global $_bubble_date_from;  
  global $_bubble_date_to;  
  switch ($_lang) {
    case 'EN':
      $dateFotmat = "j/m/Y";
      break;    
    default:
      $dateFotmat = "d/m/Y";
      break;
  }
  if(isset($aDates['min']))
    $dtFrom = date($dateFotmat, $aDates['min']);
  if(isset($aDates['max']))
    $dtTo = date($dateFotmat, $aDates['max']);  
  
   switch ($_lang) {
    case 'EN':
    case 'ES':
      echo $_bubble_date_from." ".$dtFrom." ".$_bubble_date_to ." ". $dtTo;
      break;     
    default:
      echo $dtFrom." - ". $dtTo;
      break;
  }
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
      <section id="g1 span12">

          <div class="span6 img-polaroid img-rounded dbdemostr demo1">       
            <div class="span12">
              <h4>
                <a href="demostrativo_1.php">  <?php echo $_estadisticas_demostrativo_1_titulo; ?></a>
              </h4>             
            </div>  
            <div class="span12" id="bubbles_demo1">
                 <div id="dbubblegraph_demostrativo_1" class="gbubble"></div>
            </div>
            <sub><?php showDate($dtDemo[1]); ?></sub>
          </div>

          <div class="span6 img-polaroid img-rounded dbdemostr demo2">       
            <div class="span12">
              <h4>
                <a href="demostrativo_2.php">  <?php echo $_estadisticas_demostrativo_2_titulo; ?></a>
              </h4>              
            </div>    
            <div class="span12" id="bubbles_demo2">
                 <div id="dbubblegraph_demostrativo_2" class="gbubble"></div>
            </div>
            <sub><?php showDate($dtDemo[2]); ?></sub>
          </div>

      </section>

<div class="span12"> </div>     

      <section id="g2">

          <div class="span6 img-polaroid img-rounded dbdemostr demo3" >  
            <div class="span12">
              <h4>
                <a href="demostrativo_3.php">  <?php echo $_estadisticas_demostrativo_3_titulo; ?></a>
              </h4>            
            </div>

            <div class="span12" id="bubbles_demo3">
                 <div id="dbubblegraph_demostrativo_3" class="gbubble"></div>
            </div>
            <sub><?php showDate($dtDemo[3]); ?></sub>
          </div>

          <div class="span6 img-polaroid img-rounded dbdemostr demo4">  
            <div class="span12">
              <h4>
                <a href="demostrativo_4.php">  <?php echo $_estadisticas_demostrativo_4_titulo; ?></a>
              </h4>            
            </div>         
            <div class="span12" id="bubbles_demo4">
                 <div id="dbubblegraph_demostrativo_4" class="gbubble"></div>
            </div>
            <sub><?php showDate($dtDemo[4]); ?></sub>   
          </div>
      </section>

    </div> <!-- ./span9 -->
   
</div><!-- ./row-->

      <!-- FOOTER -->

 
</div><!-- ./container-->
<?php
include_once "_js_footer.php";
?>
<script src="../js/d3.v3.min.js"></script>
<script src="../js/chart.bubble.js"></script>

<script>
  <?php 
    parametrosDemostrativo::printArrayJsCategoriasPeso("aCategorias", $_lang);
  ?>
  $(document).ready(function(){
      var ratio = 250;
      $.when(draw_bubble_chart("demostrativo_1", ratio, "dbubblegraph_demostrativo_1", aCategorias)).then(show_chart(1));;
      $.when(draw_bubble_chart("demostrativo_2", ratio, "dbubblegraph_demostrativo_2", aCategorias)).then(show_chart(2));;
      $.when(draw_bubble_chart("demostrativo_3", ratio, "dbubblegraph_demostrativo_3", aCategorias)).then(show_chart(3));;
      $.when(draw_bubble_chart("demostrativo_4", ratio, "dbubblegraph_demostrativo_4", aCategorias)).then(show_chart(4));;
      
      function show_chart(n){
        $(".demo"+n).show("slow", function() {          
            $(".demo"+n).css("background-image", "none");
            $("#dbubblegraph_demostrativo_"+n).fadeIn("slow");
            $(".demo"+n+" sub").fadeIn("slow");
        });
      }
  });
</script>

<?php
include_once "_footer.php";
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
          <div class="span11">  
              <h2>
                <?php
                  $var = "_demostrativo_".$_REQUEST['demostrativo']."_titulo" ;
                  echo $$var; 
               ?>
             </h2>
             <p>
              <?php
                  $var = "_demostrativo_".$_REQUEST['demostrativo']."_articulo" ;
                  echo $$var; 
              ?>                
             </p>
            </div>
            <div class="span10 line_bi" style="margin:0;padding:0"> 
                  <?php 
        				  $_REQUEST['w'] = 760;
        				  $_REQUEST['h'] = 500;
                  include 'line_bi_data.php';
        				  unset($_REQUEST['w']);
        				  unset($_REQUEST['h']);
                  ?>
            </div>

          </div> <!-- ./span9 -->
    
      
</div><!-- ./row-->
      <!-- FOOTER -->

 
</div><!-- ./container-->

  <?php 
  include_once "_js_footer.php";
  include_once "_footer.php";
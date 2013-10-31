<?php 
require_once('../conf/configuration.php');
include_once "Demostrativo.php";

$_REQUEST['w'] = "700";
$_REQUEST['h'] = "350";
$a = explode("_", $_REQUEST['demostrativo']);
$demostrativo_id = $a[1];

$obj_demo = new Demostrativo($demostrativo_id);
$dt_data_from = $obj_demo->getMinDate();
$dt_data_to = $obj_demo->getMaxDate();


if( strlen($dt_data_from)>0 && strlen($dt_data_to)>0 ){
$_date_default_from  = date('d/m/Y', strtotime('-3 months', $dt_data_to) );
$_date_default_to = date("d/m/Y" ,$dt_data_to);
}
?>
    <div class="span6">         
          <h4 class="span12"><?php echo $_encabezado_form_parametros; ?></h4>        

          <div class="span12" style="margin:0;" id="field_1_<?php echo $_REQUEST['demostrativo']; ?>">
            <select name ="field_1" id="field_1" class="field field_1 span10" style="margin:0px;margin-bottom:8px;"><option></option></select>
          </div>
          <div class="span12" style="margin:0;" id="field_2_<?php echo $_REQUEST['demostrativo']; ?>">
            <select name ="field_2" id="field_2" class="field field_2 span10" style="margin:0px"><option></option></select>
          </div>
    </div>


    <div class="span6">

        <h4 class="span12"><?php echo $_encabezado_form_fecha; ?></h4>   
          <div class="span10">
          <div data-date-format="dd/mm/yyyy" data-date="<?php echo $_date_default_from; ?>" style="margin:0px;"  id="dt_from" class="input-append date">
              <input type="text" readonly="" value="<?php echo $_date_default_from; ?>" style="margin:0px;margin-bottom:8px;" id="dt_from_value" size="16" class="input-medium fecha" placeholder="<?php echo $_fecha_desde; ?>" />
            <span class="add-on"><i class="icon-calendar"></i></span>
          </div>
        </div>
          <div class="span10">
          <div data-date-format="dd/mm/yyyy" data-date="<?php echo $_date_default_to; ?>" style="margin:0px;"  id="dt_to" class="input-append date">
            <input type="text" readonly="" value="<?php echo $_date_default_to; ?>" style="margin:0px;" id="dt_to_value"  size="16" class="input-medium fecha" placeholder="<?php echo $_fecha_hasta; ?>">
            <span class="add-on"><i class="icon-calendar"></i></span>
          </div>
        </div>


</div>
<div class="span12" style="padding-top:10px;">    
    <div class="span2"></div>
    <div class="span6 btn-group">
      <button name="updateButton" id="btnDatosDiarios" type="button" class="btn  input-medium" onclick="chartDatosDiarios()" disabled="disabled" ><?php echo $_btn_diario; ?></button>
      <button name="revertButton" id="btnDatosAcumulados" type="button" class="btn  input-medium" onclick="chartDatosAcumulados()" disabled="disabled" ><?php echo $_btn_acumulado; ?></button>
      <button name="resetButton" id="btnReset" type="button" class="btn" onclick="defaultData()"><i class="icon-refresh"></i><?php echo $_btn_reset; ?></button>
  </div>
</div>

<div class="span10 gline_bi" id="dbilinegraph<?php echo $_REQUEST['demostrativo']; ?>">
</div>


  <?php 
  include_once "_js_footer.php";
  ?>

<!-- load the d3.js library --> 

<script>
    $('head').append('<link rel="stylesheet" href="../css/graph_demostrativo.css" type="text/css" />'); 
    $('head').append('<link rel="stylesheet" href="../css/datepicker.css" type="text/css" />'); 

    <?php 
    # SELECTOR DE FECHA #  
    ?>


      var graphic_container = "#dbilinegraph<?php echo $_REQUEST['demostrativo']; ?>";

      var parametros; 
      var field_1;
      var field_2;
      var text_yaxis_1;
      var text_yaxis_2;
      var first_draw = false;
      
      <?php 
      parametrosDemostrativo::printArrayJs("aParametros", $_lang, $demostrativo_id);
      ?>

      var g_dtFrom = "";
      var g_dtTo = "";
      var gType = "";

      var nowTemp = new Date();
      var dateFrom = new Date("2010", "01", "01", 0, 0, 0, 0);
      var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
       
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
          validateDates();
          showChart();
      }).data('datepicker');

      var checkout = $('#dt_to').datepicker({
          format: "dd/mm/yyyy",
          onRender: function(date) {
              return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
          }
      }).on('changeDate', function(ev) {
        validateDates();
        checkout.hide();
        showChart();
      }).data('datepicker');


    function getDateFrom(){
        checkin.setValue(checkin.date); 
        checkout.setValue(checkout.date);
        return $("#dt_from_value").val();
    }
     function getDateTo(){
        checkin.setValue(checkin.date); 
        checkout.setValue(checkout.date);
         return $("#dt_to_value").val();
    }
    <?php 




    # GRAFICAS #  
    ?>

    function chartReset(){
        $("#field_1").val("");
        $("#field_2").val("");
        $("#dt_from").val("");
        $("#dt_to").val("");
        $("#dt_from_value").val("");
        $("#dt_to_value").val("");
        $("#btnDatosDiarios").attr('disabled', 'disabled');    
        $("#btnDatosAcumulados").attr('disabled', 'disabled');         
        $("#btnReset").blur();
        validateDates();
        validateParameters();
        gType = "";
    }
    
    function defaultData(){
        $("#field_1").val("<?php echo $_grafica_default_line1; ?>");
        $("#field_2").val("<?php echo $_grafica_default_line2; ?>");
        $("#dt_from").val("<?php echo $_date_default_from; ?>");
        $("#dt_to").val("<?php echo $_date_default_to; ?>");
        $("#dt_from_value").val("<?php echo $_date_default_from; ?>");
        $("#dt_to_value").val("<?php echo $_date_default_to; ?>");
        checkin.setValue("<?php echo $_date_default_from; ?>"); 
        checkout.setValue("<?php echo $_date_default_to; ?>");
        showChart(); 
        $("#btnReset").blur();
    }
<?php
      if( strlen($dt_data_from) == 0 ||  strlen($dt_data_from) == 0 ){
        echo 'alert("'.$_no_data.'");';        
      }
?>

    function showChart(){
      if(validateDates() && validateParameters()){
          if( $("#btnDatosDiarios").attr("disabled") == "disabled" && $("#btnDatosAcumulados").attr("disabled") == "disabled" ){
            chartDatosAcumulados();
            return;
          }

          if( $("#btnDatosDiarios").attr("disabled") == "disabled")
          {
            chartDatosDiarios();
          }
          else
          {
            chartDatosAcumulados();
          }
      }      

      }

    $.ajax( "../ajax/get_tparam.php?table=vw_demostrativo_campos_linechart").done(function(data)
    {
        chartReset();  
        parametros = jQuery.parseJSON(data);
        $.each(parametros, function(index, column)
        {
            $('.field').append("<option value='"+column.key+"' class='"+column.key+"'>"+aParametros[column.key]['nombre']+"  (" +aParametros[column.key]['unidades']+ ") </option>");             
        });            
        $(".field").change(function (){ showChart(); });
        defaultData();
    }).fail(function(){ /*alert("error");*/ }) .always(function(){/*alert("complete"); */});


    function validateDates(){      
      g_dtFrom = $('#dt_from').val();
      g_dtTo = $('#dt_to').val();
      if( g_dtFrom.length > 0 || g_dtTo.length > 0)      
          return true;      
      return false;
    }

    function format_to_gdecimal(number)  {
      if( isNaN( parseFloat( number ) ) ) 
        return 0;
      number = parseFloat(number).toFixed(2);
      if( (number+"").indexOf(".00") != -1)
        number = parseFloat(number).toFixed(0);
      return number;
    }

    function validateParameters(){        
        field_1 = "";
        field_2 = "";
        text_yaxis_1 = "";
        text_yaxis_2 = "";
        $(".field option").removeAttr('disabled');          

        if( $(".field_1").val().length > 0 ){
            field_1 = $(".field_1 option:selected:first").attr('class')+"";
            $(".field_2 option."+field_1).attr("disabled", "disabled");    
        }

        if( $(".field_2").val().length > 0 ){
            field_2 = $(".field_2 option:selected:first").attr('class')+"";
            $(".field_1 option."+field_2).attr("disabled", "disabled");   
        }

        if(field_1 == field_2)
        {
            $(".field_2").val("");
        }
        else
        {              
            if(field_1.length > 0 && field_2.length > 0 ){  
                text_yaxis_1 = $(".field_1 option:selected:first").text();
                text_yaxis_2 = $(".field_2 option:selected:first").text();
                return true;
            }
        }
        return false;
    }


// Set the dimensions of the canvas / graph
    var   color = d3.scale.category10();
    var   margin = {top: 20, right: 100, bottom: 100, left: 100},
          height = "<?php echo $_REQUEST['h']; ?>"*1 - margin.top - margin.bottom,
          width = "<?php echo $_REQUEST['w']; ?>"*1  - margin.left - margin.right,
          margin2 = {top: "<?php echo $_REQUEST['h']; ?>"-70, right: 100, bottom: 20, left: 100},
          height2 = "<?php echo $_REQUEST['h']; ?>"*1 - margin2.top - margin2.bottom;

// Parse the date / time
    var   parseDate = d3.time.format("%Y-%m-%d").parse;

// Set the ranges
    var   x = d3.time.scale().range([0, width]);
    var   y = d3.scale.linear().range([height, 0]);

    var   x2 = d3.time.scale().range([0, width]);
    var   y_2 = d3.scale.linear().range([height, 0]);


    var   line_date_selector_1;
    var   line_date_selector_2;

    var   y_line_1;
    var   y_line_2;
    var   y_line_date_selector_1;
    var   y_line_date_selector_2;

    var   brush;


// Adds the svg canvas
    var svg = d3.select(graphic_container)
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom);

    var chart_details = svg.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var chart_date_selector = svg.append("g")
      .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");


    svg.append("defs").append("clipPath")
        .attr("id", "clip")
        .append("rect")
        .attr("width", width)
        .attr("height", height);

    svg.append("defs").append("clipPath")
        .attr("id", "clip2")
        .append("rect")
        .attr("width", width)
        .attr("height", height);

    var xAxis,      
        yAxisLine1,
        yAxisLine2,
        xAxis2,
        yAxisSelectorLine1,
        yAxisSelectorLine2;
        

    var line_graph_1 = d3.svg.line()
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y_line_1(d[field_1]); });

    var line_graph_2 = d3.svg.line()
        .x(function(d) { return x(d.date); })
        .y(function(d) { return y_line_2(d[field_2]); });


    function chartDatosDiarios()
    { 
        $("#btnDatosDiarios").attr("disabled", "disabled"); 
        $("#btnDatosAcumulados").removeAttr('disabled');   
        $("#btnDatosDiarios").blur();     
        d3.json("../ajax/get_tdata.php?table=<?php echo $_REQUEST['demostrativo']; ?>_diario&dtFrom="+getDateFrom()+"&dtTo="+getDateTo(), function(error, data) 
        {
            gType = "DIARIO";
            data.forEach(function(d) 
            {
                d.date = parseDate(d.date);
                d[field_1] = +d[field_1];
                d[field_2] = +d[field_2];
            });
            if(!first_draw)                    
                firstDraw(data);
            else                    
                reDraw(data);

            $(".gline_bi").css("background-image", "none");
        });       
    } 

    function chartDatosAcumulados()
    {
        $("#btnDatosAcumulados").attr("disabled", "disabled"); 
        $("#btnDatosDiarios").removeAttr('disabled');    
        $("#btnDatosAcumulados").blur(); 
        d3.json("../ajax/get_tdata.php?table=<?php echo $_REQUEST['demostrativo']; ?>_acumulativo_todo&dtFrom="+getDateFrom()+"&dtTo="+getDateTo(), function(error, data) 
        {
            gType = "ACUMULADO";
            data.forEach(function(d) 
            {
                d.date = parseDate(d.date);
                d[field_1] = +d[field_1].replace(",","");
                d[field_2] = +d[field_2].replace(",","");
            });
            if(!first_draw)                    
                firstDraw(data);
            else                    
                reDraw(data);

            $(".gline_bi").css("background-image", "none");
        });       
    } 


    function getRound(n, diff, up){
      var multipl;
      if(diff == null)
         multipl = 10;
      else if (diff < 10)
         multipl = 1;
      else if (diff < 50)
         multipl = 5;
      else if (diff < 100)
         multipl = 10;
      else if (diff < 1000)
         multipl = 100;
      else
         multipl = 1000;

      if(up) // UP
      {
        if(n > 0)
            return Math.ceil(n/multipl) * multipl;
        else if( n < 0)
            return Math.floor(n/multipl) * multipl;
        else 
          return multipl;
      }
      else // DOWN
      {
        if(n >= multipl)
          n -= multipl;
        if(n > 0)
            return Math.floor(n/multipl) * multipl;
        else if( n < 0)
            return Math.ceil(n/multipl) * multipl;
        else 
          return 0;
      }
    }



    function commonDraw(data){

      //  EJE X
          x.domain( d3.extent( data.map(function(d){ return d.date; }) ) );
          x2.domain(x.domain());
          d3.select(".x.brush").remove();
          /* Gráfica foco */
            xAxis = d3.svg.axis().scale(x).orient("bottom").tickFormat(d3.time.format('%d/%m/%y'));
          /* Gráfica selección de fechas */
            xAxis2 = d3.svg.axis().scale(x2).orient("bottom").tickFormat(d3.time.format('%d/%m/%y'));

      //  EJE Y - PARAMETRO 1
         /* valor mínimo y máximo de la línea redondeado */
            var min_line1 = getRound(d3.min(data, function(d) { return Math.min( d[field_1] ); }), null, false);                      
            var max_line1 = getRound(d3.max(data, function(d) { return Math.max( d[field_1] ); }), null, true); 


          /* Gráfica foco */
            y_line_1 = d3.scale.linear().domain([min_line1, max_line1]).range([height, 0]);
            yAxisLine1 = d3.svg.axis()
              .scale(y_line_1) .tickFormat(d3.format(',.0d'))
              .ticks( 10 )
              .orient("left");

      //  EJE Y - PARAMETRO 2
          /* valor mínimo y máximo de la línea redondeado  */
            var min_line2 = getRound(d3.min(data, function(d) { return Math.min( d[field_2] ); }), null, false);  
            var max_line2 = getRound(d3.max(data, function(d) { return Math.max( d[field_2] ); }), null, true);  
          /* Gráfica foco */
            y_line_2 = d3.scale.linear().domain([min_line2, max_line2]).range([height, 0]);       
            yAxisLine2 = d3.svg.axis()
              .scale(y_line_2)
              .ticks( 10 )
              .orient("right");     
          /* Gráfica selección de fechas */
            y_line_date_selector_2 = d3.scale.linear().domain([min_line2, max_line2]).range([height2, 0]);
            yAxisSelectorLine2 = d3.svg.axis()
              .scale( y_line_date_selector_2 )
              .ticks( 2 )
              .orient("right"); 
          /* Gráfica selección de fechas */
            y_line_date_selector_1 = d3.scale.linear().domain([min_line1, max_line1]).range([height2, 0]);
            yAxisSelectorLine1 = d3.svg.axis()
              .scale( y_line_date_selector_1 )
              .ticks( 2 )
              .orient("left");






// draw the scatterplot
  chart_details.selectAll("circle").remove();
  if(data.length < 21){
    var circle = chart_details.selectAll("dot")                  // provides a suitable grouping for the svg elements that will be added
      .data(data)                     // associates the range of data to the group of elements
    .enter().append("circle")               // adds a circle for each data point
      .attr("r", 3)                   // with a radius of 3.5 pixels
      .attr("cx", function(d) { return x(d.date); })    // at an appropriate x coordinate 
      .attr("cy", function(d) { return y_line_1(d[field_1]); });  // and an appropriate y coordinate

      circle.append("title")
      .text(function(d) { return d[field_1]; });


    var circle2 = chart_details.selectAll("dot")                  // provides a suitable grouping for the svg elements that will be added
      .data(data)                     // associates the range of data to the group of elements
    .enter().append("circle")               // adds a circle for each data point
      .attr("r", 3)                   // with a radius of 3.5 pixels
      .attr("cx", function(d) { return x(d.date); })    // at an appropriate x coordinate 
      .attr("cy", function(d) { return y_line_2(d[field_2]); });  // and an appropriate y coordinate

      circle2.append("title")
      .text(function(d) { return d[field_2]; });
  }





      //  DIBUJO EJES GRAFICAS
          /* Borro valores previos ejes */
            chart_details.selectAll(".axis").remove();
          /* Dibujo eje X */
            chart_details.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);    
          /* Dibujo ejes Y de líneas 1 y 2 */
            chart_details.append("g")
                .attr("class", "y axis y_axis_line_1")
                .style('stroke', color(1))
                .attr('transform', 'translate(-15, 0)')
                .call(yAxisLine1)
                    .append("text")
                    .attr("transform", "rotate(-90)")
                    .attr("y", -55)
                    .attr("dy", "-22px")
                    .style("text-anchor", "end")
                    .text(text_yaxis_1);
            chart_details.append("g")
                .attr("class", "y axis y_axis_line_2")
                .style('stroke', color(2))
                .attr("transform", "translate(" + (width+15) + ",0)")
                .call(yAxisLine2)
                    .append("text")
                    .attr("transform", "rotate(-90)")
                    .attr("y", 53)
                    .attr("dy", "22px") 
                    .style("text-anchor", "end")
                    .text(text_yaxis_2);



       //  DIBUJO GRAFICA SELCCION FECHA
          /* Borro valores previos ejes */
            chart_date_selector.selectAll(".axis").remove();
          /* Dibujo eje X */
            chart_date_selector.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height2 + ")")
                .call(xAxis2);
          /* Dibujo ejes Y de líneas 1 y 2 */
            chart_date_selector.append("svg:g")
                .attr("class", "y axis y_axis_sel_1")
                .style('stroke', color(1))
                 .attr("transform", "translate(-15, 0)")
                .call(yAxisSelectorLine1);
            chart_date_selector.append("g")
                .attr("class", "y axis y_axis_sel_1")
                .style('stroke', color(2))
                .attr("transform", "translate(" + (width+15) + ",0)")
                .call(yAxisSelectorLine2);

        //  LINEAS
            line_date_selector_1 = d3.svg.line()
              .x(function(d) { return x2( d.date ); })
              .y(function(d) { return y_line_date_selector_1( d[field_1] ); });
            line_date_selector_2 = d3.svg.line()
              .x(function(d) { return x2( d.date );  })
              .y(function(d) { return y_line_date_selector_2( d[field_2] ); });

// TODO : no funciona, indicar hover value
/////////////////////////////////////////////

    var h = d3.max(data, function(d) { return d[field_1]; }) + 15;
    var area = svg.selectAll("path").data([data]).enter().append("path")
      .attr(
          "d",
          d3.svg.area()
              .x(function(d) { return d['date']; })
              .y0(h)        
              .y1(function(d) { return d[field_1]; })
      );

      var circle = svg.append("circle")
          .attr("r", 3)
          .attr("display", "none");


    area
    .on("mouseover", function() { circle.attr("display", "block"); })
    .on("mousemove", update)
    .on("mouseout", function() { circle.attr("display", "none"); });

    function update() {    
        var x = d3.mouse(this)[0];
        var y;
        
        if ( table[x] === undefined ) {
            var lower = x - (x % SPACING);
            var upper = lower + SPACING;
            var between = d3.interpolateNumber(table[lower], table[upper]);
            y = between( (x % SPACING) / SPACING );
        } else {
            y = table[x];
        }
        
        circle
            .attr("cx", x)
            .attr("cy", y);
    }


////////////////////////////////////////////



        //  EVENTO SELECCION DE FECHA
            brush = d3.svg.brush()
                .x(x2)
                .on("brush", brushed);
           chart_date_selector.append("g")
                .attr("class", "x brush")
                .call(brush)
              .selectAll("rect")
                .attr("y", -6)
                .attr("height", height2 + 7);           



                  if( gType == "ACUMULADO")
                      brushed();
            // SELECCION RANGO FECHA FOCO............
            function brushed() {

                chart_details.selectAll("circle").remove();
                /* Gráfica diaria: se mantienen los valores de los ejes y */
                /* Valores mínimos y máximos de las líneas antes de aplicar el filtro */
                x.domain(brush.empty() ? x2.domain() : brush.extent());
                var min_line1;
                var max_line1;
                var min_line2;      
                var max_line2;

                var min_base_line1 = getRound(d3.min(data, function(d) { return Math.min( d[field_1] ); }), null, false);
                var max_base_line1 = getRound(d3.max(data, function(d) { return Math.max( d[field_1] ); }), null, true);
                var min_base_line2 = getRound(d3.min(data, function(d) { return Math.min( d[field_2] ); }), null, false);   
                var max_base_line2 = getRound(d3.max(data, function(d) { return Math.max( d[field_2] ); }), null, true);   
                
                var minExtent = d3.time.day(brush.extent()[0]), 
                    maxExtent = d3.time.day(brush.extent()[1]);
                var aDates = [];
                var nDays = 0;

                var dataFiltered_line1 = data.filter(function(d, i) {
                    if ( (d.date >= x.domain()[0]) && (d.date <= x.domain()[1]) ) {
                      return d[field_1];
                    }
                });
                var dataFiltered_line2 = data.filter(function(d, i) {
                    if ( (d.date >= x.domain()[0]) && (d.date <= x.domain()[1]) ) {
                      aDates.push(d.date);
                      return d[field_2];
                    }
                });

                if( gType == "DIARIO")
                {    

                    min_line1 = min_base_line1;
                    max_line1 = max_base_line1;
                    min_line2 = min_base_line2;
                    max_line2 = max_base_line2;

                }
                else if( gType == "ACUMULADO")
                {

                    nDays = aDates.length;


                    var min_line1_rango = d3.min(dataFiltered_line1.map(function(d) { return d[field_1]; }) );                    
                    var max_line1_rango = d3.max(dataFiltered_line1.map(function(d) { return d[field_1]; }) );          


                    var valor_min_line1_esperado =  min_line2_rango * min_base_line1 / min_base_line2;
                    var valor_max_line1_esperado =  max_line2_rango * max_base_line1 / max_base_line2;

                    if( valor_min_line1_esperado < min_line1_rango )
                        min_line1_rango = valor_min_line1_esperado;

                    if( valor_max_line1_esperado > max_line1_rango )
                        max_line1_rango =  valor_max_line1_esperado;
                   

                    var min_line2_rango = d3.min(dataFiltered_line2.map(function(d) { return d[field_2]; }) );
                    var max_line2_rango = d3.max(dataFiltered_line2.map(function(d) { return d[field_2]; }) );

                    if (min_base_line1 == 0)
                      min_base_line1 = 1;
                    if (max_base_line1 == 0)
                      max_base_line1 = 1;
                     if (min_base_line2 == 0)
                      min_base_line2 = 1;
                    if (max_base_line2 == 0)
                      max_base_line2 = 1;

                    var valor_min_line2_esperado =  min_line1_rango * min_base_line2 / min_base_line1;
                    var valor_max_line2_esperado =  max_line1_rango * max_base_line2 / max_base_line1;

                    if(  min_line2_rango < valor_min_line2_esperado ){  
                        min_line1_rango =  min_line2_rango * min_base_line1 / min_base_line2;
                    }

                    if( max_line2_rango > valor_max_line2_esperado ){
                        max_line1_rango =  max_line2_rango * max_base_line1 / max_base_line2;
                    }


                    var diffMinMax = max_line1_rango - min_line1_rango;

                    min_line1_rango = min_line1_rango - 10;
                    max_line1_rango = max_line1_rango + 10;

                    min_line1 = Math.floor(min_line1_rango);
                    max_line1 = Math.ceil(max_line1_rango);
            
                    min_line2 = Math.floor( min_line1 * min_base_line2 / min_base_line1 );
                    max_line2 = Math.ceil( max_line1 * max_base_line2 / max_base_line1 );
                }

                y_line_1 = d3.scale.linear()
                  .domain([min_line1, max_line1])
                  .range([height, 0]);
                yAxisLine1 = d3.svg.axis()
                    .scale(y_line_1)
                    .ticks( 10 )
                    .orient("left");

                y_line_2 = d3.scale.linear()
                  .domain([min_line2, max_line2])
                  .range([height, 0]);

                yAxisLine2 = d3.svg.axis()
                    .scale(y_line_2)
                    .ticks( 10 )
                    .orient("right");   

                chart_details.select(".y_axis_line_1").call(yAxisLine1);
                chart_details.select(".y_axis_line_2").call(yAxisLine2);

                var dotRadio;
                if(dataFiltered_line1 && dataFiltered_line1.length < 21){       
                    var dotRadio = 3;
                }else if(dataFiltered_line1 && dataFiltered_line1.length < 40){       
                    var dotRadio = 1.5;
                }else if(dataFiltered_line1 && dataFiltered_line1.length < 75){       
                  var dotRadio = 1;
                }else{
                  var dotRadio = 0;
                }


                  var circle  = chart_details.selectAll("dot")                  // provides a suitable grouping for the svg elements that will be added
                    .data(dataFiltered_line1)                     // associates the range of data to the group of elements
                  .enter().append("circle")               // adds a circle for each data point
                    .attr("r", dotRadio)                   // with a radius of 3.5 pixels
                    .attr("id", function(d) { return "l1c_"+d.date; })    // at an appropriate x coordinate 
                    .attr("cx", function(d) { return x(d.date); })    // at an appropriate x coordinate 
                    .attr("cy", function(d) { return y_line_1(d[field_1]); }); // and an appropriate y coordinate

                    circle.append("title")
                    .text(function(d) { return d[field_1]; });

                

                  var circle = chart_details.selectAll("dot")                  // provides a suitable grouping for the svg elements that will be added
                    .data(dataFiltered_line2)                     // associates the range of data to the group of elements
                  .enter().append("circle")               // adds a circle for each data point
                    .attr("r", dotRadio)                   // with a radius of 3.5 pixels
                    .attr("cx", function(d) { return x(d.date); })    // at an appropriate x coordinate 
                    .attr("cy", function(d) { return y_line_2(d[field_2]); });  // and an appropriate y coordinate

                    circle.append("title")
                    .text(function(d) { return d[field_2]; });
                
/*
var maxl1_length = (max_line1+"").length;
maxl1_length = maxl1_length + Math.floor(maxl1_length/3);
var maxl2_length = (max_line2+"").length;
maxl2_length = maxl2_length + Math.floor(maxl2_length/3);

console.log("Resumen: " +nDays);
console.log("Line 1 ("+field_1+"): " +min_line1+",  "+max_line1 + "  txt:"+maxl1_length);
console.log("Line 2 ("+field_2+"): " +min_line2+",  "+max_line2 + "  txt:"+maxl2_length);

        var svg_redraw = d3.select(graphic_container).transition();
svg_redraw.select(".y_axis_line_1 text:first-child")
  .attr("dy","-2em")
  .duration(750);


/*if ((maxExtent - minExtent) > 1468800000) {
    xAxis.ticks(d3.time.mondays, 1).tickFormat(d3.time.format('%a %d'))
    xAxis2.ticks(d3.time.days, 1).tickFormat(d3.time.format('%b - Week %W'))
    console.log("- UNO ");     
}
else*/ 
var diffExtent = 0;

if(maxExtent && minExtent)
  diffExtent = (maxExtent - minExtent);

if (diffExtent <= 0 )
{
    if(nDays == 0)
      nDays = 1;
    else if(nDays > 7)
      nDays = 5;
    xAxis.ticks(nDays, 7).tickFormat(d3.time.format('%Y/%m/%d'));
}
else if(diffExtent < 1296000000)
{ // hasta 15 días
    if(nDays == 0)
      nDays = 1;
    else if(nDays > 7)
      nDays = 5;
    xAxis.ticks(nDays, 7).tickFormat(d3.time.format('%Y/%m/%d'));
}
else if (diffExtent <= 4316400000)   // 2678400000 hasta 31 días, 7344000000 85 días, 4316400000 50
{  
    xAxis.ticks(d3.time.mondays, 1).tickFormat(d3.time.format('%b - Semana %W'));
}
else if(diffExtent <= 31536000000 )  // hasta 365 dias
{
    xAxis.ticks(d3.time.months, 1).tickFormat(d3.time.format('%m-%Y'));
}
else {
    xAxis.ticks(d3.time.months, 3).tickFormat(d3.time.format('%m-%Y'))
}


if(nDays <= 7){
    xAxis2.ticks(nDays, 7).tickFormat(d3.time.format('%Y/%m/%d'));
}
else if(nDays <= 30){
    xAxis2.ticks(d3.time.mondays, 3).tickFormat(d3.time.format('%b - Semana %W'));
}

                chart_details.select(".x.axis").call(xAxis);

                chart_date_selector.select(".x.axis").call(xAxis2);


                chart_details.select("#gline1").attr("d", line_graph_1(data) );
                chart_details.select("#gline2").attr("d", line_graph_2(data) );  

            }      
    }



    function firstDraw(data){
        first_draw = true;
        commonDraw(data);        
        chart_details.append("path")
            .datum(data)
            .attr("id", "gline1")
            .attr("clip-path", "url(#clip)")
            .attr("d", line_graph_1( data ) )
            .attr('class', 'line line1 data1')
            .style('stroke', color(1));  
        chart_details.append("path")
            .datum(data)
            .attr("id", "gline2")
            .attr("clip-path", "url(#clip2)")
            .attr("d", line_graph_2( data ) )
            .attr('class', 'line line2 data2')
            .style('stroke', color(2));          
        chart_date_selector.append("path")
            .datum(data)
            .attr("id", "sel_line1")
            .attr("d", line_date_selector_1( data ) )            
            .attr('class', 'line data1 linecontext1')
            .style('stroke', color(1));
        chart_date_selector.append("path")
            .datum(data)
            .attr("id", "sel_line2")
            .attr("d", line_date_selector_2( data ) )            
            .attr('class', 'line data2 linecontext2')
            .style('stroke', color(2));    
    }


    function reDraw(data){        
        commonDraw(data);
        var svg_redraw = d3.select(graphic_container).transition();
        svg_redraw.select("#gline1")
            .attr("d", line_graph_1( data ) )
            .duration(750);  
        svg_redraw.select("#gline2")
            .attr("d", line_graph_2( data ) )
            .duration(750);  

        svg_redraw.select("#sel_line1")
            .attr("d", line_date_selector_1( data ) )
            .duration(750);  
        svg_redraw.select("#sel_line2")
            .attr("d", line_date_selector_2( data ) )
            .duration(750);                
    }



</script>
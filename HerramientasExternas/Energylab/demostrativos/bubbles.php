  <div id="dbubblegraph<?php echo $_REQUEST['demostrativo']; ?>" class="gbubble"></div>
  <?php // <div id="dtablegraph<?php echo $_REQUEST['demostrativo']; "  class="gtdata tdata"></div> 
  /* var table = [];
      table.push('<div class=" tdata span12" >');
      data.forEach(function(d) {
         table.push('<div class="span3 tdataline"><span>'+d.name+': </span><span>'+d.value+'</span></div>');
      });
      table.push('</div>');

      $("#dtablegraph"+get_table_name()).html(table);*/
  ?>

	<script>
  $('head').append('<script src="../demostrativo/js/graph_demostrativo.js"></script>'); 
  $('head').append('<script src="../demostrativo/js/jquery.min.js"></script>'); 

    var r = "<?php echo $_REQUEST['r']; ?>"*1,
        format = d3.format(",d"),
        fill = d3.scale.category20c();      
     if(r<2)
      r=275;
    var bubble = d3.layout.pack()
        .sort(null)
        .size([r, r]);
     
    var vis = d3.select("#dbubblegraph<?php echo $_REQUEST['demostrativo']; ?>").append("svg:svg")
        .attr("width", r)
        .attr("height", r)
        .attr("class", "bubble");
 
  d3.json("ajax/get_tsum.php?table=<?php echo $_REQUEST['demostrativo']; ?>", function(data) {      
     

      var keeper =  {children: data};
      var color = d3.scale.category20();
        
      var node = vis.selectAll("g.node")
        .data(bubble.nodes(classes(keeper))
        .filter(function(d) { return !d.children; }))
      .enter().append("svg:g")
        .attr("class", "node")
        .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
   
     /*node.append("svg:title")
        .text(function(d) { return d.className + ": " + format(d.value); });*/
   


      var div = d3.select("#dbubblegraph<?php echo $_REQUEST['demostrativo']; ?>").append("div")   
          .attr("class", "tooltip alert img-polaroid img-rounded")         
          .style("opacity", 0);

      node.append("svg:circle")
        .attr("r", function(d) { return d.r; })
        .attr("i", function(d, i) { return i; })
        .style("fill", function(d, i) { return color(i); })
        //.on("mouseover", function() { d3.select(this).style("fill", "#000"); })
        //.on("mouseout",  function(d, i) { d3.select(this).style("fill", color(i)); });

        .on("mouseover", function(d) { 
            d3.select(this).style("stroke", "#222");     
            d3.select(this).style("stroke-width", "1px");     
            div.transition()        
                .duration(200)      
                .style("opacity", .9);
            var p = $("#dbubblegraph<?php echo $_REQUEST['demostrativo']; ?>");

            div .html("<table class='tbubbletitle'><tr><th>"+d.className + "</th><td>"+ d.value+"</td></tr></table>")
                .attr("id", "d<?php echo $_REQUEST['demostrativo']; ?>") 
                .style("left", Math.ceil(d.x +  p.offset().left) + "px")     
                .style("top", Math.ceil(d.y +  p.offset().top) + "px");    
            }) 
        .on("mouseout", function(d, i) {       
            //d3.select(this).style("fill", color(i));
            d3.select(this).style("stroke-width", "0px");  
            div.transition()        
                .duration(500)      
                .style("opacity", 0);   
        });



        function bubbleClick(){
          alert("si");
        }
       
       /* node.append("svg:text")
            .attr("text-anchor", "middle")
            .attr("dy", ".3em")
            .text(function(d) { return d.className.substring(0, d.r / 3); });*/   
          /*


    var mouseMove = function() {
        var infobox = d3.select(".infobox");
        var coord = d3.svg.mouse(this)
        // now we just position the infobox roughly where our mouse is
        infobox.style("left", coord[0] + 15 + "px" );
        infobox.style("top", coord[1] + "px");
    }
       
      var mouseOver = function(d) {
        var bubble = d3.select(this);
        bubble.attr("stroke", "#000")
        .attr("stroke-width", 4 );
        var infobox = d3.select(".infobox")
        .style("display", "block" );
        infobox.select("p.value")
        .text( d.value );
      }
       
      var mouseOut = function() {
        var infobox = d3.select(".infobox");
        infobox.style("display", "none" )
        var bubble = d3.select(this);
        bubble.attr("stroke", "none")
      }
       
      // attach function to run when mouse is moved anywhere on svg
      d3.select("svg")
       .on("mousemove", mouseMove );
       
      // add <p> elements to our infobox. later we will enter our crime data there
      var infobox = d3.select(".infobox");
      infobox.append("p")
        .attr("class", "state" );
      infobox.append("p")
        .attr("class", "xdata" );
      infobox.append("p")
        .attr("class", "ydata" );
       
      // append bubbles and attach function to run when bubbles moused over and moused out
      vis.selectAll("circle.bubble").data(keeper)
      .enter().append("svg:circle")
      .attr("class", "bubble")
      .attr("cx", xpos )
      .attr("cy", ypos )  
      .attr("r", radius ) 
      .attr("fill", color )
      .on( "mouseover", mouseOver )
      .on( "mouseout", mouseOut );  

      */
      function classes(root) {
        var classes = [];       
        function recurse(name, node) {
          if (node.children)
              node.children.forEach(function(child) { recurse(node.name, child); });
          else 
              classes.push({packageName: name, className: node.name, value: node.value});
        }       
        recurse(null, root);
        return {children: classes};
      }







   
  });
	</script>
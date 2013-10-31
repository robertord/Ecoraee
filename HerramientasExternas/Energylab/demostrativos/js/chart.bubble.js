function draw_bubble_chart(demostrativo, r, container_id, aParametros){

    var r = r,
        format = d3.format(",d"),
        fill = d3.scale.category20c();     

     if(r<2)
        r=275;
    var width = r+100;
    var height = r;
    var total = 0;

    var bubble = d3.layout.pack()
        .sort(null)
        .size([r-20, r]);
     
    var vis = d3.select("#"+container_id).append("svg:svg")
        .attr("width", width)
        .attr("height", height)
        .attr("class", "bubble");

    d3.json("../ajax/get_tacum.php?table="+demostrativo+"_acumulativo", function(data) {   
          var keeper =  {children: data};
          var color = d3.scale.linear()
            .domain([0, 5])
            .range(["#52C8E7", "#034486"])
            .interpolate(d3.interpolateLab);
            
          var node = vis.selectAll("g.node")
            .data(bubble.nodes(classes(keeper))
            .filter(function(d) { return !d.children; }))
          .enter().append("svg:g")
            .attr("class", "node")
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });       

          var div = d3.select("#"+container_id).append("div")   
              .attr("class", "tooltip alert img-polaroid img-rounded")   
              .style("opacity", 0);

          node.append("svg:circle")
            .attr("r", function(d) { return d.r; })
            .attr("i", function(d, i) { return i; })
            .attr("id", function(d, i) { return container_id+""+d.className; })
            .style("fill", function(d, i) { return color(i); })

            .on("mouseover", function(d) { 
                d3.select(this).style("stroke", "#222");     
                d3.select(this).style("stroke-width", "1px");     
                div.transition()        
                    .duration(200)      
                    .style("opacity", .9);
                var p = $("#"+container_id);
                div .html("<table class='tbubbletitle'><tr><th >"+aParametros[d.className]['nombre'] + "</th></tr><tr><td>"+ d.value+" "+aParametros[d.className]['unidades'] + "</td></tr><tr><td>"+ d.valor_standard+" "+aParametros[d.className]['unidades_standard'] + "</td></tr></table>")
                    .attr("id", "d"+demostrativo) 
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


            var legend = vis.selectAll(".legend")
                .data(bubble.nodes(classes(keeper))
                .filter(function(d) { return !d.children; }))
              .enter().append("svg:g")
                .attr("class", "legend")
                .attr("transform", function(d, i) { return "translate(0, " + i * 20 + ")"; });

            legend.append("rect")
                .attr("x", width - 18)
                .attr("width", 18)
                .attr("height", 18)
                .on("mouseover", function(d) { 
                    d3.select("#"+container_id+""+d.className).style("stroke", "#444");     
                    d3.select("#"+container_id+""+d.className).style("stroke-width", "2px");    
                    d3.select(this).style("stroke", "#222");     
                    d3.select(this).style("stroke-width", "1px");     
                 })
                .on("mouseout", function(d, i) {   
                  d3.select("#"+container_id+""+d.className).style("stroke-width", "0px");  
                  d3.select(this).style("stroke-width", "0px");  
                })
               .style("fill", function(d, i) { return color(i); })

            legend.append("text")
                .attr("x", width-25)
                .attr("y", 9)
                .attr("dy", ".35em")
                .style("text-anchor", "end")
                .style("font-family", "Verdana")
                .style("font-size", "9px")      
                .text(function(d) { return aParametros[d.className]['nombre']; });

          if( total == 0) {
              $("#dbubblegraph_"+demostrativo).addClass("empty_bubble_chart");
          }else{
              $("#dbubblegraph_"+demostrativo).removeClass("empty_bubble_chart");
          }
           
          function classes(root) {
            var classes = [];       
            function recurse(name, node) {
              if (node.children)
                  node.children.forEach(function(child) { recurse(node.name, child); });
              else{
                  classes.push({packageName: name, className: node.name, value: format_to_gdecimal(node.value), valor_standard: format_to_gdecimal(node.valor_standard), valor_intuitivo: format_to_gdecimal(node.valor_intuitivo) });
                  if( !isNaN(node.value) )
                    total = total + node.value;
                }
            }     

            function format_to_gdecimal(number)  {
              if( isNaN( parseFloat( number ) ) ) 
                return 0;
              number = parseFloat(number).toFixed(2);
              if( (number+"").indexOf(".00") != -1)
                number = parseFloat(number).toFixed(0);
              return number;
            }
            recurse(null, root);
            return {children: classes};
          }
    });
}
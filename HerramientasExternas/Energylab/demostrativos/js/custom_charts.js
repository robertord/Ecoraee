var graph_container = "dgraph";
function show_chart(conf, xv, yv){
	var margin = conf.margin,
		width = conf.size.width - margin.left - margin.right,
		height = conf.size.height - margin.top - margin.bottom;
	var parseDate = d3.time.format(conf.date_format).parse;
	var x = d3.time.scale().range([0, width]);
	var y = d3.scale.linear().range([height, 0]);
	
	var xAxis = d3.svg.axis().scale(x).orient("bottom");
	var yAxis = d3.svg.axis().scale(y).orient("left");
	$("#"+graph_container).html("");
	var svg = d3.select("#"+graph_container).append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
	  .append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
	var data = conf.data;
	
	var nX = 0;
	data.forEach(function(d) {
		d[xv] = parseDate(d[xv]);
		d[yv] =+ d[yv];
		nX++;
	});	
	
	x.domain(d3.extent(data, function(d) { return d[xv]; }));
	y.domain([0, d3.max(data, function(d) { return d[yv]; })]);
	var chart_type;	
	switch(conf.char_type){
		case "area": 
			chart_type = d3.svg.area()
				.x(function(d) { return x(d[xv]); })
				.y0(height)
				.y1(function(d) { return y(d[yv]); });			
			svg.append("path")
				.datum(data)
				.attr("class", conf.char_type+"")
				.attr("d", chart_type);		
			break;
		case "line": 
			chart_type = d3.svg.line()
			.x(function(d) { return x(d[xv]); })
			.y(function(d) { return y(d[yv]); });
			svg.append("path")
				.datum(data)
				.attr("class", conf.char_type+"")
				.attr("d", chart_type);		
			break;
		case "bar":
			svg.selectAll(".bar")
			  .data(data)
			.enter().append("rect")
			  .attr("class", "bar")
			  .attr("x", function(d) { return x(d[xv]); })
			  .attr("width", width/(nX+1)-10)
			  .attr("y", function(d) { return y(d[yv]); })
			  .attr("height", function(d) { return height - y(d[yv]); });
			break;
	}	
		
	var xSvg = svg.append("g")
		.attr("class", conf.axis_x.class_name)
		.attr("transform", "translate(0," + height + ")")
		.call(xAxis)		
	.append("text")
		.attr("x", width/2)
		.attr("dy", conf.axis_x.text.dy)
		.style("text-anchor", conf.axis_x.text.text_anchor)
		.text(conf.axis_x.text.visible_value);		
	svg.append("g")
		.attr("class", conf.axis_y.class_name)
		.call(yAxis)
	.append("text")
		.attr("transform", "rotate(-90)")
		.attr("y", conf.axis_y.text.y)
		.attr("dy", conf.axis_y.text.dy)
		.style("text-anchor", conf.axis_y.text.text_anchor)
		.text(conf.axis_y.text.visible_value);
}
function donut_chart(basedata){
	var total = 0;	
	var width = 960,
    height = 500,
    radius = Math.min(width, height) / 2;
	var color = d3.scale.ordinal()
		.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
	var arc = d3.svg.arc()
		.outerRadius(radius - 10)
		.innerRadius(radius - 70);
		
	var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.value; });
	var svg = d3.select("#"+graph_container).append("svg")
		.attr("width", width)
		.attr("height", height)
	  .append("g")
		.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
	var data = [];
	$.each(basedata, function(k, v) {	
		v = +v;
		data.push({"key":k,"value":v});
	});	
	var g = svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "arc");
	g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.key); });
	g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.key; });
}
function pie_chart(basedata){
	var width = 960,
		height = 500,
		radius = Math.min(width, height) / 2;
	var color = d3.scale.ordinal()
		.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);
	var arc = d3.svg.arc()
		.outerRadius(radius - 10)
		.innerRadius(0);
	var pie = d3.layout.pie()
		.sort(null)
		.value(function(d) { return d.value; });
	var svg = d3.select("#"+graph_container).append("svg")
		.attr("width", width)
		.attr("height", height)
	  .append("g")
		.attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
	var data = [];
	$.each(basedata, function(k, v) {	
		v = +v;
		data.push({"key":k,"value":v});
	});	
	var g = svg.selectAll(".arc")
	  .data(pie(data))
	.enter().append("g")
	  .attr("class", "arc");
	g.append("path")
	  .attr("d", arc)
	  .style("fill", function(d) { return color(d.data.key); });
	g.append("text")
	  .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
	  .attr("dy", ".35em")
	  .style("text-anchor", "middle")
	  .text(function(d) { return d.data.key; });	
}
function bar_chart_sortable(basedata){
	var margin = {top: 20, right: 20, bottom: 30, left: 40},
		width = 960 - margin.left - margin.right,
		height = 500 - margin.top - margin.bottom;
	
	var checkBoxId = "sort_"+randString();
	$("#"+graph_container).html( $("#"+graph_container).html()+'<br><label><input id="'+checkBoxId+'" type="checkbox">Ordenar</label>');
	$("#"+checkBoxId).on("change", change);
	//var formatPercent = d3.format(".0%");
	var x = d3.scale.ordinal()
		.rangeRoundBands([0, width], .1, 0);
	var y = d3.scale.linear()
		.range([height, 0]);
	var xAxis = d3.svg.axis()
		.scale(x)
		.orient("bottom");
	var yAxis = d3.svg.axis()
		.scale(y)
		.orient("left");
		//.tickFormat(formatPercent);
	var svg = d3.select("#"+graph_container).append("svg")
		.attr("width", width + margin.left + margin.right)
		.attr("height", height + margin.top + margin.bottom)
	  .append("g")
		.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		var data = [];
		var total = 0;
		$.each(basedata, function(k, v) {	
			total = +v;
		});
		$.each(basedata, function(k, v) {	
			data.push({"key":k,"value":v});
		});	
	  x.domain(data.map(function(d) { return d.key; }));
	  y.domain([0, d3.max(data, function(d) { return d.value; })]);
	  svg.append("g")
		  .attr("class", "x axis")  
		  .attr("transform", "translate(0," + height + ")")
		  .call(xAxis);
	  svg.append("g")
		  .attr("class", "y axis")
		  .call(yAxis)
		.append("text")
		  .attr("transform", "rotate(-90)")
		  .attr("y", 6)
		  .attr("dy", ".71em")
		  .style("text-anchor", "end")
		  .text("value");
	  svg.selectAll(".bar")
		  .data(data)
		.enter().append("rect")
		  .attr("class", "bar")
		  .attr("x", function(d) { return x(d.key); })
		  .attr("width", x.rangeBand())
		  .attr("y", function(d) { return y(d.value); })
		  .attr("height", function(d) { return height - y(d.value); });
	  
	  function change() { 
		var x0 = x.domain(data.sort(this.checked
			? function(a, b) { return b.value - a.value; }
			: function(a, b) { return d3.ascending(a.key, b.key); })
			.map(function(d) { return d.key; }))
			.copy();
		var transition = svg.transition().duration(750),
			delay = function(d, i) { return i * 50; };
		transition.selectAll(".bar")
			.delay(delay)
			.attr("x", function(d) { return x0(d.key); });
		transition.select(".x.axis")
			.call(xAxis)
		  .selectAll("g")
			.delay(delay);
	  }
}
function bubble_chart(data){
	var diameter = 600 - 30,
		limit=5000,
		format = d3.format(",d"),
		color = d3.scale.category20c();
	var bubble = d3.layout.pack()
		.sort(null)
		.size([diameter, diameter])
		.padding(1.5);
	var svg = d3.select("#"+graph_container).append("svg")
		.attr("width", diameter)
		.attr("height", diameter)
		.attr("class", "bubble");
	minVal=10000;
	maxVal=-100;
	var dobj=[];
	$.each(data, function(k, v) {
		if (minVal>v) minVal = v;
		if (maxVal<v) maxVal = v;
		dobj.push({"key":k,"value":v});
	});
	
	var root = 	{children: dobj};
	
	var node = svg.selectAll(".node")
		.data(bubble.nodes(root)
			.filter(function(d) { return !d.children; }))
		.enter().append("g")
		.attr("class", "node")
		.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
		.style("fill", function(d) { return color(d.key); })
	  	.on("mouseover", function(d,i)
		{
			d3.select(this).style("fill", "gold"); 
			
			showToolTip(" "+d.key+"<br>"+d.value+" ",window.event.clientX+d3.mouse(this)[0]+50+ document.body.scrollLeft ,window.event.clientY+d3.mouse(this)[1]+document.body.scrollTop,true);
			//console.log(d3.mouse(this));
		})
		.on("mousemove", function(d,i)
		{
			tooltipDivID.css({top:window.event.clientY+d3.mouse(this)[1],left:window.event.clientX+d3.mouse(this)[0]+50});
		//	showToolTip("<ul><li>"+data[i]['key']+"<li>"+data[i]['value']+"</ul>",d.x+d3.mouse(this)[0]+10,d.y+d3.mouse(this)[1]-10,true);
			//console.log(d3.mouse(this));
		})	
		.on("mouseout", function()
		{
			d3.select(this).style("fill", function(d) { return color(d.key); });
			showToolTip(" ",0,0,false);
		});
	  /*node.append("title")
		  .text(function(d) { return data[0][d.key] + ": " + format(d.value); });
	*/
	node.append("circle")
      .attr("r", function(d) { return d.r; })
	  ;
      //.style("fill", function(d) { return color(data[0][d.key]); });
	node.append("text")
      .attr("dy", ".3em")
      .style("text-anchor", "middle")
	  .style("fill","black")
      .text(function(d) { return d.key.substring(0, d.r / 3); });	
}
function bar_chart_date_xy(basedata){
	var data = [];
	$.each(basedata, function(k, v) {	
		v = +v;
		data.push({"key":k, "value":v});
	});	
	var margin = {top: 40, right: 40, bottom: 40, left:40},
    width = 600,
    height = 500;
	var x = d3.time.scale()
		.domain([new Date(data[0].key), d3.time.day.offset(new Date(data[data.length - 1].key), 1)])
		.rangeRound([0, width - margin.left - margin.right]);
	var y = d3.scale.linear()
		.domain([0, d3.max(data, function(d) { return d.value; })])
		.range([height - margin.top - margin.bottom, 0]);
	var xAxis = d3.svg.axis()
		.scale(x)
		.orient('bottom')
		.ticks(d3.time.days, 1)
		.tickFormat(d3.time.format('%a %d'))
		.tickSize(0)
		.tickPadding(8);
	var yAxis = d3.svg.axis()
		.scale(y)
		.orient('left')
		.tickPadding(8);
	var svg = d3.select("#"+graph_container).append('svg')
		.attr('class', 'chart')
		.attr('width', width)
		.attr('height', height)
	  .append('g')
		.attr('transform', 'translate(' + margin.left + ', ' + margin.top + ')');
	svg.selectAll('.chart')
		.data(data)
	  .enter().append('rect')
		.attr('class', 'bar')
		.attr('x', function(d) { return x(new Date(d.key)); })
		.attr('y', function(d) { return height - margin.top - margin.bottom - (height - margin.top - margin.bottom - y(d.value)) })
		.attr('width', 10)
		.attr('height', function(d) { return height - margin.top - margin.bottom - y(d.value) });
	svg.append('g')
		.attr('class', 'x axis')
		.attr('transform', 'translate(0, ' + (height - margin.top - margin.bottom) + ')')
		.call(xAxis);
	svg.append('g')
	  .attr('class', 'y axis')
	  .call(yAxis);	  
}
function line_chart_date_xy(basedata){
	var margin = {top: 20, right: 20, bottom: 30, left: 50},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;
    var parseDate = d3.time.format("%Y-%m-%d").parse;
    var x = d3.time.scale()
        .range([0, width]);
    var y = d3.scale.linear()
        .range([height, 0]);
    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");
    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");
    var area = d3.svg.area()
        .x(function(d) { return x(d.key); })
        .y0(height)
        .y1(function(d) { return y(d.value); });
    var svg = d3.select("#"+graph_container).append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
	  
	var data = [];
	$.each(basedata, function(k, v) {	
		v = +v;
		k = parseDate(k);
		data.push({"key":k, "value":v});
	});	
    x.domain(d3.extent(data, function(d) { return d.key; }));
    y.domain([0, d3.max(data, function(d) { return d.value; })]);
    svg.append("path")
      .datum(data)
      .attr("class", "area")
      .attr("d", area);
    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);
    svg.append("g")
      .attr("class", "y axis")
      .call(yAxis);
}
function randString(n)
{
    if(!n)
    {
        n = 5;
    }
    var text = '';
    var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for(var i=0; i < n; i++)
    {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}
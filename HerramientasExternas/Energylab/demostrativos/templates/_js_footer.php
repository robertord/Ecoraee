<script type="text/javascript" src="../js/jquery-2.0.2.min.js" id="jquery"></script>
<script type="text/javascript" src="../js/prettify_page.js" id="prettify"></script>
<script type="text/javascript" src="../js/bootstrap-transition_page.js"></script>
<script type="text/javascript" src="../js/bootstrap-alert.js"></script>
<script type="text/javascript" src="../js/bootstrap-modal_page.js"></script>
<script type="text/javascript" src="../js/bootstrap-dropdown_page.js"></script>
<script type="text/javascript" src="../js/bootstrap-scrollspy_page.js"></script>
<script type="text/javascript" src="../js/bootstrap-tab.js"></script>
<script type="text/javascript" src="../js/bootstrap-tooltip.js"></script>
<script type="text/javascript" src="../js/bootstrap-popover.js"></script>
<script type="text/javascript" src="../js/bootstrap-button.js"></script>
<script type="text/javascript" src="../js/bootstrap-collapse_page.js"></script>
<script type="text/javascript" src="../js/bootstrap-carousel.js"></script>
<script type="text/javascript" src="../js/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="../js/bootstrap-affix.js"></script>
<script type="text/javascript" src="../js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="../js/d3.v3.min.js"></script>

<script type="text/javascript" src="../js/browser_detect.js"></script>

<script>
	$("#menu_lat li").removeClass("active");
	$("#<?php echo $li_op;?>").addClass("active");
	$("ul.breadcrumb").remove();
	$("div.container div.span9:first").css("min-heigh", $("#menu_lat").css("height") );
	$("div.container div.span9:first").css("margin-bottom", "50px" );
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var acompItem = '';

            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }
            
            $(document).ready(function() {
                q_getId();
      			q_gt('acomp', '', 0, 0, 0, "");
            });
            
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        acompItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            acompItem = acompItem + (acompItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_eng3p');
                        break;
                }
            }
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_eng3p',
                    options : [{
                        type : '0', //[1] 
                        name : 'accy',
                        value : q_getId()[4]
                    },{
						type : '0',//[2]
						name : 'mountprecision',
						value : q_getPara('rc2.mountPrecision')
					},{
						type : '0',//[3]
						name : 'weightprecision',
						value : q_getPara('rc2.weightPrecision')
					},{
						type : '0',//[4]
						name : 'priceprecision',
						value : q_getPara('rc2.pricePrecision')
					},{
                        type : '5', //[5]//1
                        name : 'xcno',
                        value : acompItem.split(',')
                    }, {
                        type : '1', //[6][7]//2
                        name : 'xnoa'
                    }, {
                        type : '1', //[8][9]//3
                        name : 'xdate'
                    }, {
                        type : '2', //[10][11]//4
                        name : 'xtgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
				
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                
                if(q_getHref()[0]=='noa'){
                	$('#txtXnoa1').val(q_getHref()[1]);
                	$('#txtXnoa2').val(q_getHref()[1]);
                }
                
            }

            function q_boxClose(s2) {
            }
            
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
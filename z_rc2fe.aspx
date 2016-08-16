<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
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
                        q_gf('', 'z_rc2fe');
                        break;
                }
            }
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_rc2fe',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '0', //[2]
                        name : 'mountprecision',
                        value : q_getPara('rc2.mountPrecision')
                    }, {
                        type : '0', //[3]
                        name : 'weightprecision',
                        value : q_getPara('rc2.weightPrecision')
                    }, {
                        type : '0', //[4]
                        name : 'priceprecision',
                        value : q_getPara('rc2.pricePrecision')
                    },{
                        type : '5', //[5] 1
                        name : 'xcno',
                        value : acompItem.split(',')
                    }, {
                        type : '2', //[6][7]	2
                        name : 'xtgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {
                        type : '2', //[8][9]	4
                        name : 'xucc',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '1', //[10][11]	8
                        name : 'xmon'
                    }, {
                        type : '1', //[12][13]	1
                        name : 'xdate'
                    }, {
                        type : '6', //[14]	2
                        name : 'xopaydate'
                    }, {
                        type : '0', //[15]
                        name : 'worker',
                        value : r_name
                    },{
						type : '0',//[16]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
				
				var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
				}else{
					$('#txtXdate1').datepicker();
					$('#txtXdate2').datepicker();
				}
				
                $('#txtXmon1').mask(r_picm);
                $('#txtXmon2').mask(r_picm);
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate2').mask(r_picd);

                var t_noa = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
                t_noa = t_noa.replace('noa=', '');
                $('#txtXnoa1').val(t_noa);
                $('#txtXnoa2').val(t_noa);

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);
                $('#txtXmon1').val(t_year + '/' + t_month);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
                $('#txtXmon2').val(t_year + '/' + t_month);
                
                if(window.parent.q_name=='rc2a'){ //1041215
                	var t_report=999;
					for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
						if($('#q_report').data().info.reportData[i].report=='z_rc2fe3'){
							t_report=i;
							$('#q_report div div .radio').eq(t_report).removeClass('nonselect').addClass('select').click();
						}
					}
                	
                	$('#txtXtgg1a').val(window.parent.$('#txtTggno').val());
                	$('#txtXtgg1b').val(window.parent.$('#txtComp').val());
                	$('#txtXtgg2a').val(window.parent.$('#txtTggno').val());
                	$('#txtXtgg2b').val(window.parent.$('#txtComp').val());
                	$('#txtXmon1').val(window.parent.$('#txtMon').val());
                	$('#txtXmon2').val(window.parent.$('#txtMon').val());
                	$('#txtXdate1').val('');
                	$('#txtXdate2').val('');
                	$('#btnOk').click();
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
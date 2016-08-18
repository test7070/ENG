﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
			var t_acomp = '';
			$(document).ready(function() {
				q_getId();
				q_gt('acomp', '', 0, 0, 0, "");
				
			});
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        t_acomp = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            t_acomp = t_acomp + (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_ummfe');
                        break;
                }
            }
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ummfe',
					options : [{
						type : '5', //[1]      1
						name : 'xcno',
						value : t_acomp.split(',')
					}, {
						type : '2', //[2][3]   2
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '1', //[4][5]   3
						name : 'xdate'
					}, {
						type : '1', //[6][7]   4
						name : 'xmon'
					}, {            //[8]      5
                        type : '8',
                        name : 'xoption01',
                        value : ['明細']
                    }, {
						type : '1', //[9][10]  6
						name : 'ydate'
					}, {
						type : '6', //[11]     7
						name : 'ymon'
					}, {            //[12]     8
                        type : '8',
                        name : 'yoption01',
                        value : ['依業務','僅印異常','出貨-預收+','出貨-預收-']
                    }, {
						type : '0', //[13] 
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					}, {
                        type : '0', //[14]
                        name : 'xname',
                        value : r_name 
                    }, {
						type : '1', //[15][16]   9
						name : 'zdate'
					}, {
						type : '2', //[17][18]   10
						name : 'xsss',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
                        type : '8', //[19]       11
                        name : 'zoption01',
                        value : ['依業務']
                    }, {
						type : '6', //[20]     12
						name : 'edate'
					}]
				});
				q_popAssign();
				q_langShow();
				
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				$('#txtXmon1').mask('999/99');
				$('#txtXmon2').mask('999/99');
				$('#txtYdate1').mask('999/99/99');
				$('#txtYdate1').datepicker();
				$('#txtYdate2').mask('999/99/99');
				$('#txtYdate2').datepicker();
				$('#txtZdate1').mask('999/99/99');
				$('#txtZdate1').datepicker();
				$('#txtZdate2').mask('999/99/99');
				$('#txtZdate2').datepicker();
				$('#txtEdate').mask('999/99/99');
				$('#txtEdate').datepicker();
				
				$('#txtYmon').mask('999/99');
				
				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				//$('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				//$('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
				
				t_date = new Date();
				t_date.setDate(1);
				t_date.setDate(-1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				
				$('#txtXmon1').val(t_year + '/' + t_month);
				$('#txtXmon2').val(t_year + '/' + t_month);
				
				//出貨-預收(2選1)
				$('#chkYoption01 [value="出貨-預收+"]').click(function(){
					if($('#chkYoption01 [value="出貨-預收-"]').prop('checked')){
						$('#chkYoption01 [value="出貨-預收-"]').prop("checked",false);			
					}	
				});
				$('#chkYoption01 [value="出貨-預收-"]').click(function(){
					if($('#chkYoption01 [value="出貨-預收+"]').prop('checked')){
						$('#chkYoption01 [value="出貨-預收+"]').prop("checked",false);			
					}	
				});
				
				$('#lblXdate').data('default',$('#lblXdate').text());
				$('.report').click(function(e){
					switch($('#q_report').data('info').radioIndex){
						case 2: //客戶請款單
                            $('#lblXdate').text('帳款日期');
                            break;
                        default:
                        	$('#lblXdate').text($('#lblXdate').data('default'));
                        	break;
					}	
				});
				 
				
				
			}

			function q_boxClose(s2) {
			}

			

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<div>
  <div id="q_acDiv"></div>
  <input type="button" id="btnOk"  onMouseOver="this.style.cursor='hand'"  alt=""  style=' font-size: 16px; font-weight:bold;color:blue'/>
  <input id="btnTop" type="button" onclick="q_topPage()"  style="background:url(../image/first_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnPrev" type="button" onclick="q_prevPage()"  style="background:url(../image/prev_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnNext" type="button" onclick="q_nextPage()"  style="background:url(../image/next_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnBott" type="button" onclick="q_bottPage()"  style="background:url(../image/bott_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="txtPageno" value="1" type="text" style=" margin-top: 5px; text-align: center;top:1px; left:110px; width: 45px;"/>
  <label style=" vertical-align: middle;position:inherit; left:165px">/</label>
  <input id="txtEnd" value="XXXX" type="text" style=" vertical-align: middle ;text-align: center; top:1px; left:175px; width: 45px;"/>
  <input id="txtTotpage" value="1" type="hidden"/>
  <input id="txtHtmfile" value="" type="hidden"/>
  <input id="txtUrl2" value="" type="hidden"/>
  <input id="btnPrint" type="button" style="background:url(../image/print_32.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="chkXlsHead" value="" type="checkbox" />
  <input id="btnXls" type="button" style="background:url(../image/excel.jpg) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
    <a id='lblPageRange'></a>
  <input id="txtPageRange" type="text" style='width:40px;'/>
  <input id="btnWebPrint" type="button" style="font-size: medium;color: #0000FF;" value=""/>
  <select id="cmbPcPrinter" style='width:220px;'></select>
  <input id="btnAuthority" type="button"  style="font-size: medium;" />
  <input id="txtUrl" value="" type="text" style='width:70px;'/>
  <input id="btnClose" type="button" onclick=""  style="background:url(../image/colose_32r.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <!--<a id='lblPaperSize'></a><a id='lblLandScape'></a>-->
  <select id="cmbPaperSize" style='width:80px;visibility:hidden;'></select>
  <input id="chkLandScape" value="" type="checkbox" style='width:80px;visibility:hidden;'/>
  <div id="frameReport"  style="visibility:visible;top: 35px; left: 0px; height: 100% ; width: 100%; border-top-color:Red; border-top-style:groove;" />
</div>
			</div>
		</div>
	</body>
</html>

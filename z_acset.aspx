﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">

		    $(document).ready(function () {
		        _q_boxClose();

		        q_getId();
		        
		        q_gf('', 'z_acset');

		        $('#btnOk').click(function () {

		            var t_edate = $('#txtEdate').val();
		            t_edate = t_edate.length == 0 ? '12/31' : t_edate;

		            var t_detail = $('#chkDetail')[0].checked;
		            t_detail = (t_detail ? 1 : 0);

		            var t_allYear = $('#chkYear')[0].checked;
		            t_allYear = (t_allYear ? 1 : 0);

		            var t_part = $('#combPart').val();

		            var t_where = r_accy + ';' + r_cno + ';' + t_edate + ';' + t_part + ';' + t_detail + ';' + t_allYear;
		            var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + q_date().substr(0, r_len) + ",edate=" + t_edate + (r_len == 3 ? '&nbsp;&nbsp;' : '') + ",r_cno=" + r_cno + ",r_part=" + t_part;

		            q_gtx("z_acset1", t_where + ";;" + t_para + ";;z_acset;;" + q_getMsg('qTitle'));
		        });
		    });
		    function q_gfPost() {
		        $('#txtBdate').mask(r_picd);
		        $('#txtEdate').mask(r_picd);


		        var year = q_date().substr(0, r_len);
		        var month = q_cdn( q_date(), -35).substr(r_len+1, 2);
		        var s1 = getLastDay(year, month);

		        $('#txtBdate').val(s1);
		        $('#txtEdate').val(s1);

                q_popAssign();
		        //q_gt('acpart','', 0, 0, 0, "", r_accy+'_'+r_cno);
		        q_gt('ssspart',"where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "", r_accy+'_'+r_cno);
		        
		        fbbm = q_getField('tbbm');
		        $('#tbbm td').children("input:text").each(function () { $(this).bind('keydown', function (event) { keypress_bbm(event, $(this), fbbm, 'btnOk'); }); });
		    }

		    function getLastDay(year, month) {
		        var new_year = parseFloat(year) + ( year.length ==3 ? 1911 : 0);  //取當前的年份
		        var t_month = parseFloat(month) -1 ; // 1=二月
                var new_month = t_month+1; //取下一個月的第一天，方便計算（最後一天不固定）   
                if (t_month > 12)      //如果當前大於12月，則年份轉到下一年   
		        {
		            new_month -= 12;    //月份減   
		            new_year++;      //年份增   
		        }
		        var new_date = new Date(new_year, new_month, 1);        //取當年當月中的第一天
		        var t_date = new Date(new_date.getTime() - 1000 * 60 * 60 * 24);
		        var t_days = t_date.getDate();
                return year + '/' + month + '/' + t_days;  //獲取當月最後一天日期   
		    }   

		    function q_boxClose(t_name) {
		    }
		    var ssspart;
		    function q_gtPost(t_name) {
		    	switch (t_name) {
		    		case 'ssspart':
		    			ssspart = _q_appendData("ssspart","",true);
		    			q_gt('acpart','', 0, 0, 0, "", r_accy+'_'+r_cno);
		    			break;
		            case 'acpart':
		                t_part = "zzz@全部";
						var as = _q_appendData("acpart","",true);
						if(q_getPara('acc.lockPart')=='1' && r_rank<8){
							t_part = "";
							for ( i = 0; i < as.length; i++) {
								if(r_partno==as[i].noa){
									t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
									continue;
								}
								
								for ( j = 0; j < ssspart.length; j++) {
									if(as[i].noa==ssspart[j].partno)
										t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
								}
							}
						}else{
							for ( i = 0; i < as.length; i++) {
								t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
							}
						}
		    	        q_cmbParse("combPart", t_part);
		    	        break;
				}
		    }
		</script>
		
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0' >
			 	<tr>
			 		<td class="td1"><a id='lblAcset' class="lbl" style="font-size: xx-large;font-family: dfkai-sb;" ></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblEdate"></a></td>
               <td class="td2"><input id="txtEdate"   type="text" class="txt c1" /></td> 
            </tr>
            <tr>
               <td class="td1"><a id='lblYear'></a></td>
               <td class="td2"><input id="chkYear" type="checkbox" style=" "/></td> 
            </tr> 
            <tr>
               <td class="td1"><a id='lblDetail'></a></td>
               <td class="td2"><input id="chkDetail" type="checkbox" style=" "/></td> 
            </tr> 
            <tr>
            <td class="td1"><a id='lblPart'></a></td>
               <td class="td2"><select id="combPart" style="width: 60%;"></select></td>
            </tr>
            </table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
		</div>
	</body>
</html>


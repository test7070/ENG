<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
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
		    var t_ducc, t_dmon = '', msg_stkNew='已是最新庫存成本';
		    $(document).ready(function () {
		        _q_boxClose();
		        q_getId();
		        q_gf('', 'z_acbe');

		        $('input:radio[name=gender][value=]').attr('checked', true);
		        $('#btnOk').click(function () {
		            var t_bdate = $('#txtBdate').val();
		            var t_edate = $('#txtEdate').val();
		            t_bdate = t_bdate.length == 0 ? '01/01' : t_bdate;
		            t_edate = t_edate.length == 0 ? '12/31' : t_edate;

		            var t_detail = $('#chkDetail')[0].checked;
		            var t_allProj = $('#chkAllproj')[0].checked;
		            t_detail = (t_detail ? 1 : 0);
		            t_allProj = t_allProj ? 1 : 0;
		            var proj = $('#combProj').val();
		            var t_proj = (proj == 'zzz' ? '' : document.getElementById('combProj')[document.getElementById('combProj').selectedIndex].outerText);
		            var t_emon = '';

		            var style2 = $('input:radio:checked[name="gender"]').val();

		            if (t_allProj == 0 && style2.length > 0) { // style2
		                t_allProj = '2';
		                t_emon = t_edate.substr(r_len + 1, 2);
		            }

		            var t_where = r_accy + ';' + r_cno + ';' + t_bdate + ';' + t_edate + ';' + $('#combPart').val() + ';' + proj + ';' + t_detail + ';' + t_allProj;
		            var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + q_date().substr(0, r_len) + ",bdate=" + t_bdate + ",edate=" + t_edate + (r_len == 3 ? '&nbsp;&nbsp;' : '') + ",emon=" + t_emon + ",r_cno=" + r_cno + ",r_proj=" + t_proj;
		            if (style2 == '12')
		                q_gtx("z_acbe12", t_where + ";;" + t_para + ";;z_acbe;;" + q_getMsg('qTitle'));
		            else if (style2 == 'u12')
		                q_gtx("z_acbeu12", t_where + ";;" + t_para + ";;z_acbe;;" + q_getMsg('qTitle'));
		            else
		                q_gtx("z_acbe1", t_where + ";;" + t_para + ";;z_acbe;;" + q_getMsg('qTitle'));
		        });

		        $('#btnDucc').hide();
		        $('#btnDucc').click(function () {
		            q_func('z_acbe.ca_ucc_mon', t_dmon + ',' + q_date().substr(0, r_lenm));
		            $('#btnDucc').val('庫存成本計算中.....');
		            $('#btnDucc').attr('disabled', 'disabled');
		        });
		    });

		    function q_funcPost(t_func, result) {
		        if (result.substr(0, 5) == '<Data') {
		            var Asss = _q_appendData('sss', '', true);
		        } else {
		            $('#btnDucc').val(msg_stkNew);
		        }
		    }

		    function q_gfPost() {
		        $('#txtBdate').mask(r_picd);
		        $('#txtEdate').mask(r_picd);

		        var year = q_date().substr(0, r_len);
		        var month = q_cdn(q_date(), -35).substr(r_len + 1, 2);
		        var s1 = getLastDay(year, month);

		        $('#txtBdate').val(year+'/01/01');
		        $('#txtEdate').val(s1);

		            q_popAssign();
		            q_gt('ssspart',"where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "", r_accy+'_'+r_cno);
		            //q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
		            q_gt('proj', '', 0, 0, 0, "", '');

		            fbbm = q_getField('tbbm');
		            $('#tbbm td').children("input:text").each(function () { $(this).bind('keydown', function (event) { keypress_bbm(event, $(this), fbbm, 'btnOk'); }); });
		            //t_ducc = q_getPara('acc.ducc');
		            var sys_proj = q_getPara('accc.proj');
		            if (sys_proj == 1)
		                $('.proj').show();
		            else
		                $('.proj').hide();

		            //if (t_ducc == '1') {
		            //    q_gt('ducc', '');
		            //    $('#btnDucc').show();
		            //}
		            //else
		            //    $('#btnDucc').hide();
		    }
		    function getLastDay(year, month) {
		        var new_year = parseFloat(year) + (year.length == 3 ? 1911 : 0);  //取當前的年份
		        var t_month = parseFloat(month) - 1; // 1=二月
		        var new_month = t_month + 1; //取下一個月的第一天，方便計算（最後一天不固定）   
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
		        var as;
                switch (t_name) {
		    	    case 'ducc':
		    	        var s1 = q_getMsg2('btnDucc', r_lang);
		    	        as = _q_appendData('ducc', '', true);
		    	        if (as.length > 0) {
		    	            t_dmon = as[0].mon;
		    	            $('#btnDucc').val(s1 + t_dmon + '～' + q_date().substr(0, r_lenm));
		    	        }
		    	        else {
		    	            $('#btnDucc').val(msg_stkNew);
		    	            $('#btnDucc').attr('disabled', 'disabled');
		    	        }
		    	        break;
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
		            case 'proj':
		                t_part = "zzz@全部";
		                as = _q_appendData("proj", "", true);
		                for (i = 0; i < as.length; i++) {
		                    t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].proj;
		                }
		                q_cmbParse("combProj", t_part);
		                break;
				}
		    }
		</script>
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			 <div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0' >
			 	<tr>
			 		 <td class="td1"><a id='lblAcbe' class="lbl" style="font-size: xx-large;font-family:dfkai-sb;"></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblBdate"></a></td>
               <td class="td2"><input id="txtBdate"   type="text" style='width: 35%;'/><a id="lblSymbol" style="width: 10%;"></a>
               	<input id="txtEdate"   type="text" style='width: 35%;'/>
               </td>
               <td class="td3"><a id='lblYear'></a></td>
               <td class="td4"><input id="chkYear" type="checkbox" style=" "/></td>
               </tr>
           <tr>
               <td class="td1"><a id='lblPart'></a></td>
               <td class="td2"><select id="combPart" style="width: 35%;" ></select></td>
               <td class="td3"><a id='lblDetail'></a></td>
               <td class="td4"><input id="chkDetail" type="checkbox" style=" "/></td>  
               <td class="td5"><input class="btn"  id="btnDucc" type="button" value=''  /></td> 
            </tr>  
            <tr class="proj">
               <td class="proj"><a id='lblProj'></a></td>
               <td class="proj"><select id="combProj" style="width: 35%;" ></select></td>
               <td class="proj"><a id='lblAllproj'></a><input id="chkAllproj" type="checkbox" style=" "/></td>  
            </tr> 
            <tr class="style2">
               <td class="style2"></td>
               <td class="style2">
               <td class="style2"></td>
               <td>
                 <input type="radio" name="gender" value="" checked>格式一&nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="radio" name="gender" value="2" checked>格式二&nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="radio" name="gender" value="12">1-12月&nbsp;&nbsp;&nbsp;&nbsp;
                 <input type="radio" name="gender" value="u12">預估+實際1-12月</td>
            </tr> 

            </table>
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
           
          


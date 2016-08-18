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

		        q_getId();
		        q_gf('', 'z_acbe2');


		        $('#btnOk').click(function () {
		            var t_byear = $('#txtByear').val();
		            var t_eyear = $('#txtEyear').val();
		            var t_part1 = $('#combPart1').val();
		            var t_part2 = $('#combPart2').val();

		            var t_bmon1 = $('#txtBmon1').val();
		            var t_emon1 = $('#txtEmon1').val();

		            var t_bmon2 = $('#txtBmon2').val();
		            var t_emon2 = $('#txtEmon2').val();

		            var part1 = $('#combPart1').val();
		            var t_part1 = (part1 == 'zzz' ? '' : document.getElementById('combPart1')[document.getElementById('combPart1').selectedIndex].outerText);

		            var proj1 = $('#combProj1').val();
		            var t_proj1 = (proj1 == 'zzz' ? '' : document.getElementById('combProj1')[document.getElementById('combProj1').selectedIndex].outerText);

		            var part2 = $('#combPart2').val();
		            var t_part2 = (part2 == 'zzz' ? '' : document.getElementById('combPart2')[document.getElementById('combPart2').selectedIndex].outerText);

		            var proj2 = $('#combProj2').val();
		            var t_proj2 = (proj2 == 'zzz' ? '' : document.getElementById('combProj2')[document.getElementById('combProj2').selectedIndex].outerText);

		            var t_detail = $('#chkDetail')[0].checked;
		            t_detail = (t_detail ? 1 : 0);

		        
			var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + q_date().substr(0, r_len)+ ",r_cno=" + r_cno + ",year1=" + t_byear + ",bmon1=" + t_bmon1 + ",bmon2=" + t_bmon2 + ",part1=" + t_part1 + ",proj1=" + t_proj1 + ",year2=" + t_eyear + ",emon1=" + t_emon1 + ",emon2=" + t_emon2 + ",part2=" + t_part2 + ",proj2=" + t_proj2;			
			if( r_len==4)
			{
				t_byear= padL("" + (parseFloat(t_byear) - 1911), "0", 3);
				t_eyear= padL("" + (parseFloat(t_eyear) - 1911), "0", 3);
			}
    
			var t_where = r_accy + ';' + r_cno + ';' + t_byear + ';' + t_bmon1 + ';' + t_emon1 + ';' + part1 + ';' + proj1 + ';' + t_eyear + ';' + t_bmon2 + ';' + t_emon2 + ';' + part2 + ';' + proj2 + ';' + t_detail;

		            //ret = qExec.z_acbe2a("101", "1", "101", "01", "12", "", "101", "01", "12", "", "0");  /// z_acbe2
		            

		            q_gtx("z_acbe2a", t_where + ";;" + t_para + ";;z_acbe2;;" + q_getMsg('qTitle'));
		        });
		    });
		    function q_gfPost() {
		        q_popAssign();
		        //q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
		        q_gt('ssspart',"where=^^ noa='"+r_userno+"' ^^", 0, 0, 0, "", r_accy+'_'+r_cno);
		        q_gt('proj', '', 0, 0, 0, "", '');

		        t_accy = q_date().substr( 0,r_len);
			$('#txtByear').val( parseFloat( t_accy)-1);
		        $('#txtEyear').val(t_accy);
		        $('#txtBmon1').val('01');
		        $('#txtEmon1').val('12');
		        $('#txtBmon2').val('01');
		        $('#txtEmon2').val('12');

		        var sys_proj = q_getPara('accc.proj');
		        if (sys_proj == 1)
		            $('.proj').show();
		        else
		            $('.proj').hide();
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
		                q_cmbParse("combPart1", t_part);
		                q_cmbParse("combPart2", t_part);
		                break;
		            case 'proj':
		                t_part = "zzz@全部";
		                var as = _q_appendData("proj", "", true);
		                for (i = 0; i < as.length; i++) {
		                    t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].proj;
		                }
		                q_cmbParse("combProj1", t_part);
		                q_cmbParse("combProj2", t_part);
		                break;
		        }
		    }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0'>
			 	<tr>
			 		 <td class="td1"><a id='lblAcbe2' class="lbl" style="font-size: xx-large;font-family:dfkai-sb;"></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblByear"></a></td>
               <td class="td2"  style='width: 70px;'><input id="txtByear"   type="text"  style='width: 50px;'/></td>
               <td class="td3" ><a id="lblBmon1"></a></td>
               <td class="td4"><input id="txtBmon1"   type="text" style='width: 50px;'/>～
               	<input id="txtEmon1"   type="text" style='width: 50px;'/>
               </td>
               <td class="td5" style='width: 150px;'><a id='lblPart1'></a> <select id="combPart1" style="width: 90px;" value=" "></select></td> 
               <td class="proj" style='width:150px;'><a id='lblProj1'></a> <select id="combProj1" style="width: 90px;" value=" "></select></td> 
            </tr> 
           <tr>
               <td class="td1"><a id="lblEyear"></a></td>
               <td class="td2" style='width: 70px;'><input id="txtEyear"   type="text" style='width: 50px;'/></td>
               <td class="td3"><a id="lblBmon2"></a></td>
               <td class="td4"><input id="txtBmon2"   type="text" style='width: 50px;'/>～
               	<input id="txtEmon2"   type="text" style='width: 50px;'/>
               </td>
               <td class="td5"style='width: 150px;'><a id='lblPart2'></a> <select id="combPart2" style="width: 90px;" value=" "></select></td> 
               <td class="proj"style='width: 150px;'><a id='lblProj2'></a> <select id="combProj2" style="width: 90px;" value=" "></select></td> 
               <td class="td8"><a id='lblDetail'></a><input id="chkDetail" type="checkbox" style=" "/></td>  
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
           
          




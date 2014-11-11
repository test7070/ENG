<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc=1;
			q_tables = 's';
			var q_name = "cont";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtApv', 'txtWorker2'];
			var q_readonlys = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [['txtMount',10,2,1],['txtWeight',10,2,1],['txtPrice',10,3,1]
						 ];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
							, ['txtTggno', 'lblTgg', 'custtgg', 'noa,comp,nick,conn', 'txtTggno,txtComp,txtNick', 'custtgg_b.aspx']
							, ['txtSales', 'lblSales', 'sss', 'namea,noa', 'txtSales,txtSalesno', 'sss_b.aspx']
							, ['txtAssigner', 'lblAssigner', 'sss', 'namea,noa', 'txtAssigner,txtAssignerno', 'sss_b.aspx']
							, ['txtAssistant', 'lblAssistant', 'sss', 'namea,noa', 'txtAssistant,txtAssistantno', 'sss_b.aspx']
							, ['txtBankno', 'lblBankno', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']
							, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style','',0,0,0,'');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '');
			});
			
			function sum(){
				for(var i=0;i<q_bbsCount;i++){
					t_unit = $('#txtUnit_'+i).val().toUpperCase();
					t_total = round(q_mul((t_unit=='公斤' || t_unit=='KG' || t_unit.length==0 ?q_float('txtWeight_'+i) : q_float('txtMount_'+i)),q_float('txtPrice_'+i)),0);
					$('#txtTotal_'+i).val(t_total)
				}
			};
			
			//////////////////   end Ready
			function main() {
				if(dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}
			function mainPost() {
				q_getFormat();
				q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
				bbmMask = [['txtEnddate', r_picd],['txtDatea', r_picd], ['txtPledgedate', r_picd], ['txtPaydate', r_picd], ['txtBcontdate', r_picd], ['txtEcontdate', r_picd], ['txtChangecontdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbEnsuretype", ('').concat(new Array('', '定存單質押', '不可撤銷保證', '銀行本票質押', '商業本票質押', '現金質押')));
				q_cmbParse("cmbEtype", ('').concat(new Array('','存入', '存出')));
				q_gt('acomp', '', 0, 0, 0, "");
				$('#btnConn_cust').click(function() {
					t_where = "noa='" + $('#txtTggno').val() + "'";
					q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Conn_cust', "95%", "650px", q_getMsg('lblConn'));
				});
				$('#lblStype').click(function(e) {
					q_box("conttype.aspx", 'conttype', "90%", "600px", q_getMsg("popConttype"));
				});

				$('#lblCust2').click(function(e) {
					q_box("cust_b2.aspx", 'cust', "90%", "600px", q_getMsg("popCust"));
				});
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'conttype':
						location.href = (location.origin == undefined ? '' : location.origin) + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";;" + r_accy;
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'acomp':
						var as = _q_appendData("acomp", "", true);
						var t_item = " @ ";
						var t_item2 = " @ ";
						 for ( i = 0; i < as.length; i++) {
						 	t_item2 = t_item2 + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
						 	t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
						 }
						 q_cmbParse("cmbCno", t_item);
						 q_cmbParse("cmbCnonick", t_item2);
						 q_cmbParse("cmbGuarantorno", t_item);
						 if(abbm[q_recno]){
						 	$("#cmbCno").val(abbm[q_recno].cno);
						 	$("#cmbCnonick").val(abbm[q_recno].cno);
						 	$("#cmbGuarantorno").val(abbm[q_recno].guarantorno);
						 }
						break;
					case 'style' :
							var as = _q_appendData("style", "", true);
							StyleList = new Array();
							StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if(t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtAcomp').val($('#cmbCno').find(":selected").text());
				$('#cmbCnonick').val($('#cmbCno').val());
				$('#txtAcompnick').val($('#cmbCnonick').find(":selected").text());
				$('#txtGuarantor').val($('#cmbGuarantorno').find(":selected").text());
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_contst') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if(q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('quat_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						
						$('#txtMount_' + j).change(function () {
							sum();
						});
						$('#txtPrice_' + j).change(function () {
							sum();
						});
						$('#txtWeight_' + j).change(function () {
							sum();
						});
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
						//-------------------------------------------------------------------------------------
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtTggno').focus();
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtTggno').focus();
			}

			function btnPrint() {
				q_box("z_contfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cont', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if(!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		                	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
						});
                        if(trim($('#txtStyle_' + b_seq).val()).length != 0)
                        	ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
					break;
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script> 
	<style type="text/css">
		.dview {
			float: left;
			width: 28%;
		}	
		.tview {
			margin: 0;
			padding: 2px;
			border: 1px black double;
			border-spacing: 0;
			font-size: medium;
			background-color: #FFFF66;
			color: blue;
			width: 100%;
		}
		.tview td {
			padding: 2px;
			text-align: center;
			border: 1px black solid;
		}
		.dbbm {
			float: left;
			width: 70%;
			margin: -1px;
			border: 1px black solid;
			border-radius: 5px;
		}
		.tbbm {
			padding: 0px;
			border: 1px white double;
			border-spacing: 0;
			border-collapse: collapse;
			font-size: medium;
			color: blue;
			background: #cad3ff;
			width: 100%;
		}
		.tbbm tr {
			height: 35px;
		}
		.tbbm tr td {
			width: 9%;
		}
		.tbbm .tdZ {
			width: 2%;
		}
		.tbbm tr td span {
			float: right;
			display: block;
			width: 5px;
			height: 10px;
		}
		.tbbm tr td .lbl {
			float: right;
			color: blue;
			font-size: medium;
		}
		.tbbm tr td .lbl.btn {
			color: #4297D7;
			font-weight: bolder;
			font-size: medium;
		}
		.tbbm tr td .lbl.btn:hover {
			color: #FF8F19;
		}
		.txt.c1 {
			width: 98%;
			float: left;
		}
		.txt.c6 {
			width: 85%;
			text-align:center;
		}
		.txt.c7 {
			width: 95%;
			float: left;
		}
		.txt.c8 {
			float:left;
			width: 65px;
		}
		.txt.num {
			text-align: right;
		}
		.tbbm td {
			margin: 0 -1px;
			padding: 0;
		}
		.tbbm td input[type="text"] {
			border-width: 1px;
			padding: 0px;
			margin: -1px;
			float: left;
		}
		.tbbm td input[type="button"] {
			float: left;
		}
		.tbbm select {
			border-width: 1px;
			padding: 0px;
			margin: -1px;
			font-size:medium;
		}
		.dbbs {
			float:left;
			width: 100%;
		}
		.tbbs a {
			font-size: medium;
		}
		.num {
			text-align: right;
		}
		.tbbs tr.error input[type="text"] {
			color: red;
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.trX{
			background: pink;
		}
		.trTitle{
			padding-left: 18px;
			font-size: 18px;
			font-weight: bolder;
			color: brown;
			letter-spacing: 5px;
		}
</style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
	<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewEcontdate'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
						<td align="center" id='econtdate'>~econtdate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input id="txtEnddate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtAcomp"  type="text" class="txt" style="width:70%; float: left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%; float: left;"/>
							<input id="txtNick"  type="text" style="display: none;"/>
						</td>
						<td><input id="btnConn_cust" type="button" /></td>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProj' class="lbl"> </a></td>
						<td colspan="2"><input id="txtProj" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblSite' class="lbl"> </a></td>
						<td colspan="2"><input id="txtSite" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblChktype' class="lbl"> </a></td>
						<td><input id="txtChktype" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id='lblBcontdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtBcontdate" type="text"  class="txt c1"/></td>
						<td align="center"><a id="lblEcontdate"> </a></td>
						<td class="td6"><input id="txtEcontdate" type="text"  class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblChangecontdate' class="lbl"> </a></td>
						<td class="td8"><input id="txtChangecontdate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblContitem' class="lbl"> </a></td>
						<td class="td2" colspan="7"><input id="txtContitem" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<select id="cmbCnonick" class="txt c1" style="display:none;"> </select>
							<input id="txtAcomp"  type="hidden" class="txt" style="width:80%; float: left;"/>
							<input id="txtAcompnick"  type="hidden" style="display: none;"/>
						</td>
						<td ><span> </span><a id="lblGuarantor" class="lbl"> </a></td>
						<td  colspan="3">
							<select id="cmbGuarantorno" class="txt c1"> </select>
							<input id="txtGuarantor"  type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td>
							<input id="txtSalesno" type="text" class="txt" style="display: none;"/>
							<input id="txtSales" type="text" class="txt c1">
						</td>
						<td><span> </span><a id='lblAssigner' class="lbl btn"> </a></td>
						<td>
							<input id="txtAssignerno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssigner" type="text" class="txt c1">
						</td>
						<td><span> </span><a id="lblAssistant" class="lbl btn"> </a></td>
						<td>
							<input id="txtAssistantno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssistant" type="text" class="txt c1">
						</td>
					</tr>
					<tr>
						<td colspan="8" class="trX"><span> </span><a class="trTitle">保證金</a></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblEtype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEtype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEnsuretype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEnsuretype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEarnest' class="lbl"> </a></td>
						<td class="trX"><input id="txtEarnest" type="text"  class="txt c1 num"/></td>
						<td class="trX" colspan="2"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id="lblBankno_st" class="lbl btn"> </a></td>
						<td class="trX" colspan="3">
							<input id="txtBankno" type="text" style="width:30%; float: left;"/>
							<input id="txtBank"  type="text"  style="width:70%; float: left;"/>
						</td>
						<td class="trX"><span> </span><a id='lblCheckno_st' class="lbl"> </a></td>
						<td class="trX" colspan="3"><input id="txtCheckno" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblPledgedate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPledgedate" type="text"  class="txt c1"/></td>
						<td class="trX"><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPaydate" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo" rows="5" cols="10" type="text" class="txt c1"></textarea></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td class="td1"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker2"  type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblApv' class="lbl"> </a></td>
						<td class="td4"><input id="txtApv"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEnda' class="lbl"> </a></td>
						<td><input id="chkEnda" type="checkbox"/></td>
					</tr>
				</table>
			</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
				  	<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'>品名</a></td>
					<td align="center" style="width:60px;"><a id='lblUnit_s'>單位</a></td>
					<td align="center" style="width:60px;"><a id='lblLengthb_s'>單支長</a></td>
					<td align="center" style="width:60px;"><a id='lblMount_s'>數量</a></td>
					<td align="center" style="width:60px;"><a id='lblWeight_s'>重量</a></td>
					<td align="center" style="width:60px;"><a id='lblPrice_s'>單價</a></td>
					<td align="center" style="width:60px;"><a id='lblTotal_s'>小計</a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'>備註</a></td>
					<td align="center" style="width:50px;"><a id='lblEnda_s'>結案</a></td>
					<td align="center" style="width:70px;">議價記錄1</td>
					<td align="center" style="width:70px;">議價記錄2</td>
					<td align="center" style="width:70px;">議價記錄3</td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtNoq.*"  style="display: none;"/>
						<input type="text" id="txtProductno.*"  style="width:45%; float:left;"/>
						<input id="txtProduct.*" type="text" class="txt"style="width:45%; float:left;"/>
						<input class="btn"  id="btnProduct.*" type="button" style="display: none;" />
					</td> 
					<td ><input id="txtUnit.*" type="text"  class="txt c7"/></td>
					<td ><input id="txtLengthb.*" type="text"  class="txt num c7"/></td>
					<td ><input id="txtMount.*" type="text"  class="txt num c7"/></td>
					<td ><input id="txtWeight.*" type="text"  class="txt num c7" /></td>
					<td ><input id="txtPrice.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtTotal.*" type="text" class="txt num c7" /></td>
					<td><input id="txtMemo.*" type="text" class="txt c7"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td ><input id="txtGweight.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtOrdgweight.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtOrdeweight.*" type="text" class="txt num c7" /></td>
				</tr>
			</table>
		</div>
	</div>
	<input id="q_sys" type="hidden" />
	</body>
</html>
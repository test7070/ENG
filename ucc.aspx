<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var decbbm = [];
			var q_name = "ucc";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array();

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
				$('#txtNoa').focus();
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				$('#txtNoa').focus();
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [];
				q_mask(bbmMask);
				
				$('#txtNoa').change(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa='" + thisVal + "' ^^";
						Lock();
						q_gt('ucc', t_where, 0, 0, 0, "checkNoa", r_accy);
					}
				});
			}
			
			var xy_newnoa=''; 

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///	q_boxClose 3/4
						break;
				}	/// end Switch
				b_pop='';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkNoa':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').focus();
						}
						Unlock();
						break;
					case 'btnOk_checkNoa':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').val('').focus();
						}else{
							var t_noa = trim($('#txtNoa').val());
							if (t_noa.length != 0)
								wrServer(t_noa);
						}
						Unlock();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}	/// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('ucc_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm
				$('#txtProduct').focus();
			}

			function btnPrint() {

			}

			function btnOk() {
				var t_noa = trim($('#txtNoa').val());
				if(t_noa.length==0){
					alert('請輸入物品編號!!');
					return;
				}
				
				if(t_noa.length > 0 && q_cur==1){
					var t_where = "where=^^ noa='" + t_noa + "' ^^";
					Lock();
					q_gt('ucc', t_where, 0, 0, 0, "btnOk_checkNoa", r_accy);
					return;
				}
				
				if (t_noa.length == 0)
					q_gtnoa(q_name, t_noa);
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			var imagename='';
			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}
			
			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				refreshBbm();
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
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
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
				}
			}
			
		</script>
		<style type="text/css">
			.tview {
				FONT-SIZE: 12pt;
				COLOR: Blue;
				background: #FFCC00;
				padding: 3px;
				TEXT-ALIGN: center;
			}
			.tbbm {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				border-color: white;
				width: 800px;
				border-collapse: collapse;
				background: #cad3ff;
			}
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 95%;
			}
			.txt.c3 {
				width: 70%;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.lbl{
				float: right;
				font-size: medium;
			}
			.tbbm tr td {
				/*width: 10%;*/
			}
			.tbbm tr {
				height: 35px;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;	width:32%;"	>
			<table class="tview" id="tview"	border="1" cellpadding='2'	cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:2%"><a id='vewChk'> </a></td>
					<td align="center" style="width:15%"><a id='vewNoa'> </a></td>
					<td align="center" style="width:25%"><a id='vewProduct'> </a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="left" id='noa'>~noa</td>
					<td align="left" id='product'>~product</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float: left;">
			<table class="tbbm"	id="tbbm"	border="0" cellpadding='2'	cellspacing='0'>
				<tr style="height: 1px;">
					<td style="width: 20%;"> </td>
					<td style="width: 10%;"> </td>
					<td style="width: 15%;"> </td>
					<td style="width: 40%;"> </td>
					<td style="width: 20%;"> </td>
				</tr>
				<tr>
					<td><a id='lblNoa' class="lbl"> </a></td>
					<td colspan="2"><input type="text" id="txtNoa" class="txt c1"/></td>
				</tr>
				<tr> 
					<td><a id='lblProduct' class="lbl"> </a></td>
					<td colspan='3'><input	type="text" id="txtProduct" class="txt c1"/></td>
				</tr>
				<tr>
					<td><a id='lblUnit' class="lbl"> </a></td>
					<td><input	type="text" id="txtUnit" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
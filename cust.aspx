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

			var q_name = "cust";
			var q_readonly = ['txtWorker', 'txtKdate', 'txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3'];
			var bbmNum = [['txtCredit', 10, 0, 1],['textTranprice', 10, 0, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
				['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx'],
				['txtCustno2', 'lblCustno2', 'cust', 'noa,comp', 'txtCustno2,txtCust2', 'cust_b.aspx'],
				['txtXyNoa1', '', 'cust', 'noa,comp', '0txtXyNoa1,txtXyComp1,txtXyComp2', 'cust_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				xmlTable = 'conn';
				xmlKey = [['noa', 'noq']];
				xmlDec = [];
				q_popSave(xmlTable);
				// for conn_b.aspx
				q_brwCount();
				var t_where = "where=^^ noa='" + r_userno + "' ^^";
				q_gt('sss', t_where, 0, 0, 0, "", r_accy);
				$('#txtNoa').focus();
			});
			function currentData() {
			}

			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : ['txtUacc1', 'txtUacc2', 'txtUacc3'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			////////////////// end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				// 1=Last 0=Top
			}/// end Main()

			function mainPost() {
				bbmMask = [['txtChkdate', r_picd], ['txtDueday', '999'], ['txtStartdate', '99'],['txtGetdate', '99']];
				q_mask(bbmMask);
				
				
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				// q_cmbParse("cmbStatus", q_getPara('cust.status'));

				//後面有需要的公司在顯示
				$('.btnUcam').hide();// 嘜頭
				$('#btnCustm').hide();//稅務資料
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#btnCustm').show();
				}

				$('#btnUcam').click(function() {
					t_where = "custno='" + $('#txtNoa').val() + "'";
					q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "95%", "95%", q_getMsg('btnUcam'));
				});
				
				$('#btnConn').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
					}
				});
				
				$('#btnCustm').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						t_where = "noa='" + $('#txtNoa').val() + "'";
						if (q_getPara('sys.project').toUpperCase()=='XY'){
							q_box("custm_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custm', "600px", "700px", q_getMsg('btnCustm'));
						}
					}
				});
				
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				
				$('#txtUacc4').change(function() {
					var s1 = trim($(this).val());
					if (s1.length > 4 && s1.indexOf('.') < 0)
						$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
					if (s1.length == 4)
						$(this).val(s1 + '.');

				});
				
				$('#btnUsecrd').click(function(){
					var t_custno = $.trim($('#txtNoa').val());
					if((t_custno.length > 0) && (t_custno.toUpperCase() != 'AUTO')){
						var t_where = "noa='" + t_custno + "'";
						q_box("usecrd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'usecrd', "95%", "450px", q_getMsg('btnUsecrd'));
					}
				});
				
				$('#txtXyNoa1').click(function(){
					if (q_cur==1 )
						q_msg($('#txtXyNoa1'), "請輸入客戶拼音前兩碼或客戶總店編號");
				});
				
				$('#txtXyNoa2').click(function(){
					if (q_cur==1)
						q_msg($('#txtXyNoa2'), "請輸入客戶分店編號或流水號(空白)");
				});
				
				$('#txtXyComp1').change(function(){
					if (q_cur==1 && $('#txtXyNoa1').val().length<=2 && $('#txtXyComp1').val().length>0){
						//讀羅馬拼音
						var t_where = "where=^^ ['"+$('#txtXyComp1').val() +"')  ^^";
						q_gt('cust_xy', t_where, 0, 0, 0, "XY_cust_getpy", r_accy);
					}
				});
				
				/*$('#btnTmpcustno_xy').click(function(){
					xy_newnoa='';
					//讀羅馬拼音>產生最新編號>最後更換noa
					var t_where = "where=^^ ['"+$('#txtComp').val() +"')  ^^";
					q_gt('cust_xy', t_where, 0, 0, 0, "XY_newcust_getpy", r_accy);
				});*/
				
			}
			
			var xy_newnoa=''; 
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkCustno_change':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
						}
						break;
					case 'checkCustno_btnOk':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case 'sss':
						var as = _q_appendData("sss", "", true);
						if (as[0] == undefined || (as[0].issales == 'false') || (as[0].issales == false)) {
							q_gt(q_name, q_content, q_sqlCount, 1);
						} else {
							q_content = "where=^^ salesno='" + r_userno + "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1);
						}
						break;
					case 'XY_cust_getpy':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var tmp=as[0].Column1;
							//排除特殊字元
							tmp=replaceAll(as[0].Column1,"'","");
							tmp=replaceAll(as[0].Column1," ","");
							tmp=replaceAll(as[0].Column1,".","");
							tmp=replaceAll(as[0].Column1,"(","");
							tmp=replaceAll(as[0].Column1,"+","");
							tmp=replaceAll(as[0].Column1,"-","");
							tmp=replaceAll(as[0].Column1,"*","");
							tmp=replaceAll(as[0].Column1,"/","");
							tmp=replaceAll(as[0].Column1,"~","");
							tmp=replaceAll(as[0].Column1,"!","");
							tmp=replaceAll(as[0].Column1,"@","");
							tmp=replaceAll(as[0].Column1,"#","");
							tmp=replaceAll(as[0].Column1,"$","");
							tmp=replaceAll(as[0].Column1,"%","");
							tmp=replaceAll(as[0].Column1,"^","");
							tmp=replaceAll(as[0].Column1,"&","");
							
							if(tmp.length==1)
								tmp=tmp+'Z';
							
							$('#txtXyNoa1').val(tmp.substr(0,2));
						}
						break;
					/*case 'XY_newcust_getpy':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							xy_newnoa=as[0].Column1.substr(0,2);
							//讀取最新的流水號
							t_where = "where=^^ charindex('" + xy_newnoa + "',noa)=1 and len(noa)<=5 ^^";
							q_gt('cust', t_where, 0, 0, 0, "XY_newcust_Autonumber", r_accy);
						}else{
							alert('轉正式客戶資料錯誤請通知工程師維護!!');
						}
						break;
					case 'XY_newcust_Autonumber':
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var noa_seq=('000'+((isNaN(dec(as[as.length-1].noa.substr(-3)))?0:dec(as[as.length-1].noa.substr(-3)))+1)).substr(-3);
							xy_newnoa=xy_newnoa+noa_seq;
						}else{
							xy_newnoa=xy_newnoa+'001';
						}
						//更換noa
						if(!emp($('#txtNoa').val()) && $('#txtNoa').val().substr(0,2)=='##'){
							var t_paras = $('#txtNoa').val()+ ';'+xy_newnoa;
							q_func('qtxt.query.change_tmpcustno', 'cust_ucc_xy.txt,change_tmpcustno,' + t_paras);
							$('#btnTmpcustno_xy').attr('disabled', 'disabled');
						}
						break;*/
					case 'XY_AutoCustno1'://總店流水號 沒有分店
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var noa_seq=('000'+((isNaN(dec(as[as.length-1].noa.substr(-3)))?0:dec(as[as.length-1].noa.substr(-3)))+1)).substr(-3);
							$('#txtXyNoa1').val($('#txtXyNoa1').val()+noa_seq);
						}else{
							$('#txtXyNoa1').val($('#txtXyNoa1').val()+'001');
						}
						btnOk();
						break;
					case 'XY_AutoCustno2'://總店 分店流水號
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var noa_seq=('000'+((isNaN(dec(as[as.length-1].noa.substr(-3)))?0:dec(as[as.length-1].noa.substr(-3)))+1)).substr(-3);
							$('#txtXyNoa1').val($('#txtXyNoa1').val()+noa_seq);
							$('#txtXyNoa2').val('001');
						}else{
							$('#txtXyNoa1').val($('#txtXyNoa1').val()+'001');
							$('#txtXyNoa2').val('001');
						}
						btnOk();
						break;
					case 'XY_AutoCustno3'://分店流水號
						var as = _q_appendData("cust", "", true);
						if(as[0] != undefined){
							var noa_seq=('000'+((isNaN(dec(as[as.length-1].noa.substr(-3)))?0:dec(as[as.length-1].noa.substr(-3)))+1)).substr(-3);
							$('#txtXyNoa2').val(noa_seq);
						}else{
							$('#txtXyNoa2').val('001');
						}
						btnOk();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				
				$('#txtNoa').focus();
				refreshBbm();
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					var t_noa='',t_comp='',t_comp2='';
					if($('#txtNoa').val()!=''){
						t_noa=$('#txtNoa').val();
						if(t_noa.indexOf('-')>-1 && t_noa.length>5){
							t_comp=$('#txtComp').val().split('-')[0];
							if($('#txtComp').val().indexOf('-')>-1)
								t_comp2=$('#txtComp').val().split('-')[1];	
							t_noa=t_noa.split('-')[0];
						}else{
							t_noa=$('#txtNoa').val();
							t_comp=$('#txtComp').val();
						}
					}
					
					$('#txtNoa').val('').hide();
					$('#txtComp').val('').hide();
					$('#txtXyNoa1').val(t_noa).show();
					$('#txtXyNoa2').val('').show();
					$('#txtXyComp1').val(t_comp).show();
					$('#txtXyComp2').val(t_comp2).show();
					$('#lblXyNoa2').val('').show();
					$('#lblXyComp2').val('').show();
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
			}

			function btnPrint() {
				q_box("z_label.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";cust=" + $('#txtNoa').val() + ";" + r_accy, 'z_label', "95%", "95%", q_getMsg('popZ_label'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}
			
			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if (q_cur==1 && !((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val()))) {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}

				if ($('#txtStartdate').val() > '31') {
					alert(q_getMsg("lblStartdate") + '最大天數為31日');
					Unlock();
					return;
				}
				if ($('#txtGetdate').val() > '31') {
					alert(q_getMsg("lblGetdate") + '最大天數為31日');
					Unlock();
					return;
				}

				if (dec($('#txtCredit').val()) > 9999999999)
					t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

				if (dec($('#txtGetdate').val()) > 31)
					t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r';
					
				if(q_cur==1)
					$('#txtKdate').val(q_date());
					
				$('#txtWorker').val(r_name);
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtConntel').val($('#textConn').val());
					$('#txtBillmemo').val($('#textTrantime').val());
					var t_invomemo=$('#textIsvcc').val()+'##'+$('#textIsinvo').val()+'##'+$('#textIstax').val()+'##'+$('#textCheckvcc').val()+'##'+$('#textIspost').val()+'##'+$('#textTranprice').val();
					$('#txtInvomemo').val(t_invomemo);
				}
				
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
					$('.it').css('text-align', 'left');
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('.isXY').show();
					/*if($('#txtNoa').val().substr(0,2)=='##'){
						$('#btnTmpcustno_xy').show();
					}else{
						$('#btnTmpcustno_xy').hide();
					}*/
				}else{
					$('.isXY').hide();
					//$('#btnTmpcustno_xy').hide();
				}
				
				if (q_getPara('sys.project').toUpperCase()=='FE'){
					$('.isFE').show();
				}else{
					$('.isFE').hide();
				}
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
			}

			var vccitopen = true;
			var xyopen = true;
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				refreshBbm();
				if(t_para){		//普通狀態
					$('#btnConn').removeAttr('disabled');
					$('#btnCustm').removeAttr('disabled');
					$('#combPaytype').attr('disabled','disabled');
				}else{			//新增 修改狀態
					$('#btnConn').attr('disabled', 'disabled');
					$('#btnCustm').attr('disabled', 'disabled');
					$('#combPaytype').removeAttr('disabled');
				}
				$('#combPaytype').css("background",$('#cmbTrantype').css("backgroundColor"));
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

			function returnparent() {
				if ((window.parent.q_name == 'quat' || window.parent.q_name == 'orde' ) && q_getPara('sys.project').toUpperCase()=='XY' && window.parent.q_cur==1) {
					var wParent = window.parent.document;
					wParent.getElementById("txtCustno").value = $('#txtNoa').val();
					wParent.getElementById("txtComp").value = $('#txtComp').val();
					wParent.getElementById("txtNick").value = $('#txtNick').val();
					wParent.getElementById("txtPaytype").value = $('#txtPaytype').val();
					wParent.getElementById("txtTel").value = $('#txtTel').val();
					wParent.getElementById("txtFax").value = $('#txtFax').val();
					wParent.getElementById("cmbTrantype").value = $('#cmbTrantype').val();
					wParent.getElementById("txtPost").value = $('#txtZip_comp').val();
					wParent.getElementById("txtAddr").value = $('#txtAddr_comp').val();
					wParent.getElementById("txtSalesno").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales").value = $('#txtSales').val();
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	/*case 'qtxt.query.change_tmpcustno':
                		$('#btnTmpcustno_xy').removeAttr('disabled');
						alert('已轉正式客戶!!。');
						var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ noa='"+xy_newnoa+"' ^^"
						q_boxClose2(s2);
						xy_newnoa='';
						break;*/
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 38%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.tview tr {
				height: 26px;
			}
			.dbbm {
				float: left;
				width: 60%;
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
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c6 {
				width: 49%;
				float: left;
			}
			.txt.c7 {
				width: 99%;
				float: left;
			}
			.txt.c8 {
				width:60%;
				float:left;
				margin-top:20px;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.btn.conn{
				width: 38%;
				float: right;
				padding: 0px;
			}
		</style>
	</head>
	<body onunload='returnparent()' ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; width:25%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick' class='it'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtXyNoa1" type="text" class="txt c6" style="width:60px;display:none;"/>
							<a id='lblXyNoa2' class="lbl" style="display:none;float: left;"> 分店<span> </span></a>
							<input id="txtXyNoa2" type="text" class="txt c6" style="width:40px;display:none;"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
						<td>
							<div style="float:left;">
								<input id="Copy" type="checkbox" />
								<span> </span><a id="lblCopy"> </a>
							</div>
							<span> </span>
							<a id='lblWorker' class="lbl"> </a>
						</td>
						<td>
							<input id="txtKdate" type="text" class="txt c6"/>
							<input id="txtWorker" type="text" class="txt c6"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan='3'>
							<input id="txtComp" type="text" class="txt c7"/>
							<input id="txtXyComp1" type="text" class="txt c6" style="display:none;"/>
							<a id='lblXyComp2' class="lbl" style="display:none;float: left;">　分店<span> </span></a>
							<input id="txtXyComp2" type="text" class="txt c2" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtboss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblHead' class="lbl"> </a></td>
						<td><input id="txthead" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTeam' class="lbl"> </a></td>
						<td align="center">
							<input id="txtTeam" type="text" class="txt c8"/>
							<input id="btnConn" type="button" class="btn conn"/>
						</td>
						<!-- <td><input id="btnConn" type="button" /></td> -->
						<!-- <td colspan="2">
							<input id="btnConn" type="button" />
							<input id="btnCustm" type="button" />
						</td> -->
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='5'><input id="txtTel" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='3'><input id="txtFax" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td><span> </span><a class="lbl isXY" style="display: none;">連絡人員</a></td>
						<td colspan='3'><input id="textConn" type="text" class="txt c7 isXY "/></td>
						<td><span> </span><a class="lbl isXY" style="display: none;">交貨時間</a></td>
						<td><input id="textTrantime" type="text" class="txt c1 isXY"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvoicetitle' class="lbl"> </a></td>
						<td colspan='3'><input id="txtInvoicetitle" type="text" class="txt c7"/></td>
						<td><input id="btnUcam" type="button" style="float: right;" class="btnUcam" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact' class="lbl"> </a></td>
						<td><input id="txtZip_fact" type="text" class="txt c1"></td>
						<td colspan='4'><input id="txtAddr_fact" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td><input id="txtZip_comp" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_comp" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td><input id="txtZip_invo" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_invo" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td><input id="txtZip_home" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_home" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td colspan='5'><input id="txtEmail" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td class="isFE" colspan="2"><input id="btnUsecrd" type="button"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td>
							<input id="txtSalesno" type="text" class="txt c6"/>
							<input id="txtSales" type="text" class="txt c6"/>
						</td>
						<td colspan="2"></td>
						<td><span> </span><a id='lblUacc1' class="lbl"> </a></td>
						<td><input id="txtUacc1" type="text" class="txt c1"/></td>
<!-- 						<td><span> </span><a id='lblUacc4' class="lbl"> </a></td>
						<td><input id="txtUacc4" type="text" class="txt c1"/></td> -->
					</tr>
					<tr>
						<td><span> </span><a id="lblCredit" class="lbl" > </a></td>
						<td><input id="txtCredit" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblUacc2' class="lbl"> </a></td>
						<td><input id="txtUacc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
<!-- 						<td><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td><input id="txtDueday" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblGetdate' class="lbl"> </a></td>
						<td><input id="txtGetdate" type="text" class="txt c1"/></td> -->
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td>
							<input id="txtPaytype" type="text" class="txt c6"/>
							<select id="combPaytype" class="txt c6" onchange='combPaytype_chg()'> </select>
						</td>
						<td><span> </span><a id='lblUacc3' class="lbl"> </a></td>
						<td><input id="txtUacc3" type="text" class="txt c1"/></td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td><span> </span><a class="lbl isXY" style="display: none;">貨單開立</a></td>
						<td><input id="textIsvcc" type="text" class="txt c1 isXY "/></td>
						<td><span> </span><a class="lbl isXY" style="display: none;">課稅方式</a></td>
						<td><input id="textIstax" type="text" class="txt c1 isXY"/></td>
						<td><span> </span><a class="lbl isXY" style="display: none;">驗單需求</a></td>
						<td><input id="textCheckvcc" type="text" class="txt c1 isXY"/></td>
					</tr>
					<tr class="isXY" style="display: none;">
						<td><span> </span><a class="lbl isXY" style="display: none;">發票開立</a></td>
						<td><input id="textIsinvo" type="text" class="txt c1 isXY"/></td>
						<td><span> </span><a class="lbl isXY" style="display: none;">回郵</a></td>
						<td><input id="textIspost" type="text" class="txt c1 isXY "/></td>
						<td><span> </span><a class="lbl isXY" style="display: none;">運費單價</a></td>
						<td><input id="textTranprice" type="text" class="txt num c1 isXY"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='5'>
							<textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
							<input id="txtBillmemo" type="hidden" />
							<input id="txtInvomemo" type="hidden" />
							<input id="txtConntel" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
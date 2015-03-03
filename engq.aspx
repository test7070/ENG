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

            q_desc = 1;
            q_tables = 's';
            var q_name = "engq";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 15, 0, 1],['txtUmoney', 15, 0, 1],['txtProfit', 15, 0, 1]];
            var bbsNum = [['txtMount', 10, 2, 1], ['txtPrice', 10, 2, 1], ['txtMoney', 15, 0, 1],['txtUmount', 10, 2, 1], ['txtUprice', 10, 2, 1], ['txtUmoney', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            	['txtCustno','lblCustno','cust','noa,nick','txtCustno,txtCust','cust_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '');
            });

            function sum() {
                var tt_total=0,tt_utotal=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	var t_total=0,t_utotal=0;
                	t_total = q_mul(q_float('txtMount_'+i),q_float('txtPrice_'+i));
                    q_tr('txtMoney_'+i,t_total);
                    t_utotal = q_mul(q_float('txtUmount_'+i),q_float('txtUprice_'+i));
                    q_tr('txtUmoney_'+i,t_utotal);
                    
                    
                    tt_total+=t_total;
                    tt_utotal+=t_utotal;
                }
                q_tr('txtMoney',tt_total);
                q_tr('txtUmoney',tt_utotal);
                q_tr('txtProfit',q_sub(tt_total,tt_utotal));
            };

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                
                $('#btnChgprice').click(function() {
                	$('#div_chgprice').show();
				});
				$('#btnClose_div_chgprice').click(function() {
                	$('#div_chgprice').hide();
				});
				$('#btnDo_chgprice').click(function() {
                	$('#div_chgprice').hide();
                	//q_func('qtxt.query.changeprice', 'engo.txt,changeprice,' + r_name + ';' + encodeURI($('#txtNoa').val()) + ';' + encodeURI($('#chgprice_txtMoney').val())+ ';' + encodeURI($('#chgprice_txtProduct').val())+ ';' + encodeURI($('#chgprice_txtPrice').val()));
                	
                	//直接在bbs調整
                	if(!emp($('#chgprice_txtMoney').val())){
						if(q_float('txtMoney')>0){
                			var t_pro=q_div(q_float('chgprice_txtMoney'),q_float('txtMoney'));
                			for (var i = 0; i < q_bbsCount; i++) {
                				if(!emp($('#txtPrice_'+i).val())){
                					q_tr('txtPrice_'+i,q_mul(q_float('txtPrice_'+i),t_pro));
                					q_tr('txtMoney_'+i,q_mul(q_float('txtPrice_'+i),q_float('txtMount_'+i)));
                				}
                			}
                		}
                	}else{
                		for (var i = 0; i < q_bbsCount; i++) {
                			if(!emp($('#txtPrice_'+i).val()) && $('#txtProducct_'+i).val().indexOf($('#chgprice_txtProduct').val())>-1){
                				q_tr('txtPrice_'+i,q_mul(q_float('txtPrice_'+i),q_div(q_add(1,q_float('chgprice_txtPrice')),100)));
                				q_tr('txtMoney_'+i,q_mul(q_float('txtPrice_'+i),q_float('txtMount_'+i)));
                			}
                		}
                	}
				});
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
					$('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_engq') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('engq_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {

                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });
                        $('#txtUmount_'+ j).change(function() {
                          	sum();
                        });
                        $('#txtUprice_'+ j).change(function() {
                          	sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_engqp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val()+ ";" + r_accy + "_" + r_cno, 'cont', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product'] && !as['nos']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['datea'] = abbm2['datea'];
                as['engno'] = abbm2['engno'];
                as['eng'] = abbm2['eng'];
                as['custno'] = abbm2['custno'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function q_popPost(s1) {
                switch (s1) {

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
			#dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
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
                /*margin: -1px;
                border: 1px black solid;*/
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
                /*width: 9%;*/
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
                font-size: medium;
            }
            .dbbs {
                float: left;
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

		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_chgprice" style="position:absolute; top:300px; left:400px; display:none; width:200px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_chgprice" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						總價調：<input id='chgprice_txtMoney' type='text' class='txt' style="float:none;width: 150px;"/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						相關字：<input id='chgprice_txtProduct' type='text' class='txt' style="float:none;width: 150px;"/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="left">
						調整%：<input id='chgprice_txtPrice' type='text' class='txt' style="float:none;width: 150px;"/>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input id="btnDo_chgprice" type="button" value="確定">
						<input id="btnClose_div_chgprice" type="button" value="關閉">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewEng'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='cust,6'>~cust,6</td>
						<td align="center" id='eng,6'>~eng,6</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<!-- <td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text"  class="txt c1"/></td> -->
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td><input id="txtContract" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEng' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtEngno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtEng"  type="text" class="txt" style="width:70%; float: left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtCust"  type="text" class="txt" style="width:70%; float: left;"/>
						</td>
						<td><input id="btnChgprice" type="button" /></td>
						<td><span> </span><a id='lblEnda' class="lbl"> </a></td>
						<td><input id="chkEnda" type="checkbox"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUmoney' class="lbl"> </a></td>
						<td><input id="txtUmoney" type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblProfit' class="lbl"> </a></td>
						<td><input id="txtProfit" type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDenominate' class="lbl"> </a></td>
						<td><input id="txtDenominate" type="text"  class="txt c1"/></td>
						<td align="center"><a id="lblApv"> </a></td>
						<td><input id="txtApv" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo" rows="5" cols="10" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;"> </td>
						<td align="center" style="width:200px;"><a id='lblNos'> </a></td>
						<td align="center" style="width:60px;"><a id='lblProductno'> </a></td>
						<td align="center" style="width:60px;"><a id='lblProduct'> </a></td>
						<td align="center" style="width:60px;"><a id='lblUnit'> </a></td>
						<td align="center" style="width:60px;"><a id='lblMount'> </a></td>
						<td align="center" style="width:60px;"><a id='lblPrice'> </a></td>
						<td align="center" style="width:60px;"><a id='lblMoneys'> </a></td>
						<td align="center" style="width:60px;"><a id='lblUmount'> </a></td>
						<td align="center" style="width:60px;"><a id='lblUprice'> </a></td>
						<td align="center" style="width:60px;"><a id='lblUmoneys'> </a></td>
						<td align="center" style="width:60px;"><a id='lblBdate'> </a></td>
						<td align="center" style="width:60px;"><a id='lblEdate'> </a></td>
						<td align="center" style="width:20px;"><a id='lblChase'> </a></td>
						<td align="center" style="width:20px;"><a id='lblPrt'> </a></td>
						<td align="center" style="width:20px;"><a id='lblOut'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td ><input id="txtNos.*" type="text"  class="txt c1"/></td>
						<td>
							<input type="text" id="txtNo3.*"  style="display: none;"/>
							<input type="text" id="txtProductno.*"  class="txt c1"/>
							<input class="btn"  id="btnProduct.*" type="button" style="display: none" />
						</td>
						<td ><input id="txtProduct.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtUnit.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtMount.*" type="text"  class="txt num c1"/></td>
						<td ><input id="txtPrice.*" type="text" class="txt num c1" /></td>
						<td ><input id="txtMoney.*" type="text" class="txt num c1" /></td>
						<td ><input id="txtUmount.*" type="text"  class="txt num c1"/></td>
						<td ><input id="txtUprice.*" type="text" class="txt num c1" /></td>
						<td ><input id="txtUmoney.*" type="text" class="txt num c1" /></td>
						<td ><input id="txtBdate.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtEdate.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtChase.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtPrt.*" type="text"  class="txt c1"/></td>
						<td ><input id="txtOut.*" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
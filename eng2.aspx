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

            q_tables = 't';
            var q_name = "eng2";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtMoney','txtEng','txtCustno','txtComp'];
            var q_readonlys = ['txtEngono','txtNo2'];
            var q_readonlyt = [];
            var bbmNum = [['txtMoney', 15, 0, 1]];
            var bbsNum = [['txtPrice', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtMoney', 15, 0, 1]];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            q_desc = 1;
            brwCount2 = 10;

            aPop = new Array(['txtEngno', '', 'engo', 'engno,eng,custno,comp', 'txtEngno,txtEng,txtCustno,txtComp', 'engo_b.aspx']);
			
			var z_mech = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
            	q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd]];
                q_mask(bbmMask);
                
                $('#btnEngo').click(function() {
                	if(q_cur==1 ||q_cur==2){
                		if(!emp($('#txtEngno').val())){
	                		var t_where="where=^^engno='"+$('#txtEngno').val()+"'^^"
	                		q_gt('engo', t_where, 0, 0, 0, "", r_accy);
                		}
                	}
                });
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {            	
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {         
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'engo':
                		var as = _q_appendData("engos", "", true);     
                		for (var i=0;i<as.length;i++){
                			if(as[i].out=='true'){
                				as.splice(i, 1);
								i--;
                			}
                		}
                		
                		q_gridAddRow(bbsHtm, 'tbbs'
						,'txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtMoney,txtEngono,txtNo2', as.length, as,
						'productno,product,unit,mount,price,money,noa,no2','');             		
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('eng2_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
            	_btnModi();
            	$('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_eng2p.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='"+$('#txtNoa').val()+"';" + r_accy + "_" + r_cno, 'eng2', "95%", "95%", m_print);
            }

            function btnOk() {
				sum();
				
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                    
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_eng2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        
                        $('#txtPrice_'+i).change(function() {
                        	sum();
						});
						$('#txtMount_'+i).change(function() {
                        	sum();
						});
						$('#txtMoney_'+i).change(function() {
                        	sum();
						});
                    }
                }
                _bbsAssign();
            }
			
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
				var t_total = 0;
				for(var i=0;i<q_bbsCount;i++){
					q_tr('txtMoney_'+i,q_mul(q_float('txtPrice_'+i),q_float('txtMount_'+i)));
					t_total += q_float('txtMoney_'+i);
				}
				$('#txtMoney').val(q_tr(t_total,0));
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 350px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 800px;
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width:1200px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width:1200px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewEng'> </a></td>
						<td style="width:100px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='eng,4' style="text-align: center;">~eng,4</td>
						<td id='comp,4' style="text-align: center;">~comp,4</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td ><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTcount" class="lbl"> </a></td>
						<td >
							<a style="float: left;">第</a><span style="float: left;"> </span>
							<input id="txtTcount" type="text" class="txt c2"/>
							<span style="float: left;"> </span><a style="float: left;">期</a>
						</td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate"  type="text"  class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate"  type="text"  class="txt c2"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEng" class="lbl"> </a></td>
						<td ><input id="txtEngno"  type="text" class="txt c1"/></td>
						<td colspan="3"><input id="txtEng"  type="text"  class="txt c1"/></td>
						<td><input id="btnEngo" type="button" style="float: none;" value="匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td ><input id="txtCustno"  type="text" class="txt c1"/></td>
						<td colspan="3"><input id="txtComp"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4"><textarea id="txtMemo" rows="3" cols="10" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td ><input id="txtMoney"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblValuation" class="lbl"> </a></td>
						<td><input id="txtValuation"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td><input id="txtApv"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDirector' class="lbl"> </a></td>
						<td><input id="txtDirector"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblManager' class="lbl"> </a></td>
						<td><input id="txtManager2"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAccountants' class="lbl"> </a></td>
						<td><input id="txtAccountants"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:230px;"><a id='lblProduct_s'> </a></td>
					<td style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td style="width:80px;"><a id='lblMount_s'> </a></td>
					<td style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td style="width:80px;"><a id='lblSection_s'> </a></td>
					<td style="width:80px;"><a id='lblBmileage_s'> </a></td>
					<td style="width:80px;"><a id='lblEmileage_s'> </a></td>
					<td style="width:80px;"><a id='lblLengthb_s'> </a></td>
					<td style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="hidden" style="width:30%; float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:95%;float:left;"/>
						<input id="btnProduct.*" type="button" style="display:none;float:left;"/>
					</td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:95%; float:left;"/></td>
					<td><input class="txt num" id="txtPrice.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num" id="txtMount.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num" id="txtMoney.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtSection.*" type="text" style="width:95%; float:left;"/></td>
					<td><input class="txt" id="txtBmileage.*" type="text" style="width:95%; float:left;"/></td>
					<td><input class="txt" id="txtEmileage.*" type="text" style="width:95%; float:left;"/></td>
					<td><input class="txt num" id="txtLengthb.*" type="text" style="width:95%; float:r;"/></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%; float:left;"/>
						<input class="txt" id="txtEngono.*" type="text" style="width:75%; float:left;"/>
						<input class="txt" id="txtNo2.*" type="text" style="width:20%; float:left;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
					</tr>
					<tr class="detail">
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>						
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>

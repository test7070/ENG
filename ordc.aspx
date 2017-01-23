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
            q_tables = 's';
            var q_name = "ordc";
            var q_readonly = ['txtTgg', 'txtAcomp', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtTotal', 'txtTax', 'txtEng'];
            var q_readonlys = ['txtNo2', 'txtTotal', 'txtC1', 'txtNotv', 'txtOrdbno', 'txtNo3','txtEngono','txtEngono2'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtPrice', 10, 3, 1], ['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Odate';
			 brwCount = 0;
			 brwCount2 = 9;
            var z_acomp = '';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'bcc', 'noa,product,unit,price', 'txtProductno_,txtProduct_,txtUnit_,txtPrice_,txtMount', 'ucc_b.aspx']
            	, ['txtTggno', 'lblTgg', 'tgg', 'noa,nick,paytype,trantype', 'txtTggno,txtTgg,txtPaytype,cmbTrantype', 'tgg_b.aspx']
            	, ['txtEngno', 'lblEng', 'engo', 'engno,eng', 'txtEngno,txtEng', 'engo_b.aspx']
            	);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no2'];
                q_brwCount();
                //q_gt('acomp', "", 0, 0, 0, 'acomp');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
                bbsMask = [['txtIndate', r_picd]];
                q_mask(bbmMask);
                //q_cmbParse("cmbCno", z_acomp);
                q_cmbParse("cmbKind", q_getPara('ordc.kind'));
                //rc2.stype
                q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                
                $("#combPaytype").change(function(e) {
  					if(q_cur==1 || q_cur==2)
					 $('#txtPaytype').val($('#combPaytype').find(":selected").text()); 
				});
				
				$("#txtPaytype").focus(function(e) {
  					var n=$(this).val().match(/[0-9]+/g);
  					var input = document.getElementById ("txtPaytype");
		            if (typeof(input.selectionStart) != 'undefined' && n != null) {	  
		                input.selectionStart = $(this).val().indexOf(n);
		                input.selectionEnd =$(this).val().indexOf(n)+n.length+1;
		            }
				});
				
				$('#txtTax').change(function () {
	            	sum();
			     });
				
                /* 若非本會計年度則無法存檔 */
                $('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });

                $('#btnEngos').click(function() {
                    var t_engno = trim($('#txtEngno').val());
                    var t_noa = trim($('#txtNoa').val());
                    var t_kind = trim($('#cmbKind').val());
                    
                    if(t_kind=='1'){
                    	var t_where = "1=1";
                    	if(t_engno.length>0)
                    		t_where =t_where+ " and exists (select * from engo where noa=engos.noa and engno='"+t_engno+"' ) ";
	                    t_where =t_where+ " and not exists (select * from view_ordcs where engono=engos.noa and engono2=engos.no2  and noa!='"+t_noa+"' ) ";
                    	q_box("engos_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy , 'engos;' + t_where, "95%", "650px", q_getMsg('popEngos'));
                    		
                    }else{
                    	var t_where = "1=1";
                    	if(t_engno.length>0)
                    		t_where =t_where+ " and exists (select * from engp where noa=engps.noa and engno='"+t_engno+"' ) ";
	                    t_where =t_where+ " and not exists (select * from view_ordcs where engono=engps.noa and engono2=engps.no2  and noa!='"+t_noa+"' ) ";
                    	q_box("engps_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy , 'engps;' + t_where, "95%", "650px", q_getMsg('popEngps'));
                    }
                });
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case 'engos':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;

                            for (var j = 0; j < q_bbsCount; j++) {
                                $('#btnMinus_' + j).click();
                            }

                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtPrice,txtMount,txtTotal,txtMemo,txtEngono,txtEngono2,txtEngno'
                            , b_ret.length, b_ret, 'productno,product,unit,price,mount,money,memo,noa,no2,engno', 'txtProductno,txtProduct');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            bbsAssign();
                        }
                        break;
					case 'engps':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;

                            for (var j = 0; j < q_bbsCount; j++) {
                                $('#btnMinus_' + j).click();
                            }

                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtPrice,txtMount,txtTotal,txtMemo,txtEngono,txtEngono2,txtEngno'
                            , b_ret.length, b_ret, 'productno,product,unit,price,mount,money,memo,noa,no2,engno', 'txtProductno,txtProduct');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            bbsAssign();
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true)
                        if (as[0] != undefined) {
                            z_acomp = ' @';
                            for (var i = 0; i < as.length; i++) {
                                z_acomp += ',' + as[i].noa + '@' + as[i].acomp;
                            }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val()) == 0) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                $('#txtOdate').val($.trim($('#txtOdate').val()));
                if (checkId($('#txtOdate').val()) == 0) {
                    alert(q_getMsg('lblOdate') + '錯誤。');
                    return;
                }

                //1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
                if (!$('#chkIsproj').prop('checked')) {
                    for (var j = 0; j < q_bbsCount; j++) {
                        if ($('#chkEnda').prop('checked'))
                            $('#chkEnda_' + j).prop('checked', 'true');
                        if ($('#chkCancel').prop('checked'))
                            $('#chkCancel_' + j).prop('checked', 'true');
                    }
                }

                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
                sum();

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('P' + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ordc_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function combPaytype_chg() {
                var cmb = document.getElementById("combPaytype")
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtPaytype').val(cmb.value);
                cmb.value = '';
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    	$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtMount_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            q_tr('txtTotal_' + b_seq, q_mul(q_float('txtMount_' + b_seq) , q_float('txtPrice_' + b_seq)));
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            q_tr('txtTotal_' + b_seq, q_mul(q_float('txtMount_' + b_seq) , q_float('txtPrice_' + b_seq)));
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#chkIsproj').attr('checked', true);
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtDatea').val(q_cdn(q_date(), 10));
                $('#txtOdate').focus();
                //$('#cmbCno').get(0).selectedIndex=1;
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {
                q_box("z_ordcp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val()+ "';" + r_accy + "_" + r_cno, 'ordcp', "95%", "95%", m_print);
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
                as['datea'] = abbm2['datea'];
                as['kind'] = abbm2['kind'];
                as['tggno'] = abbm2['tggno'];
                as['odate'] = abbm2['odate'];
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

                var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;

                for (var j = 0; j < q_bbsCount; j++) {
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                    t_moneys = round(q_mul(t_prices, t_mounts), 0);

                    t_mount = q_add(t_mount, t_mounts);
                    t_money = q_add(t_money, t_moneys);

                    $('#txtTotal_' + j).val(q_trv(t_moneys, 0, 1));
                }
                t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
                switch ($('#cmbTaxtype').val()) {
                    case '1':
                        // 應稅
                        t_tax = round(q_mul(t_money, t_taxrate), 0);
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '3':
                        // 內含
                        t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
                        t_total = t_money;
                        t_money = q_sub(t_total, t_tax);
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '5':
                        // 自定
                        $('#txtTax').attr('readonly', false);
                        $('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = q_add(t_money, t_tax);
                        break;
                    case '6':
                        // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
                }

                $('#txtMoney').val(q_trv(t_money, 0, 1));
                $('#txtTax').val(q_trv(t_tax, 0, 1));
                $('#txtTotal').val(q_trv(t_total, 0, 1));
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnOrdb').attr('disabled', 'disabled');
                } else {
                    $('#btnOrdb').removeAttr('disabled');
                }

                if (q_cur == 1 || q_cur == 2) {
                    if (r_modi)
                        $('#cmbApv').removeAttr('disabled');
                    else
                        $('#cmbApv').attr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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

            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
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
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .dbbs {
                width: 1250px;
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
                width: 1250px;
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
                width: 1000px;
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">

		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1250px;">
			<div class="dview" id="dview" style="width: 450px;">
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg,4'>~tgg,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 800px;">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 125px;"> </td>
						<td style="width: 10px;"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td> </td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id="lblAcomp" class="lbl" > </a></td>
						<td colspan="5"><select id="cmbCno" class="txt c1"> </select></td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblEng" class="lbl btn"> </a></td>
						<td colspan="5">
							<input id="txtEngno" type="text" style="float:left;width:30%;"/>
							<input id="txtEng"  type="text" style="float:left;width:69%;"/>
						</td>
						<td><input id="btnEngos" type="button" value="匯入"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTggno" type="text" style="float:left;width:40%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtPaytype" type="text" style="float:left;width:90%;"/>
							<select id="combPaytype" style="float:left;width:10%; margin-top: -1px;"> </select>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTel"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='2'><input id="txtFax" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td><input id="txtContract"  type="text" class="txt c1 lef"/></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtPost" type="text" style="float:left;width:16%;"/>
							<input id="txtAddr" type="text" style="float:left;width:84%;"/>
						</td>
						<td><span> </span><a id='lblOrdb' class="lbl btn"> </a></td>
						<td><input id="txtOrdbno"  type="text" class="txt c1 lef" /></td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text" class="txt num c1" /></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange="sum()" > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1 lef" /></td>
						<td><input id="txtWorker2"  type="text" class="txt c1 lef" /></td>
						<td align="right">
							<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj' style="width: 50%;"> </a>
						</td>
						<td align="right">
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnda' style="width: 40%;"> </a><span> </span>
						</td>
						<td align="right">
							<input id="chkCancel" type="checkbox"/>
							<a id='lblCancel' style="width: 40%;"> </a><span> </span>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='7'><textarea id="txtMemo"  rows="5" style="width:100%;height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:110px;"><a id='lblEngno_s'> </a></td>
					<td align="center" style="width:110px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:90px;"><a id='lblIndate_s'> </a></td>
					<td align="center" style="width:110px;"><a id='lblGemount_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblCancel_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNo2.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtEngno.*" type="text" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtProductno.*" style="width:95%;" />
						<input type="button"  id="btnProduct.*" style="display:none;" />
					</td>
					<td><input id="txtProduct.*" type="text" style="width:95%;"/></td>
					<td><input  id="txtUnit.*" type="text" style="width:95%;"/></td>
					<td><input id="txtMount.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input id="txtTotal.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input id="txtIndate.*" type="text" style="width:95%;"/></td>
					<td>
						<input id="txtC1.*" type="text" style="width:95%;text-align: right;"/>
						<input id="txtNotv.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" style="width:95%;"/>
						<input id="txtEngono.*" type="text" style="width:70%;float:left;" />
						<input id="txtEngono2.*" type="text" style="width:20%;float:left;" />
						<input id="recno.*" style="display:none;" />
					</td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


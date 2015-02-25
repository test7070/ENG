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
            q_tables = 't';
            var q_name = "engo";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [['txtMoney', 15, 0, 1],['txtUmoney', 15, 0, 1],['txtProfit', 15, 0, 1]];
            var bbsNum = [['txtMount', 10, 2, 1], ['txtPrice', 10, 2, 1], ['txtMoney', 15, 0, 1],['txtUmount', 10, 2, 1], ['txtUprice', 10, 2, 1], ['txtUmoney', 15, 0, 1]];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no2'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '');
            });

            function sum() {
            	var tt_total=0,tt_utotal=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	var t_total=0,t_utotal=0;
                    t_total = round(q_float('txtMount_' + i), q_float('txtPrice_' + i), 0);
                    $('#txtMoney_' + i).val(t_total);
                    t_utotal = round(q_float('txtUmount_' + i), q_float('txtUprice_' + i), 0);
                    $('#txtUmoney_' + i).val(t_utotal);
                    
                    tt_total+=t_total;
                    tt_utotal+=t_utotal;
                }
                $('#txtMoney').val(t_total);
                $('#txtUmoney').val(tt_utotal);
                $('#txtProfit').val(t_total-tt_utotal);
            };

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
                		if(dec($('#txtMoney').val())>0){
                			var t_pro=q_div(dec($('#chgprice_txtMoney').val()),dec($('#txtMoney').val()));
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
				
				/*$('#btnEngqno').click(function() {
					if((q_cur==1 || q_cur==2) && !emp($('#txtEngqno').val())){
						var t_date=q_date();
						q_gt('engq', "where=^^noa='"+$('#txtEngqno').val()+"' and odate>='"+t_date+"' ^^", 0, 0, 0, "engq", r_accy);
					}
				});*/
				
				$('#btnEng').click(function() {
				});
				
            }

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
                	case 'engq':
                		var as = _q_appendData("engqs", "", true);                		
                		q_gridAddRow(bbsHtm, 'tbbs'
							,'txtNos,txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtMoney,txtUmount,txtUprice,txtUmoney,txtBdate,txtEdate,txtChase,txtPrt,txtOut', as.length, as,
							'nos,productno,product,unit,mount,price,money,umount,uprice,umoney,bdate,edate,chase,prt,out','');                		
                		break;
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
                
                //排序------------------------------------------------------------------------------------------------------------
                var t_bbs=new Array();
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProcess_'+i).val()) || !emp($('#txtWorkno_'+i).val())){
                		var t_bbss=new Array();
                		for (var j = 0; j < fbbs.length; j++) {
                			t_bbss[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
                		}
                		t_bbs.push(t_bbss);
                	}
					$('#btnMinus_'+i).click();
				}
                //最先做的放前面(nos)
                if(t_bbs.length!=0){
					t_bbs.sort(compare);
					for (var i = 0; i < t_bbs.length; i++) {
	               		for (var j = 0; j < fbbs.length; j++) {
	               			$('#'+fbbs[j]+'_'+i).val(t_bbs[i][fbbs[j]]);
	               		}
					}
				}
				
				//------------------------------------------------------------------------------------------------------------
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_engo') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            
            function compare(a,b) {
				if (a.txtNos < b.txtNos)
					return -1;
				if (a.txtNos > b.txtNos)
					return 1;
				return 0;
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('engo_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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
                        
                        $('#btnRecord_'+j).click(function() {
                        	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_box("engos_b.aspx?"+ r_userno + ";" + r_name + ";" + q_id + ";charindex('"+$('#txtProduct_'+b_seq).val()+"',product)>0;"+r_accy,'engos', "90%", "600px", $('#btnRecord_'+b_seq).val());
						});
                    }
                }
                _bbsAssign();
            }
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtFilename__' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtFilename__', '');
                        	var t_filename = escape($('#txtFilename__'+n).val());
                        	var t_tempname = escape($('#txtTempname__'+n).val());
                        	if(t_filename.length>0 && t_tempname.length>0)
                        		window.open('engo_download.aspx?FileName='+t_filename+'&TempName='+t_tempname, "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
                        	else
                        		alert('無資料...'+n);
                        });
                    	
                    	$('#btnUpload__'+i).change(function(e){
							event.stopPropagation(); 
						    event.preventDefault();
						    var t_n = $(this).attr('id').replace('btnUpload__','');
							file = $(this)[0].files[0];
							if(file){
								var ext = '';
								var extindex = file.name.lastIndexOf('.');
								if(extindex>0){
									ext = file.name.substring(extindex,file.name.length);
								}
								$('#txtFilename__'+t_n).val(file.name);
								$('#txtTempname__'+t_n).val(guid()+ext);
								
								fr = new FileReader();
								fr.fileName = $('#txtTempname__'+t_n).val();
							    fr.readAsDataURL(file);
							    fr.onprogress = function(e){
							    	 if ( e.lengthComputable ) { 
				                        var per = Math.round( (e.loaded * 100) / e.total) ; 
				                        $('#FileList').children().last().find('progress').eq(0).attr('value',per);
				                    }; 
							    }
							    fr.onloadstart = function(e){
							    	$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
							    	$('.btnUpload').attr('disabled','disabled');
							    }
							    fr.onloadend = function(e){
							    	$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							    	
									console.log(fr.fileName+':'+fr.result.length);
							    	var oReq = new XMLHttpRequest();
							    	
							    	oReq.upload.addEventListener("progress",function(e) {
								    	if (e.lengthComputable) {
									    	percentComplete = Math.round((e.loaded / e.total) * 100,0);
									     	$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
									    }
									}, false);
							    	oReq.upload.addEventListener("load",function(e) {
									    $('.btnUpload').val('');
									}, false);
		
									oReq.open("POST", 'engo_upload.aspx', true);
									oReq.setRequestHeader("Content-type", "text/plain");
								    oReq.timeout = 60000;
								    oReq.ontimeout = function () { alert("Timed out!!!"); }
									oReq.setRequestHeader("FileName", escape(fr.fileName));
									oReq.send(fr.result);
							    };
							}
						});
                    }
                }
                _bbtAssign();
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
                q_box("z_engop.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val()+ ";" + r_accy + "_" + r_cno, 'engop', "95%", "95%", m_print);
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
                if(t_para){
                	$('#btnChgprice').removeAttr('disabled');
                }else{
                	$('#btnChgprice').attr('disabled', 'disabled');
                }
                $('#div_chgprice').hide();
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
            
            /*function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.changeprice':
                		var s2=new Array('engo_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
						q_boxClose2(s2);
                	break;
                }
			}*/
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
                width: 14%;
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
                width: 130%;
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
                width: 1700px;
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
                width: 1700px;
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
                width: 600px;
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
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewEng'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,6'>~comp,6</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td><input id="txtContract" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEng' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtEngno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtEng"  type="text" class="txt" style="width:70%; float: left;"/>
						</td>
						<!--<td><span> </span><a id='lblEngqno' class="lbl"> </a></td>
						<td><input id="txtEngqno" type="text" class="txt c1"/></td>
						<td><input id="btnEngqno" type="button" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%; float: left;"/>
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
						<td><input id="btnEng" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="6"><textarea id="txtMemo" rows="5" cols="10" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><input id="txtFiles" type="text" class="txt c1"/></td>
						<td><input type="file" id="btnFile" value="上傳"/></td>
					</tr>
					<tr>
						<td colspan="7"><div style="width:100%;" id="FileList"> </div></td>
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
						<td align="center" style="width:60px;"><a id='lblChase'> </a></td>
						<td align="center" style="width:60px;"><a id='lblPrt'> </a></td>
						<td align="center" style="width:60px;"><a id='lblOut'> </a></td>
						<td align="center" style="width:60px;"><a id='lblRecord'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td ><input id="txtNos.*" type="text"  class="txt c1"/></td>
						<td>
							<input type="text" id="txtNo2.*"  style="display: none;"/>
							<input type="text" id="txtProductno.*"  style="width:95%; float:left;"/>
							<input class="btn"  id="btnProduct.*" type="button" style="display:none;" />
						</td>
						<td ><input id="txtProduct.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input id="txtUnit.*" type="text"  class="txt" style="width:95%"/></td>
						<td ><input id="txtMount.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtPrice.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtMoney.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtUmount.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtUprice.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtUmoney.*" type="text" class="txt num" style="width:95%"/></td>
						<td ><input id="txtBdate.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input id="txtEdate.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input id="txtChase.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input id="txtPrt.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input id="txtOut.*" type="text" class="txt" style="width:95%"/></td>
						<td ><input class="btn"  id="btnRecord.*" type="button" style="width: 1%" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt">
			<table id="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
					<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:150px; text-align: center;">檔名</td>
					<td style="width:200px; text-align: center;">備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtFilename..*" type="text" style="width:95%;"/>
						<input class="txt" id="txtTempname..*" type="text" style="width:95%;"/>
						<input type="file" id="btnUpload..*" value="上傳" class="btnUpload"/>
					</td>
					<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
	</body>
</html>
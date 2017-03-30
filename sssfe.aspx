<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
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

			var q_name = "sss";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 15;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(
				['txtAddr_home', '', 'view_road', 'memo', '0txtAddr_home', 'road_b.aspx'],
				['txtAddr_conn', '', 'view_road', 'memo', '0txtAddr_conn', 'road_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, '', q_sqlCount, 1);		
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
				bbmMask = [['txtBirthday', r_picd], ['txtIndate', r_picd], ['txtOutdate', r_picd], ['txtHealth_bdate', r_picd], ['txtHealth_edate', r_picd], ['txtLabor1_bdate', r_picd], ['txtLabor1_edate', r_picd], ['txtLabor2_bdate', r_picd], ['txtLabor2_edate', r_picd]
				,['textBmon','99'],['textEmon','99'],['textYear','999']];
				q_mask(bbmMask);

				/*if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
					q_cmbParse("cmbTypea", q_getPara('sss.typea_it'));
				else*/
					q_cmbParse("cmbTypea", q_getPara('sss.typea'));

				q_cmbParse("cmbSex", q_getPara('sss.sex'));
				q_cmbParse("cmbPerson", q_getPara('person.typea'));
				q_cmbParse("cmbBlood", ('').concat(new Array('', 'A', 'B', 'AB', 'O')));
				
				q_gt('acomp', '', 0, 0, 0, "");
				q_gt('part', '', 0, 0, 0, "");
				q_gt('salm', '', 0, 0, 0, "");

				if (q_getPara('sys.comp').indexOf('祥興') > -1) {
					$('#btnSsspart').show();
				} else {
					$('#btnSsspart').hide();
				}
				if (q_getPara('sys.comp').indexOf('永勝') > -1 || q_getPara('sys.comp').indexOf('楊家') > -1 || q_getPara('sys.comp').indexOf('德芳') > -1) {
					$('#sbutton').hide();
					$('#btnLabases').hide();
					$('#btnSaladjust').hide();
				}else if(r_rank<8){
					$('#btnLabases').hide();
					$('#btnSaladjust').hide();
				}
				
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('sss', t_where, 0, 0, 0, "checkSssno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});

				$("#cmbTypea").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbSex").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbPerson").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).change(function() {
					if($("#cmbPerson").val()=='外勞'){
						$('#txtPassportno').show();
						$('#lblPassportno').show();
						$('#txtId').hide();
						$('#lblId').hide();
					}else{
	                   	$('#txtPassportno').hide();
						$('#lblPassportno').hide();
						$('#txtId').show();
						$('#lblId').show();
					}
				});
				$("#cmbRecord").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbBlood").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				
				$("#cmbPartno").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$("#cmbJobno").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});

				$('#btnLabases').click(function(e) {
					if (q_cur == 1) {
						return;
					}
					q_box("labase.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labase', "95%", "95%", q_getMsg("popLabase"));
				});
				$('#btnSsspart').click(function(e) {
					if (q_cur == 1) {
						return;
					}
					q_box("ssspart_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'ssspart', "60%", "95%", q_getMsg("popSsspart"));
				});
				$('#btnSaladjust').click(function(e) {
					if (q_cur == 1) {
						return;
					}
					if (q_getPara('sys.project').toUpperCase()=='DJ'){
						q_box("saladjust_dj.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'saladjust', "95%", "95%", q_getMsg("popSaladjust"));
					}else{
						q_box("salAdjust.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'saladjust', "95%", "95%", q_getMsg("popSaladjust"));
					}
				});
				
				$('#btnSssr').click(function(e) {
					if (q_cur == 1) {
						return;
					}
					q_box("sssr.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'sssr', "900px", "80%", $('#btnSssr').val());
				});

				$('#txtIndate').change(function(e) {
					if (!emp($('#txtIndate').val())) {
						$('#txtHealth_bdate').val($('#txtIndate').val());
						$('#txtLabor1_bdate').val($('#txtIndate').val());
						$('#txtLabor2_bdate').val($('#txtIndate').val());
					}
				});
				$('#txtOutdate').change(function(e) {
					if (!emp($('#txtOutdate').val())) {
						$('#txtHealth_edate').val($('#txtOutdate').val());
						$('#txtLabor1_edate').val($('#txtOutdate').val());
						$('#txtLabor2_edate').val($('#txtOutdate').val());
					}
				});
				
				//稅務相關按鈕-------------------------------------
				if(q_getPara('sys.salb')=='1'){
					q_gt('payform', '', 0, 0, 0, "");
					q_gt('paymark', '', 0, 0, 0, "");
					q_gt('payremark', '', 0, 0, 0, "");
					$('#btnTax').show();
					$('#btnSalbs').show();
				}else{
					$('#btnTax').hide();
					$('#btnSalbs').hide();
				}
				
				$('#btnTax').click(function(e) {
                    q_box("sssu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';"+r_accy+";" + q_cur, 'sssu', "95%", "95%", q_getMsg('popSssu'));
                });
                
                $('#btnSalbs').click(function(e) {
                    $('#div_salbs').toggle();
                });
                
                $('#btnClose_div_salbs').click(function(e) {
                    $('#div_salbs').hide();
                });
                
                $('#btnInsert_div_salbs').click(function(e) {
                	if(!emp($('#textYear').val())){
                		var t_paras = $('#txtNoa').val()+ ';'+$('#textYear').val()+ ';'+q_getPara('sys.key_salb')+ ';' 
                		+ $('#combTypea').val()+ ';' + $('#combTypeb').val()+ ';' + $('#combTypec').val()+';';
                		                		
                		for (var i=1;i<=12;i++){
                			t_paras += dec($('#textRmoney_'+i).val())+ '#' +dec($('#textSmoney_'+i).val())+ '#' +dec($('#textTmoney_'+i).val())+ '#' +dec($('#textOmoney_'+i).val())+(i==12?'':'#');
	                    }
                		
	                	q_func('qtxt.query.salbs', 'salb.txt,sss,' + t_paras);
                    	$('#div_salbs').hide();
                   }else{
                   	alert('年度禁止空白!!');
                   }
                });
               
               $('#combTypea').change(function(){
					//處理內容
					$('#combTypeb').text('');
					$('#combTypec').text('');
					
					var c_typeb=' @ ';
					for (i=0;i<t_typeb.length;i++){
						if(t_typeb[i].noa==$('#combTypea').val())
							c_typeb=c_typeb+','+t_typeb[i].inote+"@"+t_typeb[i].kind;
					}
					q_cmbParse("combTypeb", c_typeb);
							
					//處理內容
					var c_typec=' @ ';
					for (i=0;i<t_typec.length;i++){
						if(t_typec[i].payformno==$('#combTypea').val())
							c_typec=c_typec+','+t_typec[i].noa+"@"+t_typec[i].noa+'.'+t_typec[i].mark;
					}
					q_cmbParse("combTypec", c_typec);
				});
               
               $('#textBmon').val('01');
               $('#textBmon').blur(function(e) {
                    var bmon=dec($('#textBmon').val())
                    if(bmon>12 || bmon<0){
                    	$('#textBmon').val('01');
                    }
                });
               $('#textEmon').val('12'); 
                $('#textEmon').blur(function(e) {
                    var emon=dec($('#textEmon').val())
                    if(emon>12 || emon<0){
                    	$('#textEmon').val('12');
                    }
                });
               
               $('#btnImport_rmoney').click(function(e) {
	               	var bmon=dec($('#textBmon').val())
	               	var emon=dec($('#textEmon').val())
                    for (var i=bmon;i<=emon;i++){
                    	q_tr('textRmoney_'+i,$('#textRmoney').val());
                    }
                });
                
                $('#btnImport_smoney').click(function(e) {
                	var bmon=dec($('#textBmon').val())
	               	var emon=dec($('#textEmon').val())
                    for (var i=bmon;i<=emon;i++){
                    	q_tr('textSmoney_'+i,$('#textSmoney').val());
                    }
                    sum();
                });
                
                $('#btnImport_tmoney').click(function(e) {
                    var bmon=dec($('#textBmon').val())
	               	var emon=dec($('#textEmon').val())
                    for (var i=bmon;i<=emon;i++){
                    	q_tr('textTmoney_'+i,$('#textTmoney').val());
                    }
                    sum();
                });
                
                $('#btnImport_tmoney2').click(function(e) {
                    var bmon=dec($('#textBmon').val())
	               	var emon=dec($('#textEmon').val())
                    for (var i=bmon;i<=emon;i++){
                    	q_tr('textTmoney_'+i,q_div(q_mul(dec($('#textSmoney_'+i).val()),dec($('#textTmoney2').val())),100));
                    }
                    sum();
                });
                
                $('#btnImport_omoney').click(function(e) {
                    var bmon=dec($('#textBmon').val())
	               	var emon=dec($('#textEmon').val())
                    for (var i=bmon;i<=emon;i++){
                    	q_tr('textOmoney_'+i,$('#textOmoney').val());
                    }
                });
                $('#table_salbs .num').val(0);
                $('#textYear').val(r_accy);
                $('#table_salbs .num').keyup(function() {
					var tmp=$(this).val();
					tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
					$(this).val(tmp);
					sum();
				});
                //-----------------------------------------------------
                $('#lblBarcode').text('卡號');
			}
			
			function sum() {
				var t_total=0,t_tax=0;
				for (var i=1;i<=12;i++){
					t_total=q_add(t_total,dec($('#textSmoney_'+i).val()));
					t_tax=q_add(t_tax,dec($('#textTmoney_'+i).val()));
				}
				q_tr('textTotal',t_total);
				q_tr('textTax',t_tax);
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						/// q_boxClose 3/4
						break;
				} /// end Switch
			}
			
			var t_typeb=[],t_typec=[];
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
		                    }
		                    q_cmbParse("cmbCno", t_item);
		                    if(abbm[q_recno])
		                    	$("#cmbCno").val(abbm[q_recno].cno);
		                }
		                break;
					case 'payform':
						var as = _q_appendData("payform", "", true);
		                var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' +as[i].noa+'.'+ as[i].form;
						}
						q_cmbParse("combTypea", t_item);
						break;
					case 'paymark':
						t_typec = _q_appendData("paymark", "", true);
						break;
					case 'payremark':
						t_typeb = _q_appendData("payremark", "", true);
						break;
					case 'checkSssno_change':
						var as = _q_appendData("sss", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
						}
						break;
					case 'checkSssno_btnOk':
						var as = _q_appendData("sss", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].namea);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case 'part':
						var as = _q_appendData("part", "", true);
						if (as[0] != undefined) {
							var t_item = "";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
							}
							q_cmbParse("cmbPartno", t_item);
							if (abbm[q_recno] != undefined)
								$("#cmbPartno").val(abbm[q_recno].partno);
						}
						break;
					case 'salm':
						var as = _q_appendData("salm", "", true);
						if (as[0] != undefined) {
							var t_item = "";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].job;
							}
							q_cmbParse("cmbJobno", t_item);
							if (abbm[q_recno] != undefined)
								$("#cmbJobno").val(abbm[q_recno].jobno);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('sssfe_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
				refreshBbm();
				/// 允許修改
				$('#txtNamea').focus();
				$('#txtNoa').attr('disabled', 'disabled');
			}

			function btnPrint() {
				if (q_getPara('sys.project').toUpperCase()=='UU')
					q_box('z_sssp_uu.aspx', '', "95%", "95%", q_getMsg("popPrint"));
				if (q_getPara('sys.project').toUpperCase()=='IT')
					q_box('z_sssp_it.aspx', '', "95%", "95%", q_getMsg("popPrint"));
				if (q_getPara('sys.project').toUpperCase()=='RB')
					q_box('z_sssp_rb.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if ((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())) {
				} else {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}
				if (!q_cd($('#txtBirthday').val())) {
					alert(q_getMsg('lblBirthday') + '錯誤。');
					Unlock();
					return;
				}
				if (!q_cd($('#txtIndate').val())) {
					alert(q_getMsg('lblIndate') + '錯誤。');
					Unlock();
					return;
				}
				if (!q_cd($('#txtOutdate').val())) {
					alert(q_getMsg('lblOutdate') + '錯誤。');
					Unlock();
					return;
				}

				$('#txtComp').val($('#cmbCno').find(":selected").text());
				$('#txtPart').val($('#cmbPartno').find(":selected").text());
				$('#txtJob').val($('#cmbJobno').find(":selected").text());

				if (!emp($('#txtId').val()))
					$('#txtId').val($('#txtId').val().toUpperCase());
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('sss', t_where, 0, 0, 0, "checkSssno_btnOk", r_accy);
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
				if(q_cur==0 || q_cur==4){
					var t_noa = $.trim($('#txtNoa').val()).toUpperCase();
					$('#BarcodeShow').html('<img width="100px" src="https://chart.googleapis.com/chart?chs=100x100&cht=qr&chl='+t_noa+'&chld=L|4">');
				}
				if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1)
					$('.it').css('text-align','left');
					
				if(q_getPara('sys.salb')=='1'){
					$('#textCountry').val($('#cmbCountry').val());
					$('#textTaxtreaty').val($('#cmbTaxtreaty').val());
				}
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
				var isBarCode = (dec(q_getPara('sss.isbarcode'))==1?true:false);
				if(isBarCode== true){
					$('.isBarCode').show();
				}else{
					$('.isBarCode').hide();
				}
				
				if($("#cmbPerson").val()=='外勞'){
					$('#txtPassportno').show();
					$('#lblPassportno').show();
					$('#txtId').hide();
					$('#lblId').hide();
				}else{
                   	$('#txtPassportno').hide();
					$('#lblPassportno').hide();
					$('#txtId').show();
					$('#lblId').show();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var WantDisabledArray = ['btnSsspart', 'btnSaladjust', 'btnLabases','btnSssr','btnSalbs','btnTax'];
				for (var k = 0; k < WantDisabledArray.length; k++) {
					if (q_cur == 1 || q_cur == 2) {
						$("#" + WantDisabledArray[k]).attr('disabled', 'disabled');
					} else {
						$("#" + WantDisabledArray[k]).removeAttr('disabled', 'disabled');
					}
				}
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
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.salbs':
						alert('稅務薪資寫入完畢。');
						break;
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 250px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
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
				width: 850px;
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
				width: 15%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 30%;
				float: left;
			}
			.txt.c3 {
				width: 69%;
				float: left;
			}
			.txt.c4 {
				width: 95%;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.tbbs input[type="text"] {
				width: 98%;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.bbs {
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewNamea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='namea' style="text-align: center;" class="it">~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td><input id="txtNamea" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblPerson" class="lbl"> </a></td>
						<td><select id="cmbPerson" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblId' class="lbl"> </a><a id='lblPassportno' class="lbl"> </a></td>
						<td><input id="txtId"  type="text"  class="txt c1"/><input id="txtPassportno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblBirthday' class="lbl"> </a></td>
						<td><input id="txtBirthday" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBlood' class="lbl"> </a></td>
						<td><select id="cmbBlood" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSex' class="lbl"> </a></td>
						<td><select id="cmbSex" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<td><input id="chkMarried" type="checkbox" style="float: right;"/></td>
						<td><a id='vewMarried'> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMobile1' class="lbl"> </a></td>
						<td><input id="txtMobile1" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMobile2' class="lbl"> </a></td>
						<td><input id="txtMobile2" type="text" class="txt c1"/></td>
						<td><input id="chkIswelfare" type="checkbox" style="float: right;"/></td>
						<td><a id='vewIswelfare'> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_home" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_home" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_conn" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_conn" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEmail" class="lbl"> </a></td>
						<td colspan="5"><input id="txtEmail" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRecord' class="lbl"> </a></td>
						<td colspan="2"><input id="txtSchool" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td colspan="2"><input id="txtAccount" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td>
							<input id="chkIsclerk" type="checkbox" style="float: left;"/>
							<a id='vewIsclerk' style="float: left;" > </a>
						</td>
						<td>
							<input id="chkIssales" type="checkbox" style="float: left;"/>
							<a id='vewIssales' style="float: left;"> </a>
						</td>
						<td><span> </span><a id='lblSalesgroup' class="lbl"> </a></td>
						<td><input id="txtSalesgroup" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td><input id="txtOutdate" type="text" class="txt c1" /></td>
						<td class="isBarCode"><span> </span><a id='lblBarcode' class="lbl"> </a></td>
						<td class="isBarCode"><input id="txtBarcode" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart" type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblJob" class="lbl"> </a></td>
						<td>
							<select id="cmbJobno" class="txt c1"> </select>
							<input id="txtJob" type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblCno" class="lbl"> </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtComp" type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblConn" class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblConntel" class="lbl"> </a></td>
						<td colspan="3"><input id="txtConntel" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblConn2" class="lbl"> </a></td>
						<td><input id="txtConn2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblConntel2" class="lbl"> </a></td>
						<td colspan="3"><input id="txtConntel2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr id='sbutton'>
						<td> </td>
						<td colspan="5">
							<input id='btnSsspart' type="button"/>
							<span> </span>
							<input id='btnSaladjust' type="button"/>
							<span> </span>
							<input id='btnLabases' type="button" />
							<span> </span>
							<input id='btnSssr' type="button" />
							<span> </span>
							<input id='btnTax' type="button" />
							<span> </span>
							<input id='btnSalbs' type="button"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="div_salbs" style="position:absolute; top:300px; left:100px; display:none; width:950px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_salbs" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #C7FAFF;width: 125px;" align="center">所得格式</td>
					<td style="background-color: #C7FAFF;width: 150px;" align="center"><select id="combTypea" class="txt c1"> </select></td>
					<td style="background-color: #f8d463;width: 56px;" align="center">01月<BR>退休金</td>
					<td style="background-color: #f8d463;width: 116px;" align="center"><input id="textRmoney_1" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;width: 50px;" align="center">01月<BR>金額</td>
					<td style="background-color: #f8d463;width: 116px;" align="center"><input id="textSmoney_1" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;width: 50px;" align="center">01月<BR>扣繳</td>
					<td style="background-color: #f8d463;width: 116px;" align="center"><input id="textTmoney_1" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;width: 50px;" align="center">01月<BR>抵繳</td>
					<td style="background-color: #f8d463;width: 116px;" align="center"><input id="textOmoney_1" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center">所得註記</td>
					<td style="background-color: #C7FAFF;" align="center"><select id="combTypeb" class="txt c1"> </select></td>
					<td style="background-color: #f8d463;" align="center">02月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_2" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">02月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_2" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">02月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_2" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">02月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_2" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center">項目代號</td>
					<td style="background-color: #C7FAFF;" align="center"><select id="combTypec" class="txt c1"> </select></td>
					<td style="background-color: #f8d463;" align="center">03月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_3" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">03月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_3" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">03月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_3" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">03月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_3" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center">起迄月份</td>
					<td style="background-color: #C7FAFF;" align="center">
						<input id="textBmon" type="text" class="txt c2"/><a style="float: left;">~</a>
						<input id="textEmon" type="text" class="txt c2"/>
					</td>
					<td style="background-color: #f8d463;" align="center">04月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_4" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">04月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_4" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">04月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_4" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">04月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_4" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"><input id="btnImport_rmoney" type="button" value="填入退休金"></td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textRmoney" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">05月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_5" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">05月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_5" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">05月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_5" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">05月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_5" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"><input id="btnImport_smoney" type="button" value="填入金額"></td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textSmoney" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">06月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_6" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">06月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_6" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">06月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_6" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">06月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_6" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"><input id="btnImport_tmoney" type="button" value="填入扣繳稅額"></td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textTmoney" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">07月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_7" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">07月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_7" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">07月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_7" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">07月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_7" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"><input id="btnImport_tmoney2" type="button" value="填入扣繳%"></td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textTmoney2" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">08月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_8" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">08月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_8" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">08月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_8" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">08月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_8" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"><input id="btnImport_omoney" type="button" value="填入抵繳稅額"></td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textOmoney" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">09月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_9" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">09月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_9" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">09月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_9" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">09月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_9" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center"> </td>
					<td style="background-color: #C7FAFF;" align="center"> </td>
					<td style="background-color: #f8d463;" align="center">10月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_10" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">10月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_10" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">10月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_10" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">10月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_10" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center">金額合計</td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textTotal" type="text" class="txt num c4" disabled="disabled" style="background:RGB(237,237,237);color:green;"/></td>
					<td style="background-color: #f8d463;" align="center">11月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_11" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">11月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_11" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">11月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_11" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">11月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_11" type="text" class="txt num c4"/></td>
				</tr>
				<tr>
					<td style="background-color: #C7FAFF;" align="center">稅額合計</td>
					<td style="background-color: #C7FAFF;" align="center"><input id="textTax" type="text" class="txt num c4" disabled="disabled" style="background:RGB(237,237,237);color:green;"/></td>
					<td style="background-color: #f8d463;" align="center">12月<BR>退休金</td>
					<td style="background-color: #f8d463;" align="center"><input id="textRmoney_12" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">12月<BR>金額</td>
					<td style="background-color: #f8d463;" align="center"><input id="textSmoney_12" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">12月<BR>扣繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textTmoney_12" type="text" class="txt num c4"/></td>
					<td style="background-color: #f8d463;" align="center">12月<BR>抵繳</td>
					<td style="background-color: #f8d463;" align="center"><input id="textOmoney_12" type="text" class="txt num c4"/></td>
				</tr>
				<tr id='salbs_close'>
					<td align="center" colspan='10'>
						<input id="textYear" type="text" style="width: 30px;"/> 年度
						<input id="btnInsert_div_salbs" type="button" value="寫入稅務薪資表">
						<input id="btnClose_div_salbs" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'engow', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'engow_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
			brwCount2 = 0;
			brwCount = -1;			
            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtPrice', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtMoney', 15, 0, 1]
            							, ['txtUprice', 10, 2, 1], ['txtUmount', 10, 2, 1], ['txtUmoney', 15, 0, 1]
            							, ['txtCost', 15, 0, 1] ['txtUcost', 15, 0, 1], ['txtDays', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            aPop = new Array(
				['txtProductno_', '', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']
			);

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if (location.href.indexOf('?') < 0)// debug
                {
                    // location.href = location.href + "?;;;noa='0015'";
                    // return;
                }
                if (!q_paraChk())
                    return;

                main();
            });
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
            }

            function bbsAssign() {/// 表身運算式
                _bbsAssign();
            }

            function btnOk() {
                sum();

                t_key = q_getHref();

                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[0]] = '';
                    return;
                }

                q_getId2('', as);

                return true;

            }

            function btnModi() {
                var t_key = q_getHref();

                if (!t_key)
                    return;

                _btnModi(1);

                for ( i = 0; i < abbsDele.length; i++) {
                    abbsDele[i][bbsKey[0]] = t_key[1];
                }
                $('#btnPlus').click();
            }

            function boxStore() {

            }

            function refresh() {
                _refresh();
            }

            function sum() {
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
            	}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1450px;font-size: 14px;'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center"><a id='lblProductno'> </a></td>
					<td align="center"><a id='lblProduct'> </a></td>
					<td align="center"><a id='lblUnit'> </a></td>
					<td align="center"><a id='lblMount'> </a></td>
					<td align="center"><a id='lblPrice'> </a></td>
					<td align="center"><a id='lblMoney'> </a></td>
					<td align="center"><a id='lblCost'> </a></td>
					<td align="center"><a id='lblUmount'> </a></td>
					<td align="center"><a id='lblUprice'> </a></td>
					<td align="center"><a id='lblUmoney'> </a></td>
					<td align="center"><a id='lblUcost'> </a></td>
					<td align="center"><a id='lblDays'> </a></td>
					<td align="center"><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;font-size: 14px;'>
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold;"  /></td>
					<td style="width:10%;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;"  /></td>
					<td style="width:20%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;"   /></td>
					<td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;"   /></td>
					<td style="width:7%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtPrice.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtMoney.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtCost.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtUmount.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtUprice.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtUmoney.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:7%;"><input class="txt" id="txtUcost.*" type="text" style="width:94%; text-align:right"  /></td>
					<td style="width:4%;"><input class="txt" id="txtDays.*" type="text" style="width:98%;"   /></td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:98%;"  />
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

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
            var q_name = 'engps', t_content = 'field=noa,no2,datea,engno,eng,productno,product,unit,price,money', bbsKey = ['noa', 'no2'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProduct_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='widtd:98%' >
				<tr>
					<td align="center"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style='width:15%;color:Blue;'><a id='lblPorductno'> </a></td>
					<td align="center" style='width:25%;color:Blue;'><a id='lblPorduct'> </a></td>
					<td align="center" style='width:4%;color:Blue;'><a id='lblUnit'> </a></td>
					<td align="center" style='width:10%;color:Blue;'><a id='lblMount'> </a></td>
					<td align="center" style='width:10%;color:Blue;'><a id='lblPrice'> </a></td>
					<td align="center" style='width:12%;color:Blue;'><a id='lblMoney'> </a></td>
					<td align="center" style='width:15%;color:Blue;'><a id='lblEng'> </a></td>
					<td align="center" style='width:10%;color:Blue;'><a id='lblDatea'> </a></td>
				</tr>
				<tr>
					<td style="width:1%;" align="center"><input class="btn"  id="chkSel.*" type="checkbox"  /></td>
					<td><input class="txt" id="txtProductno.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtProduct.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtPrice.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtMoney.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtEng.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td>
						<input class="txt" id="txtDatea.*" type="text" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtNoa.*" type="hidden"/>
						<input class="txt" id="txtNo2.*" type="hidden"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>


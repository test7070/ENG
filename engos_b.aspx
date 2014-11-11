<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'engos', t_content = 'field=noa,no2,datea,engno,eng,unit,price,money', bbsKey = ['noa', 'no2'], as;
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
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" style='color:Blue;' style="width:10%;"><a id='lblDatea'> </a></th>
					<th align="center" style='color:Blue;' style="width:15%;"><a id='lblEngno'> </a></th>
					<th align="center" style='color:Blue;' style="width:20%;"><a id='lblEng'> </a></th>
					<th align="center" style='color:Blue;' style="width:5%;"><a id='lblUnit'> </a></th>
					<th align="center" style='color:Blue;' style="width:15%;"><a id='lblPrice'> </a></th>
					<th align="center" style='color:Blue;' style="width:15%;"><a id='lblMount'> </a></th>
					<th align="center" style='color:Blue;' style="width:20%;"><a id='lblMoney'> </a></th>
				</tr>
				<tr>
					<td>
						<input class="txt" id="txtDatea.*" type="text" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtNoa.*" type="hidden"/>
						<input class="txt" id="txtNo2.*" type="hidden"/>
					</td>
					<td><input class="txt" id="txtEngno.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtEng.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtPrice.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td><input class="txt" id="txtMoney.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>


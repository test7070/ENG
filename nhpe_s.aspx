<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
	<link href="../qbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var q_name = "nhpe_s";
	aPop = new Array(
            	['txtNoa', '', 'nhpe', 'noa,namea','txtNoa,txtNamea', ''],
            	['txtPartno', 'lblPartno', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']
	);
    $(document).ready(function () {
        main();
    });         /// end ready

    function main() {
        mainSeek();
        q_gf('', q_name);
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();
        q_gt('part', '', 0, 0, 0, "");
        $('#txtNoa').focus();
    }
	function q_gtPost(t_name) {
		switch (t_name) {
			case 'part':
				var as = _q_appendData("part", "", true);
				if (as[0] != undefined) {
					var t_partCmb = '@全部';
					for ( i = 0; i < as.length; i++) {
						t_partCmb = t_partCmb + (t_partCmb.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
					}
					q_cmbParse("cmbPartno", t_partCmb);
				}
				break;
		}
	}

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_namea = $('#txtNamea').val();
        t_partno = $('#cmbPartno').val();
        t_rank = $('#txtRank').val();

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("namea", t_namea) + q_sqlPara2("rank", t_rank) + q_sqlPara2("partno", t_partno);

        t_where = ' where=^^' + t_where + '^^ ';
        return t_where;
    }
</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div style='width:400px; text-align:center;padding:15px;' >
       <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
                <td><input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPartno'></a></td>
                <td><select id="cmbPartno" style="width:215px; font-size:medium;"> </select></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblRank'></a></td>
                <td><input class="txt" id="txtRank" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>

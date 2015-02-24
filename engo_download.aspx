<%@ Page Language="C#" Debug="true" responseEncoding=Big5 %>
    <script language="c#" runat="server">
        public void Page_Load()
        {
            try
            {
                string path = @"D:\doc\";
                string filename = HttpUtility.UrlDecode(Request.QueryString["FileName"]);
                string tempname = HttpUtility.UrlDecode(Request.QueryString["TempName"]);
                Response.ContentType = "application/x-msdownload;";
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=" + System.IO.Path.GetFileName(path+filename));
                Response.BinaryWrite(GetFileBits(path+tempname));
                Response.End();
            }
            catch (Exception ex)
            {
            }
            finally
            {
            }          
        }

        private byte[] GetFileBits(string filename)
        {
             byte[] bytes;
             using (System.IO.FileStream file = new System.IO.FileStream(filename, System.IO.FileMode.Open, System.IO.FileAccess.Read))
             {
                  bytes = new byte[file.Length];
                  file.Read(bytes, 0, (int)file.Length);
             }
             return bytes;
        }
        
    </script>
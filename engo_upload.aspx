<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string savepath = @"D:\doc\";

        public class ParaOut {
            public string fn1;
            public string fn2;
        }
        
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            ParaOut po = new ParaOut();
            try
            {
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);

                if (System.IO.Directory.Exists(savepath))
                {
                    //資料夾存在
                }
                else
                {
                    //新增資料夾
                    System.IO.Directory.CreateDirectory(savepath);
                }
                
                po.fn1 = HttpUtility.UrlDecode(Request.Headers["FileName"]);
                po.fn2 = System.IO.Path.GetRandomFileName();

                //parseFile(HttpUtility.UrlDecode(Request.Headers["FileName"]),encoding.GetString(formData));
                parseFile(HttpUtility.UrlDecode(po.fn2), encoding.GetString(formData));

                Response.Write(serializer.Serialize(po));
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
        public void parseFile(string filename,string data)
        {
            byte[] formData = Convert.FromBase64String(data.Substring(data.IndexOf("base64") + 7));
 
            System.IO.FileStream aax = new System.IO.FileStream(savepath + filename, System.IO.FileMode.OpenOrCreate);
            System.IO.BinaryWriter aay = new System.IO.BinaryWriter(aax);
            aay.Write(formData);
            aax.Close();
        }
        
        
    </script>

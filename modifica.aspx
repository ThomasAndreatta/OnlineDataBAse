<%@ Page Language="C#" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.Common" %>
<%@ Import namespace="System.Data.OleDb" %>


<script runat="server">	
    void DemoModificaDatiAlunno()
    {
        string id = Request.QueryString["IDAlunno"];

        string percorso = Server.MapPath("App_Data\\Alunni2004.mdb");
        string connString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source="+percorso;
        using (OleDbConnection connection = new OleDbConnection(connString))
        {
            connection.Open();
            OleDbDataReader myReader = null;
            OleDbCommand command = new OleDbCommand("SELECT * from alunni WHERE IDAlunno="+id+"", connection);

            myReader = command.ExecuteReader();
            string anno="";
            string spec="";
            string sezione = "";
            string cognome="";
            string nome="";
            string resid="";
            while (myReader.Read())
            {
                anno =  myReader["Anno"].ToString();
                sezione= myReader["Sezione"].ToString();
                spec = myReader["Specializzazione"].ToString();
                cognome = myReader["Cognome"].ToString();
                nome=    myReader["Nome"].ToString();
                resid=  myReader["Residenza"].ToString();

            }

            Response.Write(id +"-"+anno + "-"+sezione+ "-"+spec+ "-"+cognome+ "-"+nome+ "-"+resid+ "-");
        }

    }
    void mofidica(string id, string nome, string cognome, string classe)
    {
        string idc = Request.QueryString["IDAlunno"];

        string percorso = Server.MapPath("App_Data\\Alunni2004.mdb");
        string connString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + percorso;
        using (OleDbConnection connection = new OleDbConnection(connString))
        {
            connection.Open();
            OleDbDataReader myReader = null;
            OleDbCommand command = new OleDbCommand("UPDATE alunni SET IDAlunno=" + id + "", connection);

            myReader = command.ExecuteReader();
        }
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    
    <title >Pagina senza titolo</title>
    <style type="text/css">
        .auto-style2 {
            height: 24px;
            width: 217px;
        }
        .auto-style4 {
            width: 150px;
            height: 41px;
        }
        .auto-style6 {
            width: 55px;
            height: 41px;
        }
        .auto-style7 {
            width: 221px;
            margin-left: 0px;
        }
        .auto-style9 {
            width: 213px;
        }
        </style>
</head>
<body >
    <% DemoModificaDatiAlunno(); %>
    <form id="form1" runat="server">
<fieldset>
<legend id="titolo"> Modifica Alunno</legend>
       <table>
            <tr> 
                <td style="width: 150px; height: 24px"> </td>
                <td style="text-align: left" class="auto-style2"> 
                </td>
            </tr>
            
            <tr>
                <td style="width: 150px; height: 24px">ANNO:</td>
                <td style="text-align: left" class="auto-style2">
                    <select id="Select1" name="anno">
                        <option selected="selected" value="nome">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px"> </td>
                <td style="text-align: left" class="auto-style2">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px">SEZIONE:</td>
                <td style="text-align: left" class="auto-style2">
                    <select id="Select2" name="sezione">
                        <option selected="selected" value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                        <option value="E">E</option>
                        <option value="F">F</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px"> </td>
                <td style="text-align: left" class="auto-style2">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px">  SPECIALIZZAZIONE:</td>
                <td style="text-align: left" class="auto-style2">
                    <select id="Select3"   name="specializzazione">
                        <option selected="selected" value="BIE">Biennio</option>
                        <option value="LST">Liceo</option>
                        <option value="ELE">Elettronica</option>
                        <option value="INF">Informatica</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px"> </td>
                <td style="text-align: left" class="auto-style2">
                </td>
            </tr>            
                 <tr>
                <td style="width: 150px; height: 24px">COGNOME:</td>
                <td style="text-align: left" class="auto-style2">
                    &nbsp;<input id="Text1" type="text" class="auto-style9" /></td>
            </tr>
                 <tr>
                <td style="width: 150px; height: 24px">&nbsp;</td>
                <td style="text-align: left" class="auto-style2">
                    &nbsp;</td>
            </tr>
                 <tr>
                <td style="width: 150px; height: 24px">NOME:</td>
                <td style="text-align: left" class="auto-style2">
                    &nbsp;<input id="Text2" type="text" class="auto-style9" /></td>
            </tr>
                 <tr>
                <td style="width: 150px; height: 24px">&nbsp;</td>
                <td style="text-align: left" class="auto-style2">
                    &nbsp;</td>
            </tr>
                 <tr>
                <td style="width: 150px; height: 24px">RESIDENZA :</td>
                <td style="text-align: left" class="auto-style2">
                    <input id="Text3" type="text" class="auto-style7" />
                </td>
            </tr>
                 <tr>
                <td style="width: 150px; height: 24px">&nbsp;</td>
                <td style="text-align: left" class="auto-style2">
                    &nbsp;</td>
            </tr>
                 <tr>
                <td class="auto-style4">Data Nascita:</td>
                     <td class="auto-style6">                                                   
                            <input type="date" name="bday" min="1900-01-01" max ="2019-01-01"></td>
            </tr>
            <tr>
                <td colspan=2   style=" height: 24px" align="center"> &nbsp;</td>
            </tr>
            <tr>
                <td colspan=2   style=" height: 24px" align="center"> <button onclick="Modifica()">Click me</button>  </td>
                <!--<td style="width: 208px; height: 24px; text-align: left">
                </td>-->
            </tr>
        </table>
  </fieldset>
    </form>
</body>

</html>

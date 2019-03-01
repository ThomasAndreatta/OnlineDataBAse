<%@ Page Language="C#" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Data.Common" %>
<%@ Import namespace="System.Data.OleDb" %>           <!-- namespace per utilizzare DB Access -->
<!--<%@ Import namespace="System.Data.SqlClient"%>--> <!-- namespace per utilizzare DB SqlEXPRESS -->


<script runat="server">	
				
	     void DemoDataReader()
		{
            // 1. lettura parametri letti dalla form HTML (manca controllo nel caso di dati sono inseriti)
            string anno = Request.Form["anno"];
            string specializzazione = Request.Form["specializzazione"];
            string sezione = Request.Form["sezione"];
             
            // FASE PREPARATORIA - INIZIALIZZAZIONE
            // 2. viene individuato il percorso relativo al file di database sul server 
            //string percorso = Server.MapPath("App_Data\\Alunni2004.mdf"); //Database SQL-Express
            string percorso = Server.MapPath("App_Data\\Alunni2004.mdb");   //Database Access
             
            // 3. inizializzazione della stringa di connessione 
            string s_JetCxnString = @"Provider=Microsoft.JET.OLEDB.4.0; Data Source="+percorso; // stringa connessione per db ACCESS 
            //string CxnString =@"Data Source=.\SQLEXPRESS;AttachDbFilename="+percorso+";Integrated Security=True;User Instance=True"; // stringa connessione per db SQL-Express
             
            // 4. creazione dell'oggetto "connessione" 
            OleDbConnection cxn = new OleDbConnection(s_JetCxnString); // connessione al db Access mediante net provider che "ricicla" interfaccia OLEDB
            //SqlConnection cxn = new SqlConnection(CxnString);        // connessione al db SQL-Express mediante NET provider SQL 
            
            try
			{
				// 5. Apertura di una connessione con il DATABASE (Access o SQL EXPRESS a seconda dei casi)
				cxn.Open();
				
				// 6. Creazione della stringa SQL per interagire con il DB, in questo caso si vogliono estrarre dei dati e quindi
                //    si scrive una query di selezione 
                
               // 6 a. modalità che funziona ma DA EVITARE (concatenare usando l'operatore stringhe '+')
                string queryString = "SELECT * FROM alunni WHERE anno="+anno+" AND specializzazione='"+specializzazione+"' AND sezione='"+sezione+"'";

               // 6 b. modalità meno problematica della precedente ma comunque sconsigliata causa formato diverso dei campi da analizzare
               // string queryString = String.Format("SELECT * FROM alunni WHERE anno={0} AND specializzazione='{1}' AND sezione='{2}'", anno, specializzazione, sezione);
               
               //6 c. uso dei parametri  posizionali, è la modalità caldamente consigliata !!!       
               //string queryString = "SELECT * FROM alunni WHERE anno=? AND specializzazione=? AND sezione=?";
                
               // NOTA: i parametri denominati si possono utilizzare in SQL NET provider, Firebird NET provider, da verificare nella nuova versione di
               //       Access 2007 o 2010 
                
               // 7. si prepara il comando da inviare al DataBase attraverso la connessione creata 
               OleDbCommand cmdDb = new OleDbCommand(queryString, cxn); // db Access
               //SqlCommand cmdSql = new SqlCommand(queryString, cxn);  // db SQL-Express
                // preparo i parametri posizionali  da usare solo se viene utilizzata la query in modalità 6.c
                /* c.  cmdDb.Parameters.Add("@anno", anno);
                       cmdDb.Parameters.Add("@spec", specializzazione);
                       cmdDb.Parameters.Add("@sezi", sezione);
                  */ 
                    
               // 8. i dati (RecordSet) estratti mediante query dal database verranno salvati in memoria in un oggetto DataReader
			     OleDbDataReader myReader; // db Access
                 //SqlDataReader myReader; // db SQL-Express
             // FINE FASE PREPARATORIA - INIZIALIZZAZIONE   
            
             // INIZIO FASE INTERAZIONE CON IL DATABASE       
                // 9. PUNTO FONDAMENTALE: viene inviato il comando al DB, in risposta vengono restituiti (nel nostro caso) i record che 
                //                        soddisfano i criteri di selezione impostati nella query 
                 myReader = cmdDb.ExecuteReader();  // db Access
                 //myReader = cmdSql.ExecuteReader(); // db SQL-Express
             // FINE FASE INTERAZIONE CON IL DATABASE
                   
                
             // INIZIO FASE RISPOSTA AL CLIENT : visualizzazione dei risultati della query in modalità "manuale" cioè senza oggetti ASP.NET   
                // I dati vengono mostrati in una tabella HTML, si fa riferimanto anche al foglio CSS associato alla pagina 
                Response.Write("<table border='1' class='SfondoTabella' >");
                // intestazione della tabella HTML con i nomi dei campi della tabella del DATABASE 
                Response.Write("<tr>");
            
                Response.Write("<th>" + myReader.GetName(5) + "</th>");
                Response.Write("<th>" + myReader.GetName(1) + "</th>");
                Response.Write("<th>" + myReader.GetName(2) + "</th>");
                Response.Write("<th>" + myReader.GetName(0) + "</th>");
                Response.Write("<th>" + myReader.GetName(3) + "</th>");
                Response.Write("<th>" + myReader.GetName(4) + "</th>");
                Response.Write("<th>" + myReader.GetName(6) + "</th>");
                Response.Write("<th>" + myReader.GetName(7) + "</th>");
                Response.Write("<th>" + myReader.GetName(8) + "</th>");
                Response.Write("<th> &nbsp </th>");                 
                Response.Write("</tr>");
                int righe = 0; // contatore dei record trovati, usato anche per gestire sfondo righe alternate 
               
                // Importante: scansione sequenziale del DATAREADER per mostrare tutti i record trovati
                //             visualizzazione mediante nome campo, attenti conversione !
                while (myReader.Read())  // ad ogni read il cursore passa alla riga (record) successiva
                {
                    if ((righe % 2) == 0)
                       Response.Write("<tr class='TblRPari'>");
                    else
                       Response.Write("<tr class='TblRDispari'>");
                    righe++;   
                    // visualizzazione dei valori presenti nei campi indicati tra virgolette     
                    Response.Write("<td>" + myReader["IDAlunno"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Anno"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Sezione"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Specializzazione"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Cognome"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Nome"].ToString() + "</td>");
                    Response.Write("<td>" + myReader["Residenza"].ToString() + "</td>");
                    // attenzione (in generale) al campo data !!!
                    // Response.Write("<td>" + myReader["DataN"].ToString() + "</td>");
                    Response.Write("<td>" + myReader.GetDateTime(7).ToShortDateString() + "</td>");
                   
                    // da fare >>>>>> invece del link alla foto mostrare la FOTO ! <<<<<<<
                    Response.Write("<td>" + myReader["Foto"].ToString() + "</td>");                      
                    
                    //osservare l'uso dell'operatore '+' per concatenare stringhe ->SCONSIGLIATO !!!  
                    Response.Write("<td> <a href=\"modifica.aspx?IDAlunno="+myReader["IDAlunno"].ToString()+"\"> Modifica </a> <br>");
                    
                    //osservare l'uso di String.Format per semplificare la gestione delle operazioni di concatenazione tra stringhe ->CONSIGLIATO !!! 
                    //Response.Write("<a href='elimina.aspx?IDAlunno="+myReader["IDAlunno"].ToString()+"'> Cancella </a> </td>");
                    string stringa = String.Format("<a href=\"elimina.aspx?IDAlunno={0}\"> Cancella </a> </td> ", myReader["IDAlunno"]);
                    Response.Write(stringa);
                    
                    Response.Write("</tr>");
                }
                Response.Write("</table>");
            }
			
			catch (Exception e)
			{
				Response.Write("Exception, msg = " + e.Message);
			}
            finally
            {
                // chiudere SEMPRE la connessione
                cxn.Close();
            } 
	
		}

</script>
<html>
<head>
    <title>Accesso ai dati DEMO</title>
    <link rel="stylesheet" type="text/css" href="mioStile.css" />
</head>
<body>
  <div align="center">
<h3>Lettura dati da DB con DataReader</h3>
<% DemoDataReader(); %>
</div>

</body>
</html>

Imports System.Data 
Imports System.Data.OleDb 

Public Class CreatingConnections 

'Creating a connection object 
Private OleDbConnection1 As OleDbConnection 

Public Sub Connecting() 

'Creating a connection string 
OleDbConnection1 = New OleDbConnection 

'The connection string can be found in the server properties window, 
'under the Connection tab, in the Connection String text box. 
OleDbConnection1.ConnectionString =  
"Provider=Microsoft.Jet.OLEDB.4.0; Data Source=|DataDirectory|mydb.mdb" 

'Open the connection 
OleDbConnection1.Open() 

'Close the connection 
OleDbConnection1.Close() 

End Sub

End Class
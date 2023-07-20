import java.sql.{Connection, DriverManager};
import java.util.Properties;

object Connections{
  def getConnection(): Connection = {
    val connectionProps = new Properties()
    connectionProps.put("user", "root")
    connectionProps.put("password", "password")

    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance
      DriverManager.getConnection("jdbc:mysql://localhost:3306/database_name", connectionProps)
    } catch {
      case e: Exception => e.printStackTrace
    }
  }
  
  def main(args: Array[String]): Unit = {
    val connection = getConnection();
    println(connection)
  }
}
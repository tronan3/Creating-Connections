// Imports
import java.net.ConnectException
import java.net.Socket
import java.net.ServerSocket
import java.io.IOException
import java.io.InputStream
import java.io.OutputStream
import java.io.BufferedReader
import java.io.BufferedWriter
import java.io.PrintWriter

// Define constants for socket ports
val SERVER_PORT = 8080
val CLIENT_PORT = 8081

// Create ServerSocket and Socket objects
val serverSocket = ServerSocket(SERVER_PORT)
val clientSocket = Socket(SERVER_PORT)

// Establish a connection between server and client
val serverConnection = serverSocket.accept()
val clientConnection = clientSocket.connect()

// Create input and output streams 
val serverInputStream = serverConnection.getInputStream()
val serverOutputStream = serverConnection.getOutputStream()
val clientInputStream = clientConnection.getInputStream()
val clientOutputStream = clientConnection.getOutputStream()

// Wrap the input and output streams in BufferedReader and 
// BufferedWriter objects, respectively
val serverReader = BufferedReader(serverInputStream)
val serverWriter = BufferedWriter(serverOutputStream)
val clientReader = BufferedReader(clientInputStream)
val clientWriter = BufferedWriter(clientOutputStream)

// Establish communication between server and client
try {
  while (true) {
    val serverMessage = serverReader.readLine()
    clientWriter.write(serverMessage)
    clientWriter.flush()
    val clientMessage = clientReader.readLine()
    serverWriter.write(clientMessage)
    serverWriter.flush()
  }
} catch (e: ConnectException) {
  // Handle connection exception
} catch (e: IOException) {
  // Handle IO exception
} finally {
  // Close the sockets
  serverSocket.close()
  clientSocket.close()
}
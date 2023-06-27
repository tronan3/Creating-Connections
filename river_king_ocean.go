package main

import (
	"fmt"
	"net"
	"os"
)

// Create a connection and get basic information about it.
func main() {

	// Create a TCP connection to 127.0.0.1 on port 8080
	conn, err := net.Dial("tcp", "127.0.0.1:8080")
	if err != nil {
		fmt.Println("Error establishing connection: ", err)
		os.Exit(1)
	}
	defer conn.Close()

	// Get local address
	localAddr := conn.LocalAddr().String()
	fmt.Println("Local Address:", localAddr)

	// Get remote address
	remoteAddr := conn.RemoteAddr().String()
	fmt.Println("Remote Address:", remoteAddr)

	// Read from the connection
	data := make([]byte, 1024)
	_, err = conn.Read(data)
	if err != nil {
		fmt.Println("Error reading from connection: ", err)
		os.Exit(1)
	}
	fmt.Printf("Data read: %s\n", data)

	// Write to the connection
	_, err = conn.Write([]byte("Hello, world!"))
	if err != nil {
		fmt.Println("Error writing to connection: ", err)
		os.Exit(1)
	}

	// Close the connection
	err = conn.Close()
	if err != nil {
		fmt.Println("Error closing connection: ", err)
		os.Exit(1)
	}
}
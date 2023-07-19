#include<iostream>
#include<string>
#include<vector>

using namespace std;

class Connection {
private:
	string hostName;
	int port;
public:
	Connection(string hostName, int port) {
		this->hostName = hostName;
		this->port = port;
	}
	
	void connect() {
		// set up connection to hostName:port
	}
	
	string getHostName() {
		return hostName;
	}
	
	int getPort() {
		return port;
	}
};

class ConnectionManager {
private:
	vector<Connection> connections;
public:
	ConnectionManager() {
		// initialize vector
	}

	void addConnection(string hostName, int port) {
		// add new connection
		Connection connection(hostName, port);
		connections.push_back(connection);
	}

	Connection getConnection(int index) {
		// return connection at specified index
		return connections[index];
	}
	
	int getNumConnections() {
		// return number of connections
		return connections.size();
	}
};

int main() {
	ConnectionManager connectionManager;
	
	connectionManager.addConnection("localhost", 8080);
	connectionManager.addConnection("example.com", 80);
	
	Connection connection = connectionManager.getConnection(0);
	connection.connect();
	
	cout << "Connecting to " << connection.getHostName() << ":" << connection.getPort() << endl;
	
	return 0;
}
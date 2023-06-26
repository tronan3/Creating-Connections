//Creating Connections in JavaScript

// 1.Creating a Server
const http = require('http');
const server = http.createServer((request, response) => {
  response.writeHead(200, { 'Content-Type': 'text/plain' });
  response.end('Hello World\n');
});
server.listen(3000, '127.0.0.1');

// 2. Creating a Client
const http = require('http');
const options = {
    hostname: 'localhost',
    port: 3000,
    method: 'GET',
    path: '/'
};
const req = http.request(options, (res) => {
    console.log(`STATUS: ${res.statusCode}`);
    console.log(`HEADERS: ${JSON.stringify(res.headers)}`);
    res.setEncoding('utf8');
    res.on('data', (chunk) => {
        console.log(`BODY: ${chunk}`);
    });
    res.on('end', () => {
        console.log('No more data in response.')
    });
});

req.on('error', (e) => {
    console.error(`problem with request: ${e.message}`);
});

// 3. Creating a Basic Socket Connection
var net = require('net');

// create a socket to connect
var client = new net.Socket();

// connect to the specified port on localhost
client.connect( 3000, 'localhost', function() {
    
    // send a message when connected
    client.write('Hello, server! Love, Client.');
});

client.on('data', function(data) {
    
     // print when received
    console.log('Received: ' + data);
    
    // close the socket after receiving
    client.destroy();
});

client.on('close', function() {
    
    // log when closed
    console.log('Connection closed');
});

// 4. Establishing a WebSocket Connection
// Using the w3c-compatible WebSocket class
var WebSocket = require('ws');

// create a web socket to listen on port 3000
var ws = new WebSocket.Server({port: 3000});

// on connection, run the ws connection handler
ws.on('connection', (ws) => {
    
    // log the connection
    console.log('client connected');
    
    // handle messages received
    ws.on('message', (message) => {
        console.log('received: %s', message);
    });
    
    // on close of the websocket
    ws.on('close', () => {
        
        // log the closure
        console.log('Client disconnected');
    });
});

// 5. Establishing a Socket.io Connection
//Using the popular Socket.io library
var io = require('socket.io')(3000);

// handle incoming connections
io.on('connection', (socket) => {
    
    // log the connection
    console.log('client connected');
    
    // handle messages receieved
    socket.on('message', (message) => {
        console.log('received: %s', message);
    });
    
    // on close, log it
    socket.on('disconnect', () => {
        console.log('Client disconnected');
    });
});

// 6. Setting up Routes
// Using the popular Express library
const express = require('express');
const app = express();

// set up a route on localhost
app.get('/', (req, res) => {
    
    // send a response
    res.send('Hello World');
});

// set up a route with parameters
app.get('/users/:name', (req, res) => {
    
    // query the database
    const result = loadUserFromDatabase(req.params.name);
    
    // send the response
    res.send(result);
});

// start the server
app.listen(3000, () => {
    console.log('Server is listening on port 3000');
});

// 7. Creating a Database Connection
// Using the popular MySQL library
const mysql = require('mysql');

// create the connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'db_user',
    password: 'password',
    database: 'my_database'
});

// open the connection
connection.connect(function(err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    console.log('connected as id ' + connection.threadId);
});

// perform a query
connection.query('SELECT * FROM my_table', function (err, rows, fields) {
    if (err) throw err;
    
    console.log('Table data: ', rows);
});

// close the connection
connection.end(function(err) {
    if (err) {
        console.log('error disconnecting: ' + err.stack);
        return;
    }
    console.log('connection closed');
});
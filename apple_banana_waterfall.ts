// Connecting to a Database
// Create a connection string
const connectionString = 'Host = localhost; User = myusername; Password = mypassword; Database = mydatabase';

// Connect to the database
const conn = new Connection(connectionString);
conn.open();

// Query the database
const queryString = 'SELECT * FROM mytable';
const query = new Query(queryString);
const queryResult = conn.query(query);

// Close the connection
conn.close();

// Looping Through Data
// Create an array of objects
const data = [
	{ name: 'John', age: 20 },
	{ name: 'Jane', age: 25 },
	{ name: 'Jack', age: 30 }
];

// Loop through the array
for (let i = 0; i < data.length; i++) {
  console.log(`Name: ${data[i].name}, Age: ${data[i].age}`);
}

//Creating Objects
// Create an empty object
const myObject = {};

// Add properties to the object
myObject.name = 'John';
myObject.age = 20;

// Access object properties
console.log(myObject.name); // Outputs 'John'

// Setting and Retrieving Values
// Create an object
const myObj = {
  propName: 'value'
};

// Set a new value
myObj.propName = 'newValue';

// Retrieve the value
console.log(myObj.propName); // Outputs 'newValue'

//Creating Arrays
// Create an empty array
const myArray = [];

// Add elements to the array
myArray.push('John');
myArray.push('Jane');
myArray.push('Jack');

// Access array elements
console.log(myArray[1]); // Outputs 'Jane'

// Iterating Over Arrays
// Create an array of numbers
const numbers = [1,2,3,4,5];

// Iterate over the array
for (let i = 0; i < numbers.length; i++) {
  console.log(numbers[i] * 2);
}

// Outputs 
// 2
// 4
// 6
// 8
// 10

// Creating Functions
// Create a function
function addTwo(num) {
  return num + 2;
}

// Call the function
const result = addTwo(6);
console.log(result); // Outputs 8
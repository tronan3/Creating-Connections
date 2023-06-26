#!/usr/bin/perl

#Create a new database connection
$DSN = 'dbi:mysql:database=mydbname;host=localhost';
$dbh = DBI->connect($DSN,$USER,$PASS);
 
#Populate a statement handle
$sth = $dbh->prepare('SELECT * FROM mytable');
 
#Execute the statement
$sth->execute();
 
#Fetch the results
while (my ($row) = $sth->fetchrow_array) {
   print "Found a row: $row\n";
}
 
#Loop through the results
while (my ($field1, $field2, $field3) = $sth->fetchrow_array) {
   print qq{Found a row: $field1, $field2, $field3\n};
}
 
#Close the statement
$sth->finish;
 
#Disconnect from the database
$dbh->disconnect;
 
#Create a table
$dbh->do('CREATE TABLE mytable (id INT, name VARCHAR(255), price DECIMAL(7,2))');
 
#Insert data into the table
$dbh->do('INSERT INTO mytable (id, name, price) VALUES (1, "widget", 5.99)');
 
#Update data in the table
$dbh->do('UPDATE mytable SET price = 6.99 WHERE id = 1');
 
#Delete data from the table
$dbh->do('DELETE FROM mytable WHERE id = 1');
 
# Truncate the table
$dbh->do('TRUNCATE mytable');
 
#Drop the table
$dbh->do('DROP TABLE mytable');
 
#Create a new database
$dbh->do('CREATE DATABASE new_database');
 
#Using transactions
$dbh->begin_work;
$dbh->do('INSERT ...');
$dbh->do('UPDATE ...');
$dbh->commit;
 
#Using transaction with eval
eval {
   $dbh->begin_work;
   $dbh->do('INSERT ...');
   $dbh->do('UPDATE ...');
   $dbh->commit;
};
 
if ($@) {
   my $errstr = $@;
   $dbh->rollback;
   die $errstr;
}
 
#Fetch a single row as a hash reference
my $row = $sth->fetchrow_hashref;
 
print qq{Found a row: id = $row->{id}, name = $row->{name}, price = $row->{price}\n};
 
#Fetching multiple records
my @rows = @{ $sth->fetchall_arrayref({}) };
 
foreach my $row (@rows) {
   print qq{Found a row: id = $row->{id}, name = $row->{name}, price = $row->{price}\n};
}
 
#Retrieve the last inserted id
my $last_insert_id = $dbh->last_insert_id;
 
#Retrieve the number of rows affected by the last query
my $rows_affected = $dbh->rows;
 
#Retrieve the insert id from a tables auto increment column
my $statement = "INSERT INTO mytable (name, price) VALUES (?, ?)";
my $sth = $dbh->prepare($statement);
$sth->execute('widget', 5.99);
my $last_insert_id = $dbh->{'mysql_insertid'};
 
#Retrieve the number of columns in a result set
my $num_cols = $sth->{'NUM_OF_FIELDS'};
 
#Retrieve the column names in a result set
my @column_names = @{ $sth->{'NAME'} };
 
#Retrieve the column types in a result set
my @column_types = @{ $sth->{'TYPE'} };
 
#Retrieve the number of parameters in a prepared statement
my $num_params = $sth->{'NUM_OF_PARAMS'};
 
#Retrieve the statement used
my $statement = $sth->{'Statement'};
 
#Retrieve the database handle
my $dbh = $sth->{'Database'};
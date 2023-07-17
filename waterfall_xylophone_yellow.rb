class CreateConnection 
  attr_accessor :host, :port, :username, :password
  
  def initialize(host, port, username, password)
    @host = host 
    @port = port
    @username = username 
    @password = password 
  end 

  def connect 
    puts "Connecting to #{host}:#{port}"
    
    if @username && @password 
      puts "Using username: #{@username}, password: #{@password}"
    end 
    
    begin
      connection = TCPSocket.open(@host, @port)
      puts "Connected successfully!"
      connection
    rescue SocketError
      abort "Could not connect to server #{@host}:#{@port}"
    end
  end

  def send(msg)
    begin
      connection.puts(msg)
    rescue => e
      puts "Error sending message: #{e.message}"
    end 
  end 

  def recv 
    begin
      msg = connection.recv(1024)
    rescue => e
      puts "Error receiving message: #{e.message}"
    end
  end 

  def close 
    begin
      connection.close
    rescue => e
      puts "Error closing connection: #{e.message}"
    end
  end 

end
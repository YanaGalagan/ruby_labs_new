# frozen_string_literal: true
class DBUniversity
  private_class_method :new
  @instance_mutex = Mutex.new

  #организует подключение, чтобы не делать много подключений
  def initialize
    @client = SQLite3::Database.open '/Users/Lenovo/untitled/university.sql'
    @client.results_as_hash = true
  end

  #обеспечивает принцип одиночки
  def self.instance
    return @instance if @instance

    @instance_mutex.synchronize do
      @instance ||= new
    end
    @instance
  end

  def prepare_exec(statement, *params)
    @client.prepare(statement).execute(*params)
  end

  def query(statement)
    @client.query(statement)
  end


end

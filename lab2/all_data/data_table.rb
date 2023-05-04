# frozen_string_literal: true

class DataTable

  attr_reader :str_count, :st_count

  def initialize(table)
    self.str_count = table.length

    max_c=0
    table.each do |el|
      max_c = el.length if el.size > max_c
    end
    self.st_count = max_c
    self.table = table
  end


  def get_elem(str, st)
    return nil if str>=str_count
    return nil if st>=st_count
    table[str][st]
  end

  def to_my_array
    table.dup
  end

  def to_s
    table.map { |row| "[#{row.join(', ')}]" }.join("\n")
  end


  private
  attr_accessor :table
  attr_writer :str_count, :st_count

end

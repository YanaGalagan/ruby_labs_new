# frozen_string_literal: true

class DataList
  private_class_method :new
  attr_writer :list
  def initialize(objects)
    self.sel_objects = []
    self.list = objects
    @observers = []
  end

  def add_observer(observer)
    @observers.append(observer)
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end
  def notify
    @observers.each { |observer| observer.on_datalist_changed(get_data) }
  end
  def select(number)
    raise ArgumentError, "arg 'number' not Integer" if number.class != Integer
    sel_objects.append(number)
  end

  def get_selected
    list_id=[]
    sel_objects.each do |i|
      list_id.append(list[i].id)
    end
    list_id
  end

  def get_data
    result = []
    id = 0
    list.each do |o|
      elem = []
      elem << id
      # * необходима так как, если нам передадут [1,2,3], то передастся row.push(1,2,3)
      elem.push(*table_fields(o))
      result << elem
      id += 1
    end
    DataTable.new(result)
  end

  def replace_objects(objects)
    self.list = objects.dup
    notify
  end
  protected
  def get_names

  end

  def table_fields(object)
    []
  end

  private
  attr_accessor :sel_objects
  attr_reader :list
end

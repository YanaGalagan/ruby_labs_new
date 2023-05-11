# frozen_string_literal: true

class StudentListBase

  attr_writer :data_type

  # конструктор
  def initialize(data_type)
    self.students = []
    self.this_id = 1
    self.data_type = data_type
  end

  def load_from_file(file_address)
    list = data_type.string_to_list(File.read(file_address))
    self.students = list.map{ |i|
      Student.new(**i)
    }
    new_this_id
  end

  def save_to_file(file_address)
    list = students.map(&:to_hash)
    File.write(file_address, data_type.list_to_string(list))
  end

  def student_by_id(student_id)
    students.detect { |student_i| student_i.id == student_id}
  end

  def sort_students
    students.sort_by(&:short_name)
  end

  def add_student(student)
    student.id = this_id
    students << student
    self.this_id += 1
  end

  def replace_student(id, student)
    this_student = students.find_index {
      |stud|
      stud.id == id
    }
    students[this_student] = student
  end

  def delete_student(id)
    students.reject!{|stud| stud.id == id}
  end

  def get_student_short_count
    students.size
  end

  def get_k_n_student_short_list(page, n, data_list)
    page_list = students[(page-1)*n, n].map{|st| StudentShort.new(st)}
    return DataListStudentShort.new(page_list) if data_list.nil?
    data_list.replace_objects(page_list)
    data_list
  end

  protected

  attr_accessor :students, :this_id

  private

  def new_this_id
    self.this_id = students.max_by(&:id).id.to_i + 1
  end
  attr_reader :data_type
end

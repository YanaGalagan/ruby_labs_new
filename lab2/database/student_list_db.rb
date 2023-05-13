# frozen_string_literal: true
require_relative 'db_university'
require 'json'
require 'sqlite3'
class StudentListDBAdapter

  def initialize
    self.client = DBUniversity.instance
  end

  def into_hash(arr)
    attrs = {}
    i=0
    %i[id first_name middle_name surname phone_number telegram mail git].each do |attr|
      attrs[attr] = arr[i] unless arr[i].nil?
      i=i+1
    end
    attrs
  end

  def student_by_id(id_student)
    hash = client.prepare_exec('SELECT * FROM students WHERE id = ?',id_student).first
    hash = into_hash(hash)
    return nil if hash.nil?

    Student.new(**hash)
  end

  def add_student(student)
    st = client.prepare_exec('insert into students (first_name, middle_name, surname, phone_number,
                          telegram, mail, git) VALUES (?, ?, ?, ?, ?, ?, ?)',*student_attr(student))
  end

  def delete_student(id_student)
    client.prepare_exec('DELETE FROM students WHERE id = ?', id_student)
  end

  def replace_student(id_student, student)
    st ='UPDATE students SET first_name=?, middle_name=?, surname=?, phone_number=?, telegram=?, mail=?, git=? WHERE id=?'
    client.prepare_exec(st,*student_attr(student), id_student)
  end

  def count_student
    client.query('SELECT COUNT(id) FROM students').next[0]
  end

  def get_k_n_student_short_list(k,n,data_list=nil )

    offset = (k - 1) * n
    students = client.prepare_exec('SELECT * FROM students LIMIT ?, ?', offset, n)

    slice = students.map { |h|
      h = h.transform_keys(&:to_sym)
      StudentShort.new(Student.into_hash(h))
    }
    return DataListStudentShort.new(slice) if data_list.nil?

    data_list.replace_objects(slice)
    data_list
  end



  private

  attr_accessor :client
  def student_attr(student)
    [student.first_name, student.middle_name, student.surname,
     student.phone_number, student.telegram,
     student.mail, student.git]
  end

end

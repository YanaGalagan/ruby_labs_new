# frozen_string_literal: true

class StudentList

  def initialize(adapter)
    @adapter = adapter
  end

  def student_by_id(id_student)
    @adapter.student_by_id(id_student)
  end

  def add_student(student)
    @adapter.add_student(student)
  end

  def delete_student(id_student)
    @adapter.delete_student(id_student)
  end

  def replace_student(id_student, student)
    @adapter.replace_student(id_student, student)

  end

  def count_student
    @adapter.count_student
  end

  def get_k_n_student_short_list(k,n, data_list=nil)
    @adapter.get_k_n_student_short_list(k,n, data_list)
  end

end
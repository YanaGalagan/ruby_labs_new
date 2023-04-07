# frozen_string_literal: true

class StudentListDB

  def initialize(address)
    self.client = SQLite3::Database.open address
  end

  def student_by_id(id_student)
    client.results_as_hash = true
    hash = client.prepare('SELECT * FROM students WHERE id = ?').execute(id_student).first
    client.results_as_hash = false
    return nil if hash.nil?

    Student.new(**hash)
  end

  def add_student(student)
    st = client.prepare('insert into students (first_name, middle_name, surname, phone_number,
                          telegram, mail, git) VALUES (?, ?, ?, ?, ?, ?, ?)')
    st.execute(*student_attr(student))
    self.client.query('SELECT seq from sqlite_sequence where name = "students"').first.first[1]
  end

  def delete_student(id_student)
    st = self.client.prepare('DELETE FROM students WHERE id = ?')
    st.execute(id_student)
  end

  def replace_student(id_student, student)
    stmt = client.prepare('UPDATE students SET first_name=?, middle_name=?, surname=?, phone_number=?, telegram=?, email=?, git=? WHERE id=?')
    stmt.execute(*student_attr(student), id_student)
  end

  def count_student
    st = self.client.prepare "Select COUNT(id) from students"
    st.execute.next[0]
  end

  def get_k_n_student_short_list(k,n)
    self.client.results_as_hash = true
    students = client.prepare('SELECT * FROM students LIMIT ? OFFSET ?').execute((k-1)*n,n)
    slice = students.map { |h| StudentShort.new(Student.from_hash(h)) }
    self.client.results_as_hash = false
    DataListStudentShort.new(slice)
  end

  private

  attr_accessor :client
  def student_attr(student)
    [student.first_name, student.middle_name, student.surname,
     student.phone_number, student.telegram,
     student.mail, student.git]
  end

end

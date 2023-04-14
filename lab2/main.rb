
require_relative 'student/student'
require_relative 'student/student_short'
require_relative 'all_data/data_table'
require 'yaml'
require 'sqlite3'
require_relative 'database/student_list_db'

student1 = Student.new(first_name:'Иван', middle_name:'Иванович' ,surname:'Иванов',id:1,phone_number:'+79285698741',
                       mail:'ivan555@yandex.ru', git:'github.com/vanSuper', telegram:'@Vanusha')

student2 = Student.new(first_name:'Илья',middle_name:'Александрович',surname:'Петров', id:2, phone_number:'+79285698741',
                       mail:'ilisha@mail.ru')


def read_from_txt(adress)
  if !File.exist?(adress)
    raise ArgumentError "This file '#{adress}' not found"
  else
    student_arr= Array.new
    file = File.new(adress, "r:UTF-8")
    lines = file.read.to_s.strip
    string_student=""
    lines.each_char do |ch|
      string_student+= ch
      if ch=='}'
        student_arr.append(Student.pars_str(string_student))
        string_student= ""
      end
    end
    file.close
  end
  student_arr

end

def write_to_txt(adress, arr_student)
  if !File.exist?(adress)
    raise ArgumentError "This file '#{adress}' not found"
  else
    result = '{ "StudentList":['
    arr_student.each do |student|
      result += student.to_json+ ","
    end
    result += result.chop + "]}"
    File.write(adress, result)
  end
end

#db = SQLite3::Database.open './university.sql'
#sel = db.prepare "Select * from students"
#result = sel.execute
#result.each {|th| puts th.join "\s"}

db = StudentListDBAdapter.new
puts db.count_student
puts db.student_by_id(8)


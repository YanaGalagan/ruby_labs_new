
require_relative 'student/student'
require_relative 'student/student_short'
require_relative 'all_data/data_table'

student1 = Student.new(first_name:'Иван', middle_name:'Иванович' ,surname:'Иванов',id:1,phone_number:'+79285698741',
                       mail:'ivan555@yandex.ru', git:'github.com/vanSuper', telegram:'@Vanusha')

student2 = Student.new(first_name:'Илья',middle_name:'Александрович',surname:'Петров', id:2, phone_number:'+79285698741',
                       mail:'ilisha@mail.ru')



# student2.set_contacts(telegram: '@petrov2002')


# puts student1.to_s
# puts student2.get_info

# student3 = StudentShort.new(student2)
# puts student3.to_s

#puts Student.pars_str('{"first_name":"Илья","middle_name":"Александрович",
#	"surname":"Петров", "id": 2, "phone_number":"+79285698741",
#	"mail":"ilisha@mail.ru"}')


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

#student_st= read_from_txt('test_read.txt')
#puts student_st
#student5 = StudentShort.new(student_st[0])
#puts student5

#student_list = [student1, student2]

#write_to_txt('output.txt', student_list)# frozen_string_literal: true
test = [[1,'Ура1'],[2,'Ура2']]
test_table=DataTable.new(test)
puts test_table
puts test_table.get_elem(0,1)

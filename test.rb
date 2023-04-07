# frozen_string_literal: true

require_relative 'student'
require_relative 'student_short'
require_relative 'data_list_student_short'
require_relative 'student_list_base'
require_relative 'student_list_txt'
require_relative 'student_list_json'
require_relative 'student_list_yaml'
require 'json'

student1 = Student.new(first_name:'Иван', middle_name:'Иванович' ,surname:'Иванов',id:1,phone_number:'+79285698741',
                       mail:'ivan555@yandex.ru', git:'github.com/vanSuper', telegram:'@Vanusha')

student2 = Student.new(first_name:'Илья',middle_name:'Александрович',surname:'Петров', id:2, phone_number:'+79285698741',
                       mail:'ilisha@mail.ru')
puts '--------------------------------'
puts 'Тест StudentsList (JSON):'

stud_list_json = StudentListBase.new(StudentListJson.new)
stud_list_json.add_student(student1)
stud_list_json.add_student(student2)
stud_list_json.save_to_file('students_save.json')

stud_list_json.load_from_file('students_save.json')

puts '--------------------------------'
puts 'Тест StudentsList (YAML):'

stud_list_yaml = StudentListBase.new(StudentListYaml.new)
stud_list_yaml.add_student(student1)
stud_list_yaml.add_student(student2)
stud_list_yaml.save_to_file('students_save.yaml')

stud_list_yaml.load_from_file('students_save.yaml')

puts '--------------------------------'
puts 'Тест StudentsList (TXT):'

stud_list_txt = StudentListBase.new(StudentListTxt.new)
stud_list_txt.add_student(student1)
stud_list_txt.add_student(student2)
stud_list_txt.save_to_file('students_save.txt')

stud_list_txt.load_from_file('students_save.txt')


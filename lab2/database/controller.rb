# frozen_string_literal: true
<<<<<<< HEAD
=======

>>>>>>> origin/master
require_relative 'window'
require_relative 'logic'
require_relative 'student_list'
require_relative 'student_list_db'
require_relative '../all_data/data_list_student_short'
<<<<<<< HEAD
=======
require 'glimmer-dsl-libui'

>>>>>>> origin/master
class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
  end

  def on_view_created
<<<<<<< HEAD
    @student_list=StudentList.new(StudentListDBAdapter.new)
=======
    @student_list = StudentList.new(StudentListDBAdapter.new)
>>>>>>> origin/master
  end

  def show_view
    @view.create.show
  end

<<<<<<< HEAD
  def refresh_data(k, n)
    @data_list = @student_list.get_k_n_student_short_list(k, n, @data_list)
    @view.update_student_count(@student_list.count_student)
  end
end
=======
  def refresh_data(k,n)
    begin
    @data_list = @student_list.k_n_student_short_list(k, n, @data_list)
    @view.update_student_count(@student_list.count_student)
    rescue
      on_db_conn_error
    end
  end
  def on_db_conn_error
    script = 'display dialog "Отсутсвует подключение к БД" with title "Ошибка"'
    system 'osascript', '-e', script
    exit(false)
  end
end
>>>>>>> origin/master

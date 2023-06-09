
require_relative 'window'
require_relative 'logic'
require_relative 'student_list'
require_relative 'student_list_db'
require_relative 'student_file_adapter'
require_relative '../strategy/student_list_json'
require_relative '../all_data/data_list_student_short'
require 'glimmer-dsl-libui'
require_relative 'student_create_form_controller'
require_relative 'student_edit_form_controller'
class StudentListController

  attr_reader :view
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
  end

  def on_view_created
    @student_list=StudentList.new(StudentListDBAdapter.new)
    #@student_list = StudentList.new(StudentFileAdapter.new(StudentListJson.new, './lab2/tests/students.json'))
  end

  def show_view
    @view.create.show
  end
  def show_add_student()
    controller = StudentCreateFormController.new(self)
    view = StudentCreateForm.new(controller)
    controller.view=view
    view.create.show
  end

  def show_edit_student(current_page, per_page, selected_row)
    student_num = (current_page - 1) * per_page + selected_row
    @data_list.select_elem(student_num)
    student_id = @data_list.selected_id
    controller = StudentEditFormController.new(self, student_id)
    view = StudentCreateForm.new(controller)
    controller.view=view
    view.create.show
  end
  def delete_selected(current_page, per_page, selected_row)
    #begin
    #student_num = (current_page - 1) * per_page + selected_row
    student_num=selected_row
    @data_list.select_elem(student_num)
    student_id = @data_list.selected_id
    @student_list.delete_student(student_id)
    #rescue
    #on_db_conn_error
    #end
  end
  def refresh_data(k, n)
    #Сформировать список исключительных ситуаций, который может возникнуть при выполнении включения программ
    #begin
    #raise StandardError, "Error DB"
    @data_list = @student_list.get_k_n_student_short_list(k, n, @data_list)
    @view.update_student_count(@student_list.count_student)
    #rescue
    #   on_db_conn_error
    #end
  end

  def on_db_conn_error
    api = Win32API.new('user32', 'MessageBox', ['L', 'P', 'P', 'L'], 'I')
    api.call(0, "No connection to DB", "Error", 0)
    exit(false)
  end
end
# frozen_string_literal: true
require_relative 'window'
require_relative 'logic'
require_relative 'student_list'
require_relative 'student_list_db'
require_relative '../all_data/data_list_student_short'
class StudentListController
  def initialize(view)
    @view = view
    @data_list = DataListStudentShort.new([])
    @data_list.add_observer(@view)
  end

  def on_view_created
    @student_list=StudentList.new(StudentListDBAdapter.new)
  end

  def show_view
    @view.create.show
  end

  def refresh_data(k, n)
    @data_list = @student_list.get_k_n_student_short_list(k, n, @data_list)
    @view.update_student_count(@student_list.count_student)
  end
end

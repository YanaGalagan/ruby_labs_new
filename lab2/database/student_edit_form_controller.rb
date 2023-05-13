# frozen_string_literal: true
class StudentEditFormController
  def initialize(parent_controller, existing_student_id)
    @parent_controller = parent_controller
    @existing_student_id = existing_student_id
  end

  def view=(view)
    @view = view
  end

  def on_view_created
    @student_list = StudentList.new(StudentListDBAdapter.new)
    @existing_student = @student_list.student_by_id(@existing_student_id)
    @view.make_readonly(:git, :telegram, :mail, :phone_number)
    set_fields(@existing_student)
  end

  def set_fields(student)
    student = student
    puts student
    @view.set_value(:first_name, student.first_name)
    @view.set_value(:middle_name, student.middle_name)
    @view.set_value(:surname, student.surname)
    @view.set_value(:git, student.git)
    @view.set_value(:telegram, student.telegram)
    @view.set_value(:mail, student.mail)
    @view.set_value(:phone_number, student.phone_number)
  end


  def process_fields(fields)
    new_student = Student.new(**fields)

    @student_list.replace_student(@existing_student_id, new_student)

    @view.close
  end
end

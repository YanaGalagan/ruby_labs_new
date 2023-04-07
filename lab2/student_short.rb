require 'json'

class StudentShort

  attr_reader :id,:surname,:short_name, :git, :contact

  def initialize(student)
    @id = student.id
    @surname = student.surname
    @short_name = "#{student.first_name[0]}. #{student.middle_name[0]}."
    @git = student.git unless student.git.nil?
    @contact = student.set_contacts(phone_number: student.phone_number, mail:student.mail,telegram: student.telegram)
  end

  def self.from_str(id,str)
    res = JSON.parse(str)

    Student_Short.new(Student.new(first_name: res['fisrst_name'],
                                  middle_name:res['middle_name'], surname:res['surname'], id:id,
                                  phone_number: result['phone_number'], git: result['git'],
                                  mail: result['mail'],telegram: result['telegram']))
  end

  def to_s
    res = short_name_initials
    res += " id=#{id}" unless id.nil?
    res += " git=#{git}" unless git.nil?
    res += " #{contact}" unless contact.nil?
    res
  end

  def short_name_initials
    "#{@surname} #{@short_name}"
  end

  #валидатор
  def validate?
    exist_git? and exist_contact?
  end

  def exist_git?
    !self.git.nil?
  end

  def exist_contact?
    !(self.phone_number.nil? and self.telegram.nil? and self.mail.nil?)
  end
end
# frozen_string_literal: true

